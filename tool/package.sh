#!/bin/bash

version=$1

if [ -z "$version" ]; then
	echo "Usage: bash package.sh VERSION"
	exit 1
fi

dir=$(cd "$(dirname "$0")/.."; pwd)
tmp=$(mktemp -d)

(
	cd "$tmp"
	git clone "$dir" PathOps
	(
		cd PathOps
		git checkout release
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
	git tag "$version"
	git push origin "$version"
)

if [ -n "$tmp" ]; then
	rm -rf "$tmp"
fi
