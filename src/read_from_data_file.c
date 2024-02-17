/**
 * @file read_from_data_file.c
 * @author Chen Liang
 * @brief Read data from file and store it in array
 * @version 0.1
 * @date 2021-06-15
 *
 * @copyright Copyright (c) 2021
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "machine_learning.h"

// Function name is the same of the source code file name.
// This is for convenient purpose.
data_t *read_from_data_file(char *file_name)
{
	data_t *data_set = NULL;

	FILE *fp = NULL;

	char str[200];

	double **X = NULL; // features
	double *y = NULL; // results

	int num_train = 0; // number of training set
	int num_feat = 0; // number of features

	int i = 0;
	int j = 0;

	/* opening file for reading */
	fp = fopen(file_name, "r");

	if (fp == NULL) {
		perror("Error opening file");
		exit(EXIT_FAILURE);
	}

	// Read the first line and split by ','
	// Count the number of features via no. of splits
	if (fgets(str, 200, fp) != NULL) {
		char *token = strtok(str, ",");
		while (token != NULL) {
			token = strtok(NULL, ",");
			num_feat++;
		}
	}
	rewind(fp); // go back to top of the file

	X = calloc(1, sizeof(double));
	y = calloc(1, sizeof(double));

	while (fgets(str, 200, fp) != NULL) {
		// Find number of training set
		X[i] = calloc((num_feat), sizeof(double));

		X[i][0] = 1.0L;
		X[i][1] = strtod(strtok(str, ","), NULL);

		for (j = 2; j < num_feat; j++) {
			// Read all but the last column into X
			// Convert the string to double
			X[i][j] = strtod(strtok(NULL, ","), NULL);
		}

		// Read the last column into y
		// Convert the string to double
		y[i] = strtod(strtok(NULL, ","), NULL);

		i++; // Move to the next training set

		// Expend the memory size
		X = realloc(X, (i + 1) * sizeof(double));
		y = realloc(y, (i + 1) * sizeof(double));
	}

	num_train = i; //  set the number of training sets

	printf("Number of training sets: %d\n", num_train);
	printf("Number of features: %d\n", num_feat);

	fclose(fp);
	fp = NULL;

	data_set = calloc(1, sizeof(data_t));
	data_set->X = X;
	data_set->y = y;
	data_set->num_train = num_train;
	data_set->num_feat = num_feat;

	return data_set;
}
