require 'xcodeproj'

project = Xcodeproj::Project.open('PathOps.xcodeproj')
subdir = 'Source/third_party'
root = Pathname.getwd / subdir

target = project.targets.select { |t| t.name == 'Example' }.first
third_party_source_files = target.source_build_phase.files_references.map { |r|
  r.real_path.relative_path_from(root)
}.select { |s|
  not s.to_s.start_with? '..'
}.map { |s|
  "#{subdir}/#{s.to_s}"
}.sort

def find_header(file, result, prefix)
  files = File.open(file, "r") { |fp|
    fp.read
  }.lines.select { |line|
    line.include?('#include')
  }.map { |line|
    line.gsub(/^[ ]*/, '').gsub(/#include[ ]*/, '')
  }.select { |line|
    not line.include?('<')
  }.map { |line|
    "#{prefix}/#{line.chomp.gsub(/"/, '')}"
  }.select { |line|
    File.exist?(line)
  }.sort.uniq

  result << files
  result.flatten!
  result.uniq!
end

result = third_party_source_files.select { |file|
  file.start_with?('Source/third_party/skia')
}.uniq.sort

t = []
`git ls-files | grep -e '\\.mm$' -e '\\.h$'`.lines.map { |f|
  f.chomp
}.each { |f|
  find_header(f, t, "Source/third_party")
  find_header(f, t, "Source/third_party/skia")
}
result << t
result.flatten!
result.uniq!

while true do
  tmp = result
  result.each { |file|
    find_header(file, tmp, "Source/third_party/skia")
  }
  break if tmp == result
  result = tmp
end

`sed -i '' 's:^third_party_source_files = .*$:third_party_source_files = [#{result.select { |s| !s.end_with?('.h') }.map { |s| "\"#{s}\"" }.join(", ")}]:g' PathOps.podspec`
`sed -i '' 's:^third_party_header_files = .*$:third_party_header_files = [#{result.select { |s| s.end_with?('.h') }.map { |s| "\"#{s}\"" }.join(", ")}]:g' PathOps.podspec`
