library(hutilscpp)
library(tinytest)

AnyCharMatch <- hutilscpp:::AnyCharMatch

# context("AnyCharMatch")
#
# test_that("AnyCharMatch works and opposite", {
  x <- c("", "", "a")
  o1 <- AnyCharMatch(x, "")
  expect_equal(o1, 1L)
  o3 <- AnyCharMatch(x, "", opposite = TRUE)
  expect_equal(o3, 3L)
  o3 <- AnyCharMatch(x, "a", FALSE)
  expect_equal(o3, 3L)
  xx <- c("aa", "aa", "ab")
  o3 <- AnyCharMatch(xx, "aa", opposite = TRUE)
  expect_equal(o3, 3L)


# test_that("Works fine with NA", {
  x <- c("", "", NA)
  expect_equal(AnyCharMatch(x, ""), 1L)
  expect_equal(AnyCharMatch(x, "a"), 0L)
  expect_equal(AnyCharMatch(x, NA_character_), 3L)
  expect_equal(AnyCharMatch(x, "", opposite = TRUE), 3L)
  expect_equal(AnyCharMatch(x, "a", opposite = TRUE), 1L)
  expect_equal(AnyCharMatch(x, c("", "a", "b"), opposite = TRUE), 2L)
  expect_equal(AnyCharMatch(x, NA_character_, opposite = TRUE), 1L)

  y <- c(NA, "", "")
  expect_equal(AnyCharMatch(y, ""), 2L)
  expect_equal(AnyCharMatch(y, "", opposite = TRUE), 1L)
  expect_equal(AnyCharMatch(y, NA_character_), 1L)
  expect_equal(AnyCharMatch(y, NA_character_, opposite = TRUE), 2L)
# })
