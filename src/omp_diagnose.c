#include "hutilscpp.h"



// # nocov start

bool has_openmp(void) {
#ifdef _OPENMP
  return true;
#else
  return false;
#endif
}

#define OPENMP_REQUEST_OK 0
#define OPENMP_THREADS_NEGATIVE 1
#define OPENMP_THREADS_EXCEEDED 2


SEXP Chas_openmp(SEXP x) {
  return ScalarLogical(has_openmp());
}

// returns a list of three elements (intended to be passed to an if statement
// immediately after so no NA_LOGICALs)
// whether to warn/error
// whether to warn
// messages

#ifndef _OPENMP
int diagnose_omp(SEXP Threads_requested) {
  return 0;
}

int as_nThread(SEXP x) {
  return 1;
}
#endif

#ifdef _OPENMP
int diagnose_omp(SEXP Threads_requested) {
  int threads_requested = asInteger2(Threads_requested);
  int n_procs = 1;
  n_procs = omp_get_num_procs();


  if (threads_requested > 0 && threads_requested <= n_procs) {
    return OPENMP_REQUEST_OK;
  }

  if (threads_requested < 0) {
    return OPENMP_THREADS_NEGATIVE;
  }
  if (threads_requested > n_procs) {
    return OPENMP_THREADS_EXCEEDED;
  }

  return -1;
}



int as_nThread(SEXP x) {
  int n_procs = omp_get_num_procs();
  int threads_requested = asInteger2(x);
  if (threads_requested > 0 && threads_requested <= n_procs) {
    return threads_requested;
  }
  return 1;
}

// # nocov end
#endif

SEXP Cdiagnose_omp(SEXP x) {
  return ScalarInteger(diagnose_omp(x));
}
