# Update this line by: ruby tool/update_third_party_source_files.rb
third_party_source_files = ["Source/third_party/skia/src/core/SkArenaAlloc.cpp", "Source/third_party/skia/src/core/SkBuffer.cpp", "Source/third_party/skia/src/core/SkColor.cpp", "Source/third_party/skia/src/core/SkCpu.cpp", "Source/third_party/skia/src/core/SkCubicClipper.cpp", "Source/third_party/skia/src/core/SkGeometry.cpp", "Source/third_party/skia/src/core/SkMath.cpp", "Source/third_party/skia/src/core/SkMatrix.cpp", "Source/third_party/skia/src/core/SkOpts.cpp", "Source/third_party/skia/src/core/SkPath.cpp", "Source/third_party/skia/src/core/SkPathRef.cpp", "Source/third_party/skia/src/core/SkPoint.cpp", "Source/third_party/skia/src/core/SkRRect.cpp", "Source/third_party/skia/src/core/SkRect.cpp", "Source/third_party/skia/src/core/SkSemaphore.cpp", "Source/third_party/skia/src/core/SkString.cpp", "Source/third_party/skia/src/core/SkStringUtils.cpp", "Source/third_party/skia/src/core/SkStroke.cpp", "Source/third_party/skia/src/core/SkStrokeRec.cpp", "Source/third_party/skia/src/core/SkStrokerPriv.cpp", "Source/third_party/skia/src/core/SkThreadID.cpp", "Source/third_party/skia/src/core/SkUtils.cpp", "Source/third_party/skia/src/opts/SkOpts_avx.cpp", "Source/third_party/skia/src/opts/SkOpts_crc32.cpp", "Source/third_party/skia/src/opts/SkOpts_hsw.cpp", "Source/third_party/skia/src/opts/SkOpts_sse41.cpp", "Source/third_party/skia/src/opts/SkOpts_sse42.cpp", "Source/third_party/skia/src/pathops/SkAddIntersections.cpp", "Source/third_party/skia/src/pathops/SkDConicLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkDCubicLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkDCubicToQuads.cpp", "Source/third_party/skia/src/pathops/SkDLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkDQuadLineIntersection.cpp", "Source/third_party/skia/src/pathops/SkIntersections.cpp", "Source/third_party/skia/src/pathops/SkOpAngle.cpp", "Source/third_party/skia/src/pathops/SkOpBuilder.cpp", "Source/third_party/skia/src/pathops/SkOpCoincidence.cpp", "Source/third_party/skia/src/pathops/SkOpContour.cpp", "Source/third_party/skia/src/pathops/SkOpCubicHull.cpp", "Source/third_party/skia/src/pathops/SkOpEdgeBuilder.cpp", "Source/third_party/skia/src/pathops/SkOpSegment.cpp", "Source/third_party/skia/src/pathops/SkOpSpan.cpp", "Source/third_party/skia/src/pathops/SkPathOpsAsWinding.cpp", "Source/third_party/skia/src/pathops/SkPathOpsCommon.cpp", "Source/third_party/skia/src/pathops/SkPathOpsConic.cpp", "Source/third_party/skia/src/pathops/SkPathOpsCubic.cpp", "Source/third_party/skia/src/pathops/SkPathOpsCurve.cpp", "Source/third_party/skia/src/pathops/SkPathOpsDebug.cpp", "Source/third_party/skia/src/pathops/SkPathOpsLine.cpp", "Source/third_party/skia/src/pathops/SkPathOpsOp.cpp", "Source/third_party/skia/src/pathops/SkPathOpsQuad.cpp", "Source/third_party/skia/src/pathops/SkPathOpsRect.cpp", "Source/third_party/skia/src/pathops/SkPathOpsSimplify.cpp", "Source/third_party/skia/src/pathops/SkPathOpsTSect.cpp", "Source/third_party/skia/src/pathops/SkPathOpsTightBounds.cpp", "Source/third_party/skia/src/pathops/SkPathOpsTypes.cpp", "Source/third_party/skia/src/pathops/SkPathOpsWinding.cpp", "Source/third_party/skia/src/pathops/SkPathWriter.cpp", "Source/third_party/skia/src/pathops/SkReduceOrder.cpp", "Source/third_party/skia/src/ports/SkDebug_stdio.cpp", "Source/third_party/skia/src/ports/SkMemory_malloc.cpp", "Source/third_party/skia/src/ports/SkOSFile_posix.cpp", "Source/third_party/skia/src/ports/SkOSFile_stdio.cpp", "Source/third_party/skia/src/utils/SkUTF.cpp"]
third_party_header_files = ["Source/third_party/skia/include/core/SkPath.h", "Source/third_party/skia/include/core/SkRegion.h", "Source/third_party/skia/include/core/SkStrokeRec.h", "Source/third_party/skia/include/pathops/SkPathOps.h", "Source/third_party/skia/src/core/SkGeometry.h", "Source/third_party/skia/src/core/SkStroke.h", "Source/third_party/skia/include/private/SkImageInfoPriv.h", "Source/third_party/skia/include/private/SkMalloc.h", "Source/third_party/skia/src/core/SkSafeMath.h", "Source/third_party/skia/include/core/SkPaint.h", "Source/third_party/skia/include/private/SkArenaAlloc.h", "Source/third_party/skia/src/core/SkBuffer.h", "Source/third_party/skia/include/core/SkColor.h", "Source/third_party/skia/include/private/SkColorData.h", "Source/third_party/skia/include/private/SkFixed.h", "Source/third_party/skia/include/private/SkOnce.h", "Source/third_party/skia/src/core/SkCpu.h", "Source/third_party/skia/src/core/SkCubicClipper.h", "Source/third_party/skia/include/core/SkMatrix.h", "Source/third_party/skia/include/core/SkPoint3.h", "Source/third_party/skia/include/private/SkNx.h", "Source/third_party/skia/src/core/SkPointPriv.h", "Source/third_party/skia/src/pathops/SkPathOpsCubic.h", "Source/third_party/skia/include/core/SkScalar.h", "Source/third_party/skia/include/private/SkFloatBits.h", "Source/third_party/skia/include/private/SkFloatingPoint.h", "Source/third_party/skia/src/core/SkMathPriv.h", "Source/third_party/skia/include/core/SkRSXform.h", "Source/third_party/skia/include/core/SkString.h", "Source/third_party/skia/include/private/SkTo.h", "Source/third_party/skia/src/core/SkMatrixPriv.h", "Source/third_party/skia/src/core/SkMatrixUtils.h", "Source/third_party/skia/include/private/SkHalf.h", "Source/third_party/skia/src/core/SkOpts.h", "Source/third_party/skia/src/opts/SkBitmapProcState_opts.h", "Source/third_party/skia/src/opts/SkBlitMask_opts.h", "Source/third_party/skia/src/opts/SkBlitRow_opts.h", "Source/third_party/skia/src/opts/SkChecksum_opts.h", "Source/third_party/skia/src/opts/SkRasterPipeline_opts.h", "Source/third_party/skia/src/opts/SkSwizzler_opts.h", "Source/third_party/skia/src/opts/SkUtils_opts.h", "Source/third_party/skia/src/opts/SkXfermode_opts.h", "Source/third_party/skia/include/core/SkData.h", "Source/third_party/skia/include/core/SkMath.h", "Source/third_party/skia/include/core/SkRRect.h", "Source/third_party/skia/include/core/SkStream.h", "Source/third_party/skia/include/private/SkMacros.h", "Source/third_party/skia/include/private/SkPathRef.h", "Source/third_party/skia/src/core/SkPathPriv.h", "Source/third_party/skia/src/core/SkStringUtils.h", "Source/third_party/skia/src/core/SkTLazy.h", "Source/third_party/skia/src/core/SkRRectPriv.h", "Source/third_party/skia/src/core/SkScaleToSides.h", "Source/third_party/skia/include/core/SkRect.h", "Source/third_party/skia/include/private/SkLeanWindows.h", "Source/third_party/skia/include/private/SkSemaphore.h", "Source/third_party/skia/src/core/SkUtils.h", "Source/third_party/skia/src/utils/SkUTF.h", "Source/third_party/skia/src/core/SkPaintDefaults.h", "Source/third_party/skia/src/core/SkStrokerPriv.h", "Source/third_party/skia/include/private/SkThreadID.h", "Source/third_party/skia/src/pathops/SkAddIntersections.h", "Source/third_party/skia/src/pathops/SkOpCoincidence.h", "Source/third_party/skia/src/pathops/SkPathOpsBounds.h", "Source/third_party/skia/src/pathops/SkIntersections.h", "Source/third_party/skia/src/pathops/SkPathOpsConic.h", "Source/third_party/skia/src/pathops/SkPathOpsCurve.h", "Source/third_party/skia/src/pathops/SkPathOpsLine.h", "Source/third_party/skia/src/pathops/SkPathOpsQuad.h", "Source/third_party/skia/src/core/SkTSort.h", "Source/third_party/skia/src/pathops/SkOpAngle.h", "Source/third_party/skia/src/pathops/SkOpSegment.h", "Source/third_party/skia/src/pathops/SkOpEdgeBuilder.h", "Source/third_party/skia/src/pathops/SkPathOpsCommon.h", "Source/third_party/skia/src/pathops/SkPathOpsTSect.h", "Source/third_party/skia/src/pathops/SkOpContour.h", "Source/third_party/skia/src/pathops/SkPathWriter.h", "Source/third_party/skia/src/pathops/SkReduceOrder.h", "Source/third_party/skia/src/pathops/SkLineParameters.h", "Source/third_party/skia/src/pathops/SkPathOpsRect.h", "Source/third_party/skia/include/core/SkBitmap.h", "Source/third_party/skia/include/core/SkCanvas.h", "Source/third_party/skia/include/private/SkMutex.h", "Source/third_party/skia/src/core/SkOSFile.h", "Source/third_party/skia/src/pathops/SkIntersectionHelper.h", "Source/third_party/skia/src/pathops/SkPathOpsDebug.h", "Source/third_party/skia/src/pathops/SkPathOpsTypes.h", "Source/third_party/skia/src/pathops/SkOpSpan.h", "Source/third_party/skia/src/pathops/SkPathOpsPoint.h", "Source/third_party/skia/include/core/SkTypes.h", "Source/third_party/skia/include/private/SkTFitsIn.h", "Source/third_party/skia/include/private/SkTemplates.h", "Source/third_party/skia/src/ports/SkOSFile_ios.h", "Source/third_party/skia/include/core/SkPreConfig.h", "Source/third_party/skia/include/private/SkTArray.h", "Source/third_party/skia/include/private/SkTDArray.h", "Source/third_party/skia/include/core/SkPoint.h", "Source/third_party/skia/include/core/SkImageInfo.h", "Source/third_party/skia/include/core/SkBlendMode.h", "Source/third_party/skia/include/core/SkFilterQuality.h", "Source/third_party/skia/include/core/SkRefCnt.h", "Source/third_party/skia/include/private/SkNoncopyable.h", "Source/third_party/skia/include/core/SkColorPriv.h", "Source/third_party/skia/include/private/SkSafe_math.h", "Source/third_party/skia/include/private/SkNx_neon.h", "Source/third_party/skia/include/private/SkNx_sse.h", "Source/third_party/skia/src/pathops/SkPathOpsTCurve.h", "Source/third_party/skia/include/core/SkSize.h", "Source/third_party/skia/src/core/SkRasterPipeline.h", "Source/third_party/skia/src/core/SkXfermodePriv.h", "Source/third_party/skia/src/core/SkBitmapProcState.h", "Source/third_party/skia/src/core/Sk4px.h", "Source/third_party/skia/include/private/SkVx.h", "Source/third_party/skia/src/core/SkMSAN.h", "Source/third_party/skia/include/private/SkChecksum.h", "Source/third_party/skia/include/private/SkSafe32.h", "Source/third_party/skia/include/core/SkFontTypes.h", "Source/third_party/skia/include/core/SkPixmap.h", "Source/third_party/skia/include/core/SkTileMode.h", "Source/third_party/skia/include/core/SkClipOp.h", "Source/third_party/skia/include/core/SkDeque.h", "Source/third_party/skia/include/core/SkRasterHandleAllocator.h", "Source/third_party/skia/include/core/SkSurfaceProps.h", "Source/third_party/skia/include/core/SkVertices.h", "Source/third_party/skia/src/core/SkTLS.h", "Source/third_party/skia/include/config/SkUserConfig.h", "Source/third_party/skia/include/core/SkPostConfig.h", "Source/third_party/skia/include/private/SkTLogic.h", "Source/third_party/skia/include/core/SkColorSpace.h", "Source/third_party/skia/include/core/SkShader.h", "Source/third_party/skia/src/core/SkBitmapController.h", "Source/third_party/skia/src/core/SkBitmapProvider.h", "Source/third_party/skia/src/core/SkMipMap.h", "Source/third_party/skia/src/opts/Sk4px_NEON.h", "Source/third_party/skia/src/opts/Sk4px_SSE2.h", "Source/third_party/skia/src/opts/Sk4px_none.h", "Source/third_party/skia/include/core/SkMatrix44.h", "Source/third_party/skia/include/third_party/skcms/skcms.h", "Source/third_party/skia/include/core/SkFlattenable.h", "Source/third_party/skia/src/core/SkBitmapCache.h", "Source/third_party/skia/include/core/SkImage.h", "Source/third_party/skia/src/core/SkCachedData.h", "Source/third_party/skia/src/shaders/SkShaderBase.h", "Source/third_party/skia/include/core/SkImageEncoder.h", "Source/third_party/skia/include/gpu/GrTypes.h", "Source/third_party/skia/src/core/SkEffectPriv.h", "Source/third_party/skia/src/core/SkMask.h", "Source/third_party/skia/src/gpu/GrFPArgs.h", "Source/third_party/skia/include/core/SkEncodedImageFormat.h", "Source/third_party/skia/include/gpu/GrConfig.h"]

Pod::Spec.new do |spec|
  spec.name = "PathOps"
  spec.version = "0.0.1"
  spec.summary = "Boolean operation library for CGPath with skia https://skia.org/ backend."
  spec.description = <<-DESC
  Boolean operation library for CGPath with skia https://skia.org/ backend
                   DESC
  spec.homepage = "https://github.com/kbinani/PathOps"
  spec.license = "BSD"
  spec.author = { "kbinani" => "kbinani.bt@gmail.com" }

  spec.source = { :git => "https://github.com/kbinani/PathOps.git", :tag => "#{spec.version}" }
  spec.source_files = ["Source/*.{h,mm,swift}"] + third_party_source_files
  spec.pod_target_xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/Source/third_party/skia $(PODS_TARGET_SRCROOT)/Source/third_party/skia/third_party/skcms $(PODS_TARGET_SRCROOT)/Source/third_party',
    'OTHER_CFLAGS' => '-Wno-documentation',
  }

  spec.ios.deployment_target = "9.0"

  spec.frameworks = "Foundation", "CoreGraphics"
end
