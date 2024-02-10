/**
 * @file feature_scale.h
 * @author Chen Liang
 * @brief Implementation of feature normalization in C
 * @version 0.1
 * @date 2021-06-14
 *
 * @copyright Copyright (c) 2021
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <math.h>

typedef struct {
	double **X;
	double *y;
	int num_train;
	int num_feat;
} data_t;

typedef struct {
	double *y;
	double mean;
	double std_deviation;
} normal_single_y;

typedef struct {
	double **X;
	double *mean;
	double *std_deviation;
} normal_multi_x;

/*
    Use mean normalization on 1D array.
    This is used on Y that is a 1D array.
 */
normal_single_y *mean_normal_result(double *y, int num_train)
{
	int i, j;

	double max, min, mean, std_dev;

	double sum = 0.0L;

	double *result_v = NULL;
	normal_single_y *result = NULL;

	/* Set max and min for feature */
	max = y[0];
	min = y[1];

	/* Find max and min for feature */
	for (i = 0; i < num_train; i++) {
		if (max < y[i])
			max = y[i];
		else if (min > y[i])
			min = y[i];

		sum += y[i];
	}

	mean = sum / num_train;

	sum = 0.0L;

	for (i = 0; i < num_train; i++) {
		sum += (y[i] - mean) * (y[i] - mean);
	}

	std_dev = sqrt(sum / num_train);

	result_v = calloc(num_train, sizeof(double));

	for (i = 0; i < num_train; i++) {
		result_v[i] = (y[i] - mean) / std_dev;
	}

	result = calloc(1, sizeof(normal_single_y));

	result->y = result_v;
	result->mean = mean;
	result->std_deviation = std_dev;

	return result;
}

/*
    Use mean normalization on 2D array.
    This is used on X that usually contains multiple features.
    The function returns a pointer to a structure.
    The structure contains pointers to the following:
        - Pointer to the result 2D array
        - Pointer to the list of mean
        - Pointer to the list of standard deviation

    NOTE: Run free on pointers of the structure
            and its elements in main.
 */
normal_multi_x *mean_normal_feature(double **X, int num_train, int num_feat)
{
	int i, j;
	double sum = 0.0L;
	int no_x_feat = num_feat - 1;

	double *max = calloc(no_x_feat, sizeof(double));
	double *min = calloc(no_x_feat, sizeof(double));
	double *mean = calloc(no_x_feat, sizeof(double));
	double *std_deviation = calloc(no_x_feat, sizeof(double));

	double **result_X = calloc(num_train, sizeof(double));

	for (i = 0; i < num_train; i++) {
		result_X[i] = calloc(no_x_feat, sizeof(double));
	}

	normal_multi_x *result = calloc(1, sizeof(normal_multi_x));

	/* Set max and min for each feature */
	for (j = 0; j < no_x_feat; j++) {
		max[j] = X[0][j];
		min[j] = X[0][j];
	}

	/* set mean and standard deviation for the first feature to 1.0 */
	mean[0] = 1.0L;
	std_deviation[0] = 1.0L;

	/*
        Find max and min for each feature
        Each column is a feature, this means
        we need to loop from column to row.
    */
	for (j = 0; j < no_x_feat; j++) {
		sum = 0.0L;
		for (i = 0; i < num_train; i++) {
			if (max[j] < X[i][j])
				max[j] = X[i][j];
			else if (min[j] > X[i][j])
				min[j] = X[i][j];

			sum += X[i][j];
		}
		mean[j] = sum;
	}

	/* find mean for each feature */
	for (j = 0; j < no_x_feat; j++) {
		mean[j] = mean[j] / num_train;
	}

	/*
        Loop from column to row.
        Calculate the standard deviation for each feature.
    */
	for (j = 0; j < no_x_feat; j++) {
		sum = 0.0L;
		for (i = 0; i < num_train; i++) {
			sum += (X[i][j] - mean[j]) * (X[i][j] - mean[j]);
		}
		std_deviation[j] = sqrt(sum / num_train);
	}

	/*
        set the value of new 2D array to normalized value.
    */

	for (j = 0; j < no_x_feat; j++) {
		for (i = 0; i < num_train; i++) {
			result_X[i][j] = (X[i][j] - mean[j]) / std_deviation[j];
		}
	}

	result->X = result_X;
	result->mean = mean;
	result->std_deviation = std_deviation;

	free(max);
	free(min);

	return result;
}

data_t *read_data_file(char *file_name)
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
		X[i] = calloc((num_feat - 1), sizeof(double));
		X[i][0] = strtod(strtok(str, ","), NULL);

		for (j = 1; j < num_feat - 1; j++) {
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

#ifdef DEBUG
	printf("Number of training sets: %d\n", num_train);
	printf("Number of features: %d\n", num_feat);
#endif

	fclose(fp); // close file
	fp = NULL;

	data_set = calloc(1, sizeof(data_t));
	data_set->X = X;
	data_set->y = y;
	data_set->num_train = num_train;
	data_set->num_feat = num_feat;

	return data_set;
}

int write_to_file(double **x, double *y, int num_train, int num_feat,
		  char *filename)
{
	FILE *fptr = fopen(filename, "w");

	int no_x_feat = num_feat - 1;

	for (int i = 0; i < num_train; i++) {
		for (int j = 0; j < no_x_feat; j++) {
			int len = snprintf(NULL, 0, "%lf", x[i][j]);
			char *buffer = calloc(len + 1, sizeof(char));
			snprintf(buffer, len + 1, "%lf", x[i][j]);
			strcat(buffer, ",");
			fprintf(fptr, "%s", buffer);
		}
		int len = snprintf(NULL, 0, "%lf", y[i]);
		char *buffer = calloc(len + 1, sizeof(char));
		snprintf(buffer, len + 1, "%lf\n", y[i]);
		strcat(buffer, "\n");
		fprintf(fptr, "%s", buffer);
	}

	fclose(fptr);
	return 0;
}

int main(int argc, char *argv[])
{
#ifdef TIMER
	clock_t cpu_start = clock(); /* Initial processor time */
#endif

	data_t *data_set = NULL;

	if (argc < 4) {
		printf("not enough input\n");
		return 1;
	}
	// Get data set from data file
	data_set = read_data_file(argv[1]);

	if (strcmp(argv[2], "-o")) {
		printf("wrong command flag\n");
		return 1;
	}

	char *output_file = argv[3];

	normal_multi_x *result_X = mean_normal_feature(
		data_set->X, data_set->num_train, data_set->num_feat);

	normal_single_y *result_y =
		mean_normal_result(data_set->y, data_set->num_train);

	write_to_file(result_X->X, result_y->y, data_set->num_train,
		      data_set->num_feat, output_file);

	for (int i = 0; i < data_set->num_train; i++) {
		free(data_set->X[i]); // Free the inner pointers before outer pointers
	}

	for (int i = 0; i < data_set->num_train; i++) {
		free(result_X->X[i]); // Free the inner pointers before outer pointers
	}

	free(data_set->X);
	free(data_set->y);
	free(data_set);

	free(result_X->X);
	free(result_X->mean);
	free(result_X->std_deviation);
	free(result_X);

	free(result_y->y);
	free(result_y);

#ifdef DEBUG
	printf("Freed all memory\n");
#endif
#ifdef TIMER

	clock_t cpu_end = clock(); /* Final CPU time */

	printf("main completed in %lf seconds\n",
	       ((double)(cpu_end - cpu_start)) / CLOCKS_PER_SEC);
#endif

	return 0;
}
