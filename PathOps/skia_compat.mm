#include "include/private/SkMalloc.h"
#include "src/core/SkSafeMath.h"

void* sk_malloc_throw(size_t count, size_t elemSize) {
    return sk_malloc_throw(SkSafeMath::Mul(count, elemSize));
}
