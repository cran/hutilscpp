#include "hutilscpp.h"

unsigned int rng_state;
unsigned int rng_states[8];

SEXP CResetRNG(SEXP x) {
  if (TYPEOF(x) == INTSXP && xlength(x) == 1) {
    rng_state = INTEGER_ELT(x, 0);
  }
  return ScalarInteger(rng_state);
}

unsigned int rand_pcg() {
  unsigned int state = rng_state;
  rng_state = rng_state * 747796405u + 2891336453u;
  unsigned int word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
  return (word >> 22u) ^ word;
}

unsigned int trand_pcg(int thread) {
  unsigned int state = rng_states[thread];
  rng_states[thread] = rng_states[thread] * 747796405u + 2891336453u;
  unsigned int word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
  return (word >> 22u) ^ word;
}

unsigned int pcg_hash(unsigned int input) {
  unsigned int state = input * 747796405u + 2891336453u;
  unsigned int word = ((state >> ((state >> 28u) + 4u)) ^ state) * 277803737u;
  return (word >> 22u) ^ word;
}

unsigned int pcg_sample1(unsigned int max) {
  unsigned int r = rand_pcg();
  return r % max;
}
unsigned int pcg_sample_halfmax() {
  unsigned int r = rand_pcg();
  return r & 1073741823u;
}
unsigned int tpcg_sample_halfmax(int thread) {
  unsigned int r = trand_pcg(thread);
  return r & 1073741823u;
}
unsigned char tpcg_sample1c(int thread) {
  unsigned int r = trand_pcg(thread);
  return r & 255u;
}

SEXP Cpcg_hash(SEXP n, SEXP r, SEXP nthreads, SEXP rawres) {
  int nThread = as_nThread(nthreads);
  if (nThread > 32) {
    nThread = 32;
  }
  unsigned int N = asReal(n);
  const bool raw_res = asLogical(rawres);

  unsigned int States[32] = {0};
  if (TYPEOF(r) == INTSXP && xlength(r) >= 32) {
    for (int i = 0; i < 32; ++i) {
      States[i] = (unsigned int)INTEGER_ELT(r, i);
      rng_state = States[i];
    }
  } else {

    for (unsigned int i = 0; i < 32; ++i) {
      States[i] = i + 2U;
      rng_state = 38u;
    }
  }
  SEXP ans = PROTECT(allocVector(raw_res ? RAWSXP : INTSXP, N));
  if (raw_res) {
    unsigned char * restrict ansp = RAW(ans);
#if defined _OPENMP && _OPENMP >= 201511
#pragma omp parallel for num_threads(nThread) schedule(static)
#endif
    for (unsigned int i = 0; i < N; ++i) {
#ifdef _OPENMP
      int oi = omp_get_thread_num();
#else
      int oi = (i & 31U);
#endif
      unsigned int new_si = pcg_hash(States[oi]);
      ansp[i] = new_si;
      States[oi] = new_si;
    }
  } else {
    int * restrict ansp = INTEGER(ans);
#if defined _OPENMP && _OPENMP >= 201511
#pragma omp parallel for num_threads(nThread) schedule(static)
#endif
    for (unsigned int i = 0; i < N; ++i) {
#ifdef _OPENMP
      int oi = omp_get_thread_num();
#else
      int oi = (i & 31U);
#endif
      unsigned int new_si = pcg_hash(States[oi]);
      ansp[i] = new_si;
      States[oi] = new_si;
    }
  }


  UNPROTECT(1);
  return ans;
}
