% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/range_rcpp.R
\name{range_rcpp}
\alias{range_rcpp}
\title{Range C++}
\usage{
range_rcpp(
  x,
  anyNAx = anyNA(x),
  warn_empty = TRUE,
  integer0_range_is_integer = FALSE
)
}
\arguments{
\item{x}{A vector for which the range is desired. Vectors with missing values
are not supported and have no definite behaviour.}

\item{anyNAx}{(logical, default: \code{anyNA(x)} lazily). Set to \code{TRUE}
only if \code{x} is known to contain no missing values (including \code{NaN}).}

\item{warn_empty}{(logical, default: \code{TRUE}) If \code{x} is
empty (i.e. has no length), should a warning be emitted (like \code{\link[base]{range}})?}

\item{integer0_range_is_integer}{(logical, default: \code{FALSE})
If \code{x} is a length-zero integer, should the result also be an integer?
Set to \code{FALSE} by default in order to be compatible with \code{\link[base]{range}}, but can
be set to \code{TRUE} if an integer result is desired, in which case
\code{range_rcpp(integer())} is \code{(INT_MAX, -INT_MAX)}.}
}
\value{
A length-4 vector, the first two positions give the range and
the next two give the positions in \code{x} where the max and min occurred.

This is almost equivalent to \code{c(range(x), which.min(x), which.max(x))}.
Note that the type is not strictly preserved, but no loss should occur. In particular,
logical \code{x} results in an integer result, and a double \code{x} will
have double values for \code{which.min(x)} and \code{which.max(x)}.

A completely empty, logical \code{x} returns \code{c(NA, NA, NA, NA)} as an integer vector.
}
\description{
Range of a vector using Rcpp.
}
\examples{
x <- rnorm(1e3) # Not noticeable at this scale
bench_system_time(range_rcpp(x))
bench_system_time(range(x))



}
