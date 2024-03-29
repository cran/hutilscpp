
o <- hutilscpp:::allocate0_int(10)
expect_identical(o, integer(10))
p <- hutilscpp:::allocate0_dbl(10)
expect_identical(p, double(10))

xc <- hutilscpp:::allocate0_except(10, 2, -2)
o <- integer(10)
o[3] <- -2L
expect_identical(xc, o)
xd <- hutilscpp:::allocate0_except(10L, 2L, -2L)
expect_identical(xd, o)

Ans <- hutilscpp:::.allocate_constants(3)
expect_equal(lengths(Ans, use.names = FALSE), rep(3L, length(Ans)))

