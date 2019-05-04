#!/bin/bash

version=$1

if [ -z "$version" ]; then
	echo "Usage: bash package.sh VERSION"
	exit 1
fi

if git diff --exit-code --quiet; then
	echo >/dev/null
else
	echo "Commit your changes"
	exit 1
fi

dir=$(cd "$(dirname "$0")/.."; pwd)
tmp=$(mktemp -d)
origin=$(cd "$dir"; git remote get-url origin)

(
	cd "$dir"
	sed -i '' "s/spec.version = \"\([^\"]*\)\"/spec.version = \"$version\"/g" PathOps.podspec
	git add PathOps.podspec
	git commit -m "Bump version to $version"
)

(
	cd "$tmp"
	git clone "$dir" PathOps
	(
		cd PathOps
		git remote add github "$origin"
		git fetch github
		git checkout -b release github/release
	)
)

(
	cd "$dir"
	for file in $(git ls-files); do
		d=$(dirname "$file")
		mkdir -p "$tmp/PathOps/$d"
		if [ -f "$dir/$file" ]; then
			cp "$dir/$file" "$tmp/PathOps/$file"
		fi
	done
)

(
	cd "$tmp/PathOps"
	rm -rf Source/third_party .gitmodules tool
	for file in $((cat "$dir/PathOps.podspec" | grep -e "^third_party_source_files =" -e "^third_party_header_files =" | sed 's/.*\[\(.*\)\].*/\1/g') | tr -d , | tr -d '"'); do
		d=$(dirname $file)
		mkdir -p "$d"
		cp "$dir/$file" "./$file"
	done

	git add . -A
	git commit -m "Package version $version"
	git push origin release
	git tag -f "$version"
	git push -f origin "$version"
)

if [ -n "$tmp" ]; then
	rm -rf "$tmp"
fi
