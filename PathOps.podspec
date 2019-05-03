# Update this line by: ruby tool/update_third_party_source_files.rb
third_party_source_files = ["Source/third_party/skia/src/core/SkArenaAlloc.cpp", "Source/third_party/skia/src/core/SkBuffer.cpp", "Source/third_party/skia/src/core/SkColor.cpp", "Source/third_party/skia/src/core/SkCpu.cpp", "Source/third_party/skia/src/core/SkCubicClipper.cpp", "Source/third_party/skia/src/core/SkGeometry.cpp", "Source/third_party/skia/src/core/SkMath.cpp", "Source/third_party/skia/src/core/SkMatrix.cpp", "Source/third_party/skia/src/core/SkOpts.cpp", "Source/third_party/skia/src/core/SkPath.cpp", "Source/third_party/skia/src/core/SkPathRef.cpp", "Source/third_party/skia/src/core/SkPoint.cpp", "Source/third_party/skia/src/core/SkRRect.cpp", "Source/third_party/skia/src/core/SkRect.cpp", "Source/third_party/skia/src/core/SkSemaphore.cpp", "Source/third_party/skia/src/core/SkString.cpp", "Source/third_party/skia/src/core/SkStringUtils.cpp", "Source/third_party/skia/src/core/SkStroke.cpp", "Source/third_party/skia/src/core/SkStrokeRec.cpp", "Source/third_party/skia/src/core/SkStrokerPriv.cpp", "Source/third_party/skia/src/core/SkThreadID.cpp", "Source/third_party/skia/src/core/SkUtils.cpp", "Source/third_party/skia/src/opts/SkOpts_avx.cpp", "Source/third_party/skia/src/opts/SkOpts_crc32.cpp", "Source/third_party/skia/src/opts/SkOpts_hsw.cpp", "Source/third_party/skia/src/opts/SkOpts_sse41.cpp", "Source/third_party/skia/src/opts/SkOpts_sse42.cpp", "Source/third_party/skia/src/pathops/SkAddIntersections.cpp", "Source/third_party/skia/src/pathops/SkDConicLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkDCubicLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkDCubicToQuads.cpp", "Source/third_party/skia/src/pathops/SkDLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkDQuadLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkIntersections.cpp", "Source/third_party/skia/src/pathops/SkOpAngle.cpp", "Source/third_party/skia/src/pathops/SkOpBuilder.cpp", "Source/third_party/skia/src/pathops/SkOpCoincidence.cpp", "Source/third_party/skia/src/pathops/SkOpContour.cpp", "Source/third_party/skia/src/pathops/SkOpCubicHull.cpp", "Source/third_party/skia/src/pathops/SkOpEdgeBuilder.cpp", "Source/third_party/skia/src/pathops/SkOpSegment.cpp", "Source/third_party/skia/src/pathops/SkOpSpan.cpp", "Source/third_party/skia/src/pathops/SkPathOpsAsWinding.cpp", "Source/third_party/skia/src/pathops/SkPathOpsCommon.cpp", "Source/third_party/skia/src/pathops/SkPathOpsConic.cpp", "Source/third_party/skia/src/pathops/SkPathOpsCubic.cpp", "Source/third_party/skia/src/pathops/SkPathOpsCurve.cpp", "Source/third_party/skia/src/pathops/SkPathOpsDebug.cpp", "Source/third_party/skia/src/pathops/SkPathOpsLine.cpp", "Source/third_party/skia/src/pathops/SkPathOpsOp.cpp", "Source/third_party/skia/src/pathops/SkPathOpsQuad.cpp", "Source/third_party/skia/src/pathops/SkPathOpsRect.cpp", "Source/third_party/skia/src/pathops/SkPathOpsSimplify.cpp", "Source/third_party/skia/src/pathops/SkPathOpsTSect.cpp", "Source/third_party/skia/src/pathops/SkPathOpsTightBounds.cpp", "Source/third_party/skia/src/pathops/SkPathOpsTypes.cpp", "Source/third_party/skia/src/pathops/SkPathOpsWinding.cpp", "Source/third_party/skia/src/pathops/SkPathWriter.cpp", "Source/third_party/skia/src/pathops/SkReduceOrder.cpp", "Source/third_party/skia/src/ports/SkDebug_stdio.cpp", "Source/third_party/skia/src/ports/SkMemory_malloc.cpp", "Source/third_party/skia/src/ports/SkOSFile_posix.cpp", "Source/third_party/skia/src/ports/SkOSFile_stdio.cpp", "Source/third_party/skia/src/utils/SkUTF.cpp"]

Pod::Spec.new do |spec|
  spec.name = "PathOps"
  spec.version = "0.0.1"
  spec.summary = "Boolean operation library for CGPath with skia https://skia.org/ backend."
  spec.description = <<-DESC
  Boolean operation library for CGPath with skia https://skia.org/ backend
                   DESC
  spec.homepage = "https://github.com/kbinani/PathOps"
  spec.license = "MIT"
  spec.author = { "kbinani" => "kbinani.bt@gmail.com" }

  spec.source = { :git => "https://github.com/kbinani/PathOps.git", :tag => "#{spec.version}" }
  spec.source_files = ["Source/*.{h,mm,swift}"] + third_party_source_files
  spec.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/Source/third_party/skia $(PODS_TARGET_SRCROOT)/Source/third_party/skia/third_party/skcms $(PODS_TARGET_SRCROOT)/Source/third_party',
    'OTHER_CFLAGS' => '-Wno-documentation',
  }

  spec.frameworks = "Foundation", "CoreGraphics"
end
