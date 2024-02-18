/*
 *  Cost function for logistical regression
 * # Cost function for multiple features (x\[1\], x\[2\], ..., x\[n\]
 * - X and y are the training sets.
 * - X is a 2D Vector represent multiple training sets
 * - theta is a vector that contains chosen numbers.
 *
 * ## Implement the following matlab formula:
 *
 * hx = 1 ./ (1 + exp(-(theta' * X')));
 *
 * J = sum(-y .* log(hx') - (1 - y) .* log(1 - hx')) /
 *         m + (lambda / (2 * m)) * sum(theta_without_first.^2);
 *
 *
 *
 */

#include <stdlib.h>
#include <malloc.h>
#include <math.h>

double *get_cost(double **X, double *y, double *theta, int num_feat,
		 int num_train)
{
	double *hx = calloc(num_train, sizeof(double));
	double sum = 0.0L;

	// h(x) equation from MatLab
	// hx = 1 ./ (1 + exp(-(theta' * X')));
	for (int i = 0; i < num_train; i++) {
		for (int j = 0; j < num_feat; j++) {
			sum += theta[j] * X[i][j];
		}
        hx[i] = 1 / (1 + pow(M_E, -sum));
        printf("%lf", hx[i]);
	}
	return 0;
}
