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
	double std_dev;
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
normal_single_y *mean_normal_result(double *v, int num_train)
{
	int i, j;

	double max, min, mean, std_dev;

	double sum = 0.0L;

	double *result_v = NULL;
	normal_single_y *result = NULL;

	/* Set max and min for feature */
	max = v[0];
	min = v[1];

	/* Find max and min for feature */
	for (i = 0; i < num_train; i++) {
		if (max < v[i])
			max = v[i];
		else if (min > v[i])
			min = v[i];

		sum += v[i];
	}

	mean = sum / num_train;

	sum = 0.0L;

	for (i = 0; i < num_train; i++) {
		sum += (v[i] - mean) * (v[i] - mean);
	}

	std_dev = sqrt(sum / num_train);

	result_v = calloc(num_train, sizeof(double));

	for (i = 0; i < num_train; i++) {
		result_v[i] = (v[i] - mean) / std_dev;
	}

	result = calloc(1, sizeof(normal_single_y));

	result->y = result_v;
	result->mean = mean;
	result->std_dev = std_dev;

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

    NOTE: The values of first feature (i.e. x[0] is 1.0)
 */
normal_multi_x *mean_normal_feature(double **v, int num_train, int num_feat)
{
	int i, j;
	double sum = 0.0L;

	double *max = calloc(num_feat, sizeof(double));
	double *min = calloc(num_feat, sizeof(double));
	double *mean = calloc(num_feat, sizeof(double));
	double *std_dev = calloc(num_feat, sizeof(double));

	double **result_V = calloc(num_train, sizeof(double));

	for (i = 0; i < num_train; i++) {
		result_V[i] = calloc(num_feat, sizeof(double));
	}

	normal_multi_x *result = calloc(1, sizeof(normal_multi_x));

	/* Set max and min for each feature */
	for (j = 0; j < num_feat; j++) {
		max[j] = v[0][j];
		min[j] = v[0][j];
	}

	/* set mean and standard deviation for the first feature to 1.0 */
	mean[0] = 1.0L;
	std_dev[0] = 1.0L;

	/*
        Find max and min for each feature
        Each column is a feature, this means
        we need to loop from column to row.

        NOTE: skipping the first column (i.e. x[0]).
    */
	for (j = 1; j < num_feat; j++) {
		sum = 0.0L;
		for (i = 0; i < num_train; i++) {
			if (max[j] < v[i][j])
				max[j] = v[i][j];
			else if (min[j] > v[i][j])
				min[j] = v[i][j];

			sum += v[i][j];
		}
		mean[j] = sum;
	}

	/* find mean for each feature */
	for (j = 1; j < num_feat; j++) {
		mean[j] = mean[j] / num_train;
	}

	/*
        Loop from column to row.
        Calculate the standard deviation for each feature.
        NOTE: skipping the first column (i.e. x[0]).
    */
	for (j = 1; j < num_feat; j++) {
		sum = 0.0L;
		for (i = 0; i < num_train; i++) {
			sum += (v[i][j] - mean[j]) * (v[i][j] - mean[j]);
		}
		std_dev[j] = sqrt(sum / num_train);
	}

	/* Set the value of first column (x[0]) to 1.0 */
	for (i = 0; i < num_train; i++) {
		result_V[i][0] = 1.0L;
	}

	/*
        set the value of new 2D array to normalized value.
    */

	for (j = 1; j < num_feat; j++) {
		for (i = 0; i < num_train; i++) {
			result_V[i][j] = (v[i][j] - mean[j]) / std_dev[j];
		}
	}

	result->X = result_V;
	result->mean = mean;
	result->std_deviation = std_dev;

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

	int m = 0; // number of training set
	int n = 0; // number of features

	int i = 0;
	int j = 0;

	/* opening file for reading */
	fp = fopen(file_name, "r");

	if (fp == NULL) {
		perror("Error opening file");
		exit(EXIT_FAILURE);
	}

	while (fgets(str, 200, fp) != NULL) {
		// Find number of training set
		m++;
	}

	char *token = strtok(str, ",");
	while (token != NULL) {
		// Find number of features
		token = strtok(NULL, ",");
		n++;
	}

#ifdef DEBUG
	printf("Number of training sets: %d\n", m);
	printf("Number of features: %d\n", n);
#endif

	rewind(fp);

	X = calloc(m, sizeof(double));

	for (i = 0; i < m; i++) {
		X[i] = calloc(n, sizeof(double));
	}

	for (i = 0; i < m; i++) {
		// Initialize the first features into 1.0
		X[i][0] = 1.0L;
	}

	y = calloc(m, sizeof(double));

	i = 0;

#ifdef DEBUG
	printf("Read all but the last column into X\n");
	printf("Read the last column into y\n");
#endif
	while (fgets(str, 200, fp) != NULL) {
		X[i][1] = strtod(strtok(str, ","), NULL);

		for (j = 2; j < n; j++) {
			// Read all but the last column into X
			// Convert the string to double
			X[i][j] = strtod(strtok(NULL, ","), NULL);
		}

		// Read the last column into y
		// Convert the string to double
		y[i] = strtod(strtok(NULL, ","), NULL);

		i++; // Move to the next line
	}

	fclose(fp);
	fp = NULL;

	data_set = calloc(1, sizeof(data_t));
	data_set->X = X;
	data_set->y = y;
	data_set->num_train = m;
	data_set->num_feat = n;

	return data_set;
}

int write_to_file(double **x, double *y, int num_train, int num_feat)
{
	for (int i = 0; i < num_train; i++) {
		for (int j = 1; j < num_feat; j++) {
			printf("%lf,", x[i][j]);
		}
		printf("%lf\n", y[i]);
	}
	return 0;
}

int main(int argc, char *argv[])
{
#ifdef TIMER
	clock_t cpu_start = clock(); /* Initial processor time */
#endif

	data_t *data_set = NULL;

	// Get data set from data file
	data_set = read_data_file(argv[1]);

	normal_multi_x *result_X = mean_normal_feature(
		data_set->X, data_set->num_train, data_set->num_feat);

	normal_single_y *result_y =
		mean_normal_result(data_set->y, data_set->num_train);

	write_to_file(result_X->X, result_y->y, data_set->num_train,
		      data_set->num_feat);

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
