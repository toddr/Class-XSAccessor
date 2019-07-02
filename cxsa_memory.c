
#include "cxsa_memory.h"

void* _cxa_memcpy(void *dest, void *src, STRLEN size) {
    return memcpy(dest, src, size);
}

void* _cxa_memzero(void *ptr, STRLEN size) {
    return memset(ptr, 0, size);
}

