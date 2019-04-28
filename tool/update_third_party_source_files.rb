require 'xcodeproj'

project = Xcodeproj::Project.open('PathOps.xcodeproj')
subdir = 'PathOps/third_party'
root = Pathname.getwd / subdir

target = project.targets.select { |t| t.name == 'PathOps' }.first
third_party_source_files = target.source_build_phase.files_references.map { |r|
  r.real_path.relative_path_from(root)
}.select { |s|
  not s.to_s.start_with? '..'
}.map { |s|
  "\"#{subdir}/#{s.to_s}\""
}.join(", ")

`sed -i '' 's:^third_party_source_files = .*$:third_party_source_files = [#{third_party_source_files}]:g' PathOps.podspec`
