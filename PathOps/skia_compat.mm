#include "include/private/SkMalloc.h"
#include "src/core/SkSafeMath.h"
#include "include/private/SkImageInfoPriv.h"

void* sk_malloc_throw(size_t count, size_t elemSize) {
    return sk_malloc_throw(SkSafeMath::Mul(count, elemSize));
}

int SkColorTypeBytesPerPixel(SkColorType ct) {
    switch (ct) {
        case kUnknown_SkColorType:      return 0;
        case kAlpha_8_SkColorType:      return 1;
        case kRGB_565_SkColorType:      return 2;
        case kARGB_4444_SkColorType:    return 2;
        case kRGBA_8888_SkColorType:    return 4;
        case kBGRA_8888_SkColorType:    return 4;
        case kRGB_888x_SkColorType:     return 4;
        case kRGBA_1010102_SkColorType: return 4;
        case kRGB_101010x_SkColorType:  return 4;
        case kGray_8_SkColorType:       return 1;
        case kRGBA_F16Norm_SkColorType: return 8;
        case kRGBA_F16_SkColorType:     return 8;
        case kRGBA_F32_SkColorType:     return 16;
    }
    return 0;
}

int SkImageInfo::bytesPerPixel() const { return SkColorTypeBytesPerPixel(fColorType); }
