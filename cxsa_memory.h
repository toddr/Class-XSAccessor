#ifndef _cxsa_memory_h_
#define _cxsa_memory_h_

#include "EXTERN.h"
/* for the STRLEN typedef, for better or for worse */
#include "perl.h"

void* _cxa_memcpy(void *dest, void *src, STRLEN size);
void* _cxa_memzero(void *ptr, STRLEN size);

/* these macros are really what you should be calling: */

#define cxa_free(ptr) Safefree(ptr)
#define cxa_malloc(v,n,t) Newx(v,n,t)
#define cxa_zmalloc(v,n,t) Newxz(v,n,t)
#define cxa_realloc(v,n,t) Renew(v,n,t)

#define cxa_memcpy(dest, src, size) _cxa_memcpy(dest, src, size)
#define cxa_memzero(ptr, size) _cxa_memzero(ptr, size)

/* TODO: A function call on every memory operation seems expensive.
 *       Right now, it's not so bad and benchmarks show no harm done.
 *       The hit should really only matter during global destruction and
 *       BEGIN{} when accessors are set up.
 */

#endif
