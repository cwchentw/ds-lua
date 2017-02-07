#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <math.h>
#ifdef USE_OPENMP
#include <omp.h>
#endif
#include "ds.h"

char dtoa(int d) {
  if (d == 0) {
    return '0';
  } else if (d == 1) {
    return '1';
  } else if (d == 2) {
    return '2';
  } else if (d == 3) {
    return '3';
  } else if (d == 4) {
    return '4';
  } else if (d == 5) {
    return '5';
  } else if (d == 6) {
    return '6';
  } else if (d == 7) {
    return '7';
  } else if (d == 8) {
    return '8';
  } else if (d == 9) {
    return '9';
  } else {
    return 'x';
  }
}

char* utoa(size_t s) {
  size_t d = 0;
  size_t temp = s;
  while (temp > 0) {
    temp = temp / 10;
    d = d + 1;

  }

  char* str = malloc((d + 1) * sizeof(char));

  temp = s;
  int i = d;
  while (temp > 0) {
    int n = temp % 10;
    char c = dtoa(n);
    str[i - 1] = c;
    temp = temp / 10;
    i = i - 1;
  }
  str[d] = '\0';

  return str;
}

DoubleVector* ds_double_vector_new(size_t s) {
  DoubleVector* vector = malloc(sizeof(DoubleVector));
  vector->size = s;
  vector->vec = malloc(vector->size * sizeof(double));

  for (int i = 0; i < vector->size; i++) {
    vector->vec[i] = 0.0;
  }

  return vector;
}

size_t ds_double_vector_size(DoubleVector* v) {
  return v->size;
}

double ds_double_vector_get(DoubleVector* v, size_t index) {
  if (index > v->size - 1) {
    ds_double_vector_error(v, "Index out of range\n");
  }

  return v->vec[index];
}

void ds_double_vector_set(DoubleVector* v, size_t index, double data) {
  if (index > v->size - 1) {
    ds_double_vector_error(v, "Index out of range\n");
  }

  v->vec[index] = data;
}

double ds_double_vector_magnitude(DoubleVector* v) {
  size_t len = v->size;

  double temp = 0.0;
  for (int i = 0; i < len; i++) {
    temp += pow(v->vec[i], 2);
  }

  return sqrt(temp);
}

int ds_double_vector_equal(DoubleVector* v1, DoubleVector* v2) {
  if (!(v1->size == v2->size)) {
    return 0;
  }

  size_t len = v1->size;
  for (int i = 0; i < len; i++) {
    if (!(v1->vec[i] == v2->vec[i])) {
      return 0;
    }
  }

  return 1;
}

DoubleVector* ds_double_vector_add(DoubleVector* v1, DoubleVector* v2) {
  size_t len1 = v1->size;
  size_t len2 = v2->size;
  if (len1 != len2) {
    return NULL;
  }

  DoubleVector* v = ds_double_vector_new(len1);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len1; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) + ds_double_vector_get(v2, i));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_add(DoubleVector* v1, double s) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) + s);
  }

  return v;
}

DoubleVector* ds_double_vector_sub(DoubleVector* v1, DoubleVector* v2) {
  size_t len1 = v1->size;
  size_t len2 = v2->size;
  if (len1 != len2) {
    return NULL;
  }

  DoubleVector* v = ds_double_vector_new(len1);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len1; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) - ds_double_vector_get(v2, i));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_sub_first(double s, DoubleVector* v1) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      s - ds_double_vector_get(v1, i));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_sub_second(DoubleVector* v1, double s) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) - s);
  }

  return v;
}

DoubleVector* ds_double_vector_mul(DoubleVector* v1, DoubleVector* v2) {
  size_t len1 = v1->size;
  size_t len2 = v2->size;
  if (len1 != len2) {
    return NULL;
  }

  DoubleVector* v = ds_double_vector_new(len1);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len1; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) * ds_double_vector_get(v2, i));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_mul(DoubleVector* v1, double s) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) * s);
  }

  return v;
}

DoubleVector* ds_double_vector_div(DoubleVector* v1, DoubleVector* v2) {
  size_t len1 = v1->size;
  size_t len2 = v2->size;
  if (len1 != len2) {
    return NULL;
  }

  DoubleVector* v = ds_double_vector_new(len1);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len1; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) / ds_double_vector_get(v2, i));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_div_first(double s, DoubleVector* v1) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      s / ds_double_vector_get(v1, i));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_div_second(DoubleVector* v1, double s) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      ds_double_vector_get(v1, i) / s);
  }

  return v;
}

DoubleVector* ds_double_vector_pow(DoubleVector* v1, DoubleVector* v2) {
  size_t len1 = v1->size;
  size_t len2 = v2->size;
  if (len1 != len2) {
    return NULL;
  }

  DoubleVector* v = ds_double_vector_new(len1);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len1; i++) {
    ds_double_vector_set(v, i,
      pow(ds_double_vector_get(v1, i), ds_double_vector_get(v2, i)));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_pow_first(double s, DoubleVector* v1) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      pow(s, ds_double_vector_get(v1, i)));
  }

  return v;
}

DoubleVector* ds_double_vector_scalar_pow_second(DoubleVector* v1, double s) {
  size_t len = v1->size;

  DoubleVector* v = ds_double_vector_new(len);

  #ifdef USE_OPENMP
  #pragma omp parallel for
  #endif
  for (int i = 0; i < len; i++) {
    ds_double_vector_set(v, i,
      pow(ds_double_vector_get(v1, i), s));
  }

  return v;
}

double ds_double_vector_dot(DoubleVector* v1, DoubleVector* v2) {
  size_t len1 = v1->size;
  size_t len2 = v2->size;
  if (len1 != len2) {
    fprintf(stderr, "Unequal vector size, invalid result\n");
    return 0.0;
  }

  double sum = 0.0;
  for (int i = 0; i < len1; i++) {
    sum += v1->vec[i] * v2->vec[i];
  }

  return sum;
}

void ds_double_vector_error(DoubleVector* v, const char* msg) {
  fprintf(stderr, "%s", msg);
  ds_double_vector_free(v);
}

void ds_double_vector_free(DoubleVector* v) {
  free((void*) ((DoubleVector*) v)->vec);
  free((void*) v);
}
