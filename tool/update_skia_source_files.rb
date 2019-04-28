require 'xcodeproj'

project = Xcodeproj::Project.open('PathOps.xcodeproj')
root = Pathname.getwd / "PathOps/third_party"

target = project.targets.select { |t| t.name == 'PathOps' }.first
skia_source_files = target.source_build_phase.files_references.map { |r|
	r.real_path.relative_path_from(root)
} .select { |s|
  not s.to_s.start_with? '..'
}.map { |s|
  "\"PathOps/third_party/#{s.to_s}\""
}.join(", ")

`sed -i '' 's:^skia_source_files = .*$:skia_source_files = [#{skia_source_files}]:g' PathOps.podspec`
