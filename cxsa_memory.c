
#include "cxsa_memory.h"

void* _cxa_memzero(void *ptr, STRLEN size) {
    return memset(ptr, 0, size);
}

