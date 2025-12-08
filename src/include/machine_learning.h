/**
 * @file machine_learning.h
 * @author Chen Liang
 * @brief Header file for machine learning in C
 * @version 0.1
 * @date 2021-06-14
 *
 * @copyright Copyright (c) 2021
 *
 */

typedef struct
{
    double **X;
    double *y;
    int num_train;
    int num_feat;
} data_t;

data_t *read_from_data_file(char *file_name);

double cost_function(double **X, double *y, double *theta, int no_train, int no_feat);

double *gradient_descent(double **X, double *y, double *theta, float alpha, int num_train,
                         int num_feat, int num_iters);

double get_determinant(double **matrix, unsigned int m_size);
double **get_invert(double **matrix, unsigned int m_size);
double *normal_equation(double **X, double *y, unsigned int num_train,
                        unsigned int num_feat);
