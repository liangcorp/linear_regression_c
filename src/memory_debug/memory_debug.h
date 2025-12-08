#pragma once

#include <stdlib.h>

#ifdef F_MEMORY_DEBUG

#define malloc(size) f_debug_memory_malloc(size, __FILE__, __LINE__)
#define calloc(num, size) f_debug_memory_calloc(num, size, __FILE__, __LINE__)
#define realloc(ptr, size) f_debug_memory_realloc(ptr, size, __FILE__, __LINE__)
#define free(ptr) f_debug_memory_free(ptr, __FILE__, __LINE__)

void *f_debug_memory_malloc(unsigned int size, const char *file_name, unsigned int line_num);
void *f_debug_memory_calloc(unsigned int num, unsigned int size, const char *file_name,
			    unsigned int line_num);
void *f_debug_memory_realloc(void *ptr, unsigned int size, const char *file_name, unsigned int line_num);
void f_debug_memory_free(void *ptr, const char *file_name, unsigned int line_num);

#endif
