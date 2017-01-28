#ifndef __ALGO_DOUBLE_MATRIX_H__
#define __ALGO_DOUBLE_MATRIX_H__

#ifdef __cplusplus
#include <cstddef>
#else
#include <stddef.h>
#endif

#include "DoubleVector.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct DoubleMatrix {
  size_t nrow;
  size_t ncol;
  double* mtx;
} DoubleMatrix;

DoubleMatrix* ds_double_matrix_new(size_t, size_t);
double ds_double_matrix_get_nrow(DoubleMatrix*);
double ds_double_matrix_get_ncol(DoubleMatrix*);
double ds_double_matrix_get(DoubleMatrix*, size_t, size_t);
void ds_double_matrix_set(DoubleMatrix*, size_t, size_t, double);
DoubleVector* ds_double_matrix_get_row(DoubleMatrix*, size_t);
DoubleVector* ds_double_matrix_get_col(DoubleMatrix*, size_t);
void ds_double_matrix_free(DoubleMatrix*);

#ifdef __cplusplus
}
#endif

#endif  // __ALGO_DOUBLE_MATRIX_H__
