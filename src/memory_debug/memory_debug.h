#pragma once

#define LIST_SIZE 2048
#define FILENAME_SIZE_LIMIT 4096

typedef struct MemAllocRecord {
	void *ptr_value;
	unsigned int allocation_line;
	char allocation_file[FILENAME_SIZE_LIMIT];
} MemAllocRecordType;

typedef struct MemAllocRecordList {
	MemAllocRecordType m[LIST_SIZE];
	unsigned int occurrences;
} MemAllocRecordListType;

#define malloc(size) f_debug_memory_malloc(size, __FILE__, __LINE__)
#define calloc(num, size) f_debug_memory_calloc(num, size, __FILE__, __LINE__)
#define realloc(ptr, size) f_debug_memory_realloc(ptr, size, __FILE__, __LINE__)
#define free(ptr) f_debug_memory_free(ptr, __FILE__, __LINE__)

void *f_debug_memory_malloc(unsigned int size, const char *file, unsigned int line);
void *f_debug_memory_calloc(unsigned int num, unsigned int size, const char *file,
			    unsigned int line);
void *f_debug_memory_realloc(void *ptr, unsigned int size, const char *file,
			     unsigned int line);
void f_debug_memory_free(void *ptr, const char *file, unsigned int line);

void f_debug_memory_debug_init(void);
void f_debug_memory_leak_check(void);
