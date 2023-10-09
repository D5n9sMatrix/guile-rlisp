#!/usr/bin/r

# Encode the Terminal Times of Time Series

# Description
# Extract and encode the times the first and last observations were taken. Provided only for compatibility with S version 2.

# Usage
# start(x, ...)
# end(x, ...)
# Arguments
# x	
# a univariate or multivariate time-series, or a vector or matrix.

# ...	
# extra arguments for future methods.

# Details
# These are generic functions, which will use the tsp attribute of x if it exists. Their default methods decode the start time from the original time units, so that for a monthly series 1995.5 is represented as c(1995, 7). For a series of frequency f, time n+i/f is presented as c(n, i+1) (even for i = 0 and f = 1).

# Warning
# The representation used by start and end has no meaning unless the frequency is supplied.

# See Also
# ts, time, tsp.
x <- quit(save = "default", status = 0, runLast = TRUE)
end(x)