#' Count logicals
#' @description Count the number of \code{FALSE}, \code{TRUE}, and \code{NA}s.
#' @param x A logical vector.
#' @param nThread Number of threads to use.
#'
#' @return A vector of 3 elements: the number of \code{FALSE}, \code{TRUE}, and
#' \code{NA} values in \code{x}.
#'
#' @export

count_logical <- function(x, nThread = getOption("hutilscpp.nThread", 1L)) {
  if (!is.logical(x)) {
    stop("`x` was type ", typeof(x), ", but must be type logical.")
  }
  nThread <- check_omp(nThread)
  as_integer_if_safe(.Call("Ccount_logical", x, nThread, PACKAGE = packageName))
}
