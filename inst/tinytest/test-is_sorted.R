# test_that("is_sorted works no NAs", {
  expect_true(is_sorted(NULL))
  expect_true(is_sorted(integer(1)))
  expect_true(is_sorted(1:100))
  expect_true(is_sorted(1:100 + 0))
  expect_true(is_sorted(100:1 + 0))
  expect_true(is_sorted(100:10))
  expect_true(is_sorted(c(-Inf, 0, Inf)))
  expect_true(is_sorted(integer(2)))
  expect_true(is_sorted(integer(20)))
  expect_true(is_sorted(double(2)))
  expect_true(is_sorted(double(20)))
  expect_false(is_sorted(c(1:5, 5:1)))
  expect_false(is_sorted(c(1:5, 5:1 + 0)))
  expect_false(is_sorted(c(0, -1, -2, 1, 3)))
  expect_false(is_sorted(c(0, 1, 2, 3, 2)))
  expect_false(is_sorted(c(0, 1, 2, 3, 2)))
  expect_false(is_sorted(c(0, -1, 2, 3, 2)))
  expect_false(is_sorted(c(0, -1, 2, 3, -2)))
  expect_false(is_sorted(c(0L, -1L, 1L)))
  expect_false(is_sorted(c(0L, 1L, -1L)))



# test_that("isntSorted", {
  expect_equal(isntSorted(NULL), 0)
  expect_equal(isntSorted(integer(1)), 0L)
  expect_equal(isntSorted(c(0, 1, 2, 1)), 4)
  expect_equal(isntSorted(c(0, 1, 2, 1, 0)), 4)
  expect_equal(isntSorted(c(0L, 1L, 0L)), 3)
  expect_equal(isntSorted(c(0:2)), 0)
  expect_equal(isntSorted(c(4:1)), 0)
  expect_equal(isntSorted(c(0:2 + 1)), 0)
  expect_equal(isntSorted(c(0:-2 + 1)), 0)

  expect_equal(isntSorted(double(8)), 0)
  expect_equal(isntSorted(integer(8)), 0)
  expect_equal(isntSorted(c(9L, 8L, 8L, 9L, 9L)), 4L)
  expect_equal(isntSorted(c(9L, 8L, 8L, 9L, 9)), 4L)
  expect_equal(isntSorted(c(7L, 8L, 8L, 4L, 7L)), 4L)
  expect_equal(isntSorted(c(7L, 8L, 8L, 4L, 7)), 4L)
  expect_equal(isntSorted(c(7L, 8L, 8L, 4L, 8L)), 4L)
  expect_equal(isntSorted(c(7L, 8L, 8L, 4L, 8)), 4L)

  expect_equal(isntSorted(c(0, 0)), 0)
  expect_equal(isntSorted(c(0, 1)), 0)
  expect_equal(isntSorted(c(1, 0)), 0)
  expect_equal(isntSorted(c(1L, 0L)), 0)

  expect_equal(isntSorted(c(40, 30, 00, 10)), 4)
  expect_equal(isntSorted(c(4L, 3L, 0L, 1L)), 4)


# test_that("is_sorted asc", {
  x <- c(0L, 2:4)
  expect_true(is_sorted(x, asc = TRUE))
  expect_true(is_sorted(as.double(x), asc = TRUE))
  expect_false(is_sorted(x, asc = FALSE))
  expect_false(is_sorted(as.double(x), asc = FALSE))
  xr <- rev(x)
  expect_false(is_sorted(xr, asc = TRUE))
  expect_false(is_sorted(as.double(xr), asc = TRUE))
  expect_true(is_sorted(xr, asc = FALSE))
  expect_true(is_sorted(as.double(xr), asc = FALSE))


# test_that("isntSorted asc", {
  x <- c(0L, 2:4)
  expect_true(!isntSorted(x, asc = TRUE))
  expect_true(!isntSorted(as.double(x), asc = TRUE))
  expect_false(!isntSorted(x, asc = FALSE))
  expect_false(!isntSorted(as.double(x), asc = FALSE))
  xr <- rev(x)
  expect_false(!isntSorted(xr, asc = TRUE))
  expect_false(!isntSorted(as.double(xr), asc = TRUE))
  expect_true(!isntSorted(xr, asc = FALSE))
  expect_true(!isntSorted(as.double(xr), asc = FALSE))





