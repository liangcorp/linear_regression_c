/**
 * @file gradient_descent.c
 * @author Chen Liang
 * @brief Implementation of gradient descent in C
 * @version 0.1
 * @date 2021-06-14
 *
 * @copyright Copyright (c) 2021
 *
 */

#include <stdlib.h>
#include <string.h>
#include "machine_learning.h"

/*
# Gradient descent

 - X and y are the training sets.
 - alpha is the learning rate
 - theta is a chosen number.

## Implement the following matlab formula:


 theta(indx,:) = theta(indx,:) -
                 alpha * ((((temp[] * X[]) - y[]) * X(:,indx))/m);
*/
double *gradient_desent(double **X, double *y, double *theta, float alpha,
			int num_train, int num_feat, int iterations)
{
	int i, j;

	double sum = 0.0L;
	double *h_x = calloc(num_train, sizeof(double));

	//  gradient descent
	while (iterations > 0) {
		memset(h_x, 0.0L, num_train * sizeof(double));

		for (i = 0; i < num_train; i++) {
			for (j = 0; j < num_feat; j++) {
				h_x[i] += theta[j] * X[i][j];
			}
		}

		for (j = 0; j < num_feat; j++) {
			sum = 0.0L;

			for (i = 0; i < num_train; i++) {
				sum += (h_x[i] - y[i]) * X[i][j];
			}

			theta[j] = theta[j] - (alpha * sum / (double)num_train);
		}

		iterations--;
	}

	free(h_x);

	return theta;
}
