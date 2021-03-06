
test_that("fmatchp works", {
  expect_true(TRUE)
  skip_if_not_installed("withr")
  withr::with_seed(3, {
    x <- sample.int(1e5)
    y <- sample.int(99)
    oi <- as.integer(fmatchp(x, y, nomatch = 0L, nThread = 2L))
    expect_equal(oi, match(x, y, nomatch = 0L))

    x <- as.double(sample.int(1e5))
    y <- as.double(sample.int(99))
    oi <- as.integer(fmatchp(x, y, nomatch = 0L, nThread = 2L))
    expect_equal(oi, match(x, y, nomatch = 0L))
    z <- sample(99, size = 98)

    oj <- as.integer(fmatchp(x, z, nomatch = 0L, nThread = 2L))
    expect_equal(oj, match(x, z, nomatch = 0L))
    expect_equal(oj, match(as.double(x), z, nomatch = 0L))
    expect_equal(oj, match(as.double(x), as.double(z), nomatch = 0L))

    z <- "z"
    lettre <- c(letters, "e")
    expect_equal(fmatchp(z, lettre), match(z, lettre))
    expect_equal(finp(z, lettre), z %in% lettre)
    expect_equal(finp(letters, lettre), letters %in% lettre)
    expect_equal(fmatchp(lettre, "e", whichFirst = -1L),
                 length(lettre))

    zf <- factor(z, levels = unique(lettre))
    lettref <- factor(lettre, levels = unique(lettre))
    expect_equal(finp(zf, lettref), zf %in% lettref)
    expect_equal(fmatchp(zf, lettref, whichFirst = 1L),
                 first_which(zf %in% lettref))
    expect_equal(fmatchp(zf, lettref, whichFirst = 1L),
                 first_which(zf %in% lettref))

    expect_equal(fmatchp(integer(0), 1:5, whichFirst = 1L), 0)
    expect_equal(finp(integer(0), 1:5), logical(0))
    expect_equal(finp(1:5, integer(0)), logical(5))
    expect_equal(fnotinp(1:5, integer(0)), !logical(5))
    expect_equal(fmatchp(1:5, integer(0), nomatch = 0L), integer(5))


  })


  # if (is_covr() && Sys.getenv("USERNAME") == "hughp") {
  #   x0 <- sample(2:100)
  #   x <- rep_len(x0, 2^31)
  #   y <- rep_len(sample(55), 13333)
  #   expect_identical(finp(x, y, nThread = 10L), rep_len(x0 %in% y, 2^31))
  #   expect_identical(finp(as.double(x), y, nThread = 10L)[1:101], rep_len(x0 %in% y, 101))
  #   expect_identical(finp(as.character(x), as.character(y), nThread = 10L)[1:101], rep_len(x0 %in% y, 101))
  # }

})

test_that("edge cases", {
  expect_equal(fmatchp(raw(5), 0:5),
                match(raw(5), 0:5))
  z <- as.POSIXlt(Sys.time() + 0:5)
  tt <- as.POSIXlt(Sys.time() + 1e6 + 1:5)
  expect_equal(fmatchp(z, tt, nomatch = 0L),
               match(z, tt, nomatch = 0L))
})
