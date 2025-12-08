#include <stdio.h>

#include "memory_debug.h"

void *f_debug_memory_malloc(unsigned int size, const char *file_name, unsigned int line_num)
{
#undef malloc
	void *ptr = NULL;

	ptr = malloc(size);

	if (ptr == NULL) {
		printf("MEM ERROR: malloc returns NULL when trying to allocate %u bytes at line %u in file %s\n",
		       size, line_num, file_name);
		exit(0);
	}

	printf("%p malloc %u bytes of memory at line %u in file %s\n", ptr, size, line_num,
	       file_name);
	return ptr;
}

void *f_debug_memory_calloc(unsigned int num, unsigned int size, const char *file_name,
			    unsigned int line_num)
{
#undef calloc
	void *ptr = calloc(num, size);
	if (ptr == NULL) {
		printf("MEM ERROR: calloc returns NULL when trying to allocate %u bytes at line %u in file %s\n",
		       size, line_num, file_name);
		exit(0);
	}
	printf("%p calloc %u * %u bytes of memory at line %u in file %s\n", ptr, num, size,
	       line_num, file_name);
	return ptr;
}

void *f_debug_memory_realloc(void *ptr, unsigned int size, const char *file_name, unsigned int line_num)
{
#undef realloc
	void *new_ptr = realloc(ptr, size);
	if (new_ptr == NULL) {
		printf("MEM ERROR: realloc returns NULL when trying to allocate %u bytes at line %u in file %s\n",
		       size, line_num, file_name);
		exit(0);
	}
	printf("%p realloc %u bytes of memory at line %u in file %s\n", new_ptr, size, line_num, file_name);
	return new_ptr;
}

void f_debug_memory_free(void *ptr, const char *file_name, unsigned int line_num)
{
#undef free
	printf("%p freed at line %u in file %s\n", ptr, line_num, file_name);
	free(ptr);
}
