#!/usr/bin/r

# The Uniform Distribution

# Description
# These functions provide information about the uniform distribution on the interval from min to max. dunif gives the density, punif gives the distribution function qunif gives the quantile function and runif generates random deviates.

# Usage
# dunif(x, min = 0, max = 1, log = FALSE)
# punif(q, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)
# qunif(p, min = 0, max = 1, lower.tail = TRUE, log.p = FALSE)
# runif(n, min = 0, max = 1)
# Arguments
# x, q	
# vector of quantiles.

# p	
# vector of probabilities.

# n	
# number of observations. If length(n) > 1, the length is taken to be the number required.

# min, max	
# lower and upper limits of the distribution. Must be finite.

# log, log.p	
# logical; if TRUE, probabilities p are given as log(p).

# lower.tail	
# logical; if TRUE (default), probabilities are P[X ≤ x], otherwise, P[X > x].

# Details
# If min or max are not specified they assume the default values of 0 and 1 respectively.

# The uniform distribution has density

# f(x) = 1/(max-min)

# for min ≤ x ≤ max.

# For the case of u := min == max, the limit case of X == u is assumed, although there is no density in that case and dunif will return NaN (the error condition).

# runif will not generate either of the extreme values unless max = min or max-min is small compared to min, and in particular not for the default arguments.

# Value
# dunif gives the density, punif gives the distribution function, qunif gives the quantile function, and runif generates random deviates.

# The length of the result is determined by n for runif, and is the maximum of the lengths of the numerical arguments for the other functions.

# The numerical arguments other than n are recycled to the length of the result. Only the first elements of the logical arguments are used.

# Note
# The characteristics of output from pseudo-random number generators (such as precision and periodicity) vary widely. See .Random.seed for more information on R's random number generation algorithms.

# References
# Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.

# See Also
# RNG about random number generation in R.

# Distributions for other standard distributions.

# Examples

u <- runif(20)

## The following relations always hold :
punif(u) == u
dunif(u) == 1

var(runif(10000))  #- ~ = 1/12 = .08333
