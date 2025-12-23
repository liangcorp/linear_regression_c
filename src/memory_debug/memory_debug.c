#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#include "bool.h"
#include "memory_debug.h"

MemAllocRecordType mem_alloc_record;
MemAllocRecordListType mem_alloc_record_list;

pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

void *f_debug_memory_malloc(unsigned int size, const char *file, unsigned int line)
{
#undef malloc
	int i;
	void *ptr = NULL;

	pthread_mutex_lock(&lock);

	ptr = malloc(size);

	if (ptr == NULL) {
		printf("MEM ERROR: malloc returns NULL when trying to allocate %u bytes at line %u in file %s\n",
		       size, line, file);
		exit(1);
	}

	printf("%p malloc %u bytes of memory at line %u in file %s\n", ptr, size, line,
	       file);

	for (i = 0; i < LIST_SIZE; i++) {
		if (mem_alloc_record_list.m[i].ptr_value == NULL) {
			mem_alloc_record_list.m[i].ptr_value = ptr;
			mem_alloc_record_list.m[i].allocation_line = line;
			strncpy(mem_alloc_record_list.m[i].allocation_file, file,
				FILENAME_SIZE_LIMIT);
			mem_alloc_record_list.occurrences++;
			break;
		}
	}

	pthread_mutex_unlock(&lock);

	return ptr;
}

void *f_debug_memory_calloc(unsigned int num, unsigned int size, const char *file,
			    unsigned int line)
{
#undef calloc
	int i;
	void *ptr = NULL;

	pthread_mutex_lock(&lock);

	ptr = calloc(num, size);

	if (ptr == NULL) {
		printf("MEM ERROR: calloc returns NULL when trying to allocate %u bytes at line %u in file %s\n",
		       size, line, file);
		exit(1);
	}
	printf("%p calloc %u * %u bytes of memory at line %u in file %s\n", ptr, num,
	       size, line, file);

	for (i = 0; i < LIST_SIZE; i++) {
		if (mem_alloc_record_list.m[i].ptr_value == NULL) {
			mem_alloc_record_list.m[i].ptr_value = ptr;
			mem_alloc_record_list.m[i].allocation_line = line;
			strncpy(mem_alloc_record_list.m[i].allocation_file, file,
				FILENAME_SIZE_LIMIT);

			mem_alloc_record_list.occurrences++;
			break;
		}
	}

	pthread_mutex_unlock(&lock);

	return ptr;
}

void *f_debug_memory_realloc(void *ptr, unsigned int size, const char *file,
			     unsigned int line)
{
#undef realloc
	int i;
	void *new_ptr = NULL;

	pthread_mutex_lock(&lock);

	new_ptr = realloc(ptr, size);

	if (new_ptr == NULL) {
		printf("MEM ERROR: realloc returns NULL when trying to allocate %u bytes at line %u in file %s\n",
		       size, line, file);
		exit(1);
	}
	printf("%p to %p realloc %u bytes of memory at line %u in file %s\n", ptr,
	       new_ptr, size, line, file);

	for (i = 0; i < LIST_SIZE; i++) {
		if (mem_alloc_record_list.m[i].ptr_value == ptr) {
			mem_alloc_record_list.m[i].ptr_value = new_ptr;
			mem_alloc_record_list.m[i].allocation_line = line;
			strncpy(mem_alloc_record_list.m[i].allocation_file, file,
				FILENAME_SIZE_LIMIT);
			break;
		}
	}

	pthread_mutex_unlock(&lock);

	return new_ptr;
}

void f_debug_memory_free(void *ptr, const char *file, unsigned int line)
{
#undef free
	int i;
	bool is_found = false;

	pthread_mutex_lock(&lock);

	for (i = 0; i < LIST_SIZE; i++) {
		if (mem_alloc_record_list.m[i].ptr_value == ptr) {
			mem_alloc_record_list.m[i].ptr_value = NULL;
			mem_alloc_record_list.occurrences--;
			is_found = true;
			break;
		}
	}

	if (is_found) {
		printf("%p freed at line %u in file %s\n", ptr, line, file);
	} else {
		printf("Possible double free of %p at line %u in file %s\n", ptr, line,
		       file);
	}

	free(ptr);

	pthread_mutex_unlock(&lock);
}

void f_debug_memory_debug_init(void)
{
	int i;

	mem_alloc_record.ptr_value = NULL;
	mem_alloc_record.allocation_line = 0;
	memset(mem_alloc_record.allocation_file, '\0', FILENAME_SIZE_LIMIT);

	for (i = 0; i < LIST_SIZE; i++) {
		mem_alloc_record_list.m[i] = mem_alloc_record;
	}
	mem_alloc_record_list.occurrences = 0;
}

void f_debug_memory_leak_check(void)
{
	int i;

	for (i = 0; i < LIST_SIZE; i++) {
		if (mem_alloc_record_list.m[i].ptr_value != NULL) {
			printf("unfreed memory: %p allocated at line %u in file %s\n",
			       mem_alloc_record_list.m[i].ptr_value,
			       mem_alloc_record_list.m[i].allocation_line,
			       mem_alloc_record_list.m[i].allocation_file);
		}
	}

	printf("%d unfreed memory allocation\n", mem_alloc_record_list.occurrences);
}
