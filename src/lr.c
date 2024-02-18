/**
 * @file main.c
 * @author Chen Liang
 * @brief main.c used to test the machine learning library
 * @version 0.1
 * @date 2021-05-04
 *
 * @copyright Copyright (c) 2021
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <time.h>

#include "machine_learning.h"

const int iterations = 5000; // no of iterations

int main(int argc, char *argv[])
{
	data_t *data_set = NULL;

	int i;

	unsigned int num_train = 0; // number of training set
	unsigned int num_feat = 0; // number of features

	double **X = NULL; // features
	double *y = NULL; // results

	float alpha = 0.0; // learning step size

#ifdef TIMER
	clock_t file_read_cpu_start = clock(); /* Initial processor time */
#endif
	// Get data set from data file
	data_set = read_from_data_file(argv[1]);
#ifdef TIMER

	clock_t file_read_cpu_end = clock(); /* Final cpu time */

	printf("File read in %lf seconds\n",
	       ((double)(file_read_cpu_end - file_read_cpu_start)) /
		       CLOCKS_PER_SEC);
#endif

	X = data_set->X;
	y = data_set->y;
	num_train = data_set->num_train;
	num_feat = data_set->num_feat;

	double *theta = calloc(num_feat, sizeof(double));

	// printf("Cost function test...\n");
	// printf("Thetas are [0.0, 0.0]. The cost is %lf\n",
	//        cost_function(X, y, theta, num_train, num_feat));
	//
	// theta[0] = -1.0;
	// theta[1] = 2.0;
	//
	// printf("Thetas are [-1.0, 2.0]. The cost is %lf\n",
	//        cost_function(X, y, theta, num_train, num_feat));
	//
	// printf("Calculating thetas...\n");
	//
	// theta[0] = 0.0;
	// theta[1] = 0.0;

	if (num_feat < 3)
		alpha = 0.01;
	else
		alpha = num_feat / 10.0;

#ifdef TIMER
	clock_t gradient_descent_cpu_start =
		clock(); /* Initial processor time */
#endif
	double *final_theta = gradient_descent(X, y, theta, alpha, num_train,
					       num_feat, iterations);
#ifdef TIMER

	clock_t gradient_descent_cpu_end = clock(); /* Final cpu time */

	printf("Gradient descent completed in %lf seconds\n",
	       ((double)(gradient_descent_cpu_end -
			 gradient_descent_cpu_start)) /
		       CLOCKS_PER_SEC);
#endif

	printf("Found thetas using Gradient Descent: [ ");

	for (i = 1; i < num_feat; i++) {
		printf("%lf ", final_theta[i]);
	}
	printf("]\n");

	// double *final_theta_ne = normal_equation(X, y, num_train, num_feat);
	// printf("Found thetas using Normal Equation: [");
	//
	// for (i = 0; i < num_feat; i++) {
	// 	printf("%lf ", final_theta_ne[i]);
	// }
	// printf("]\n");

	for (i = 0; i < num_train; i++) {
		free(X[i]); // Free the inner pointers before outer pointers
	}

	free(X);
	free(y);
	free(theta);
	free(final_theta);
	// free(final_theta_ne);
	free(data_set);

#ifdef DEBUG
	printf("Freed all memory\n");
#endif

	return 0;
}
