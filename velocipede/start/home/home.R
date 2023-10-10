#!/usr/bin/r

# Cross Tabulation and Table Creation

# Description
# table uses the cross-classifying factors to build a contingency table of the counts at each combination of factor levels.

# Usage
# table(...,
#       exclude = if (useNA == "no") c(NA, NaN),
#       useNA = c("no", "ifany", "always"),
#       dnn = list.names(...), deparse.level = 1)

# as.table(x, ...)
# is.table(x)

# ## S3 method for class 'table'
# as.data.frame(x, row.names = NULL, ...,
#               responseName = "Freq", stringsAsFactors = TRUE,
#               sep = "", base = list(LETTERS))
# Arguments
# ...	
# one or more objects which can be interpreted as factors (including character strings), or a list (or data frame) whose components can be so interpreted. (For as.table, arguments passed to specific methods; for as.data.frame, unused.)

# exclude	
# levels to remove for all factors in .... If it does not contain NA and useNA is not specified, it implies useNA = "ifany". See ‘Details’ for its interpretation for non-factor arguments.

# useNA	
# whether to include NA values in the table. See ‘Details’. Can be abbreviated.

# dnn	
# the names to be given to the dimensions in the result (the dimnames names).

# deparse.level	
# controls how the default dnn is constructed. See ‘Details’.

# x	
# an arbitrary R object, or an object inheriting from class "table" for the as.data.frame method. Note that as.data.frame.table(x, *) may be called explicitly for non-table x for “reshaping” arrays.

# row.names	
# a character vector giving the row names for the data frame.

# responseName	
# The name to be used for the column of table entries, usually counts.

# stringsAsFactors	
# logical: should the classifying factors be returned as factors (the default) or character vectors?

# sep, base	
# passed to provideDimnames.

# Details
# If the argument dnn is not supplied, the internal function list.names is called to compute the ‘dimname names’. If the arguments in ... are named, those names are used. For the remaining arguments, deparse.level = 0 gives an empty name, deparse.level = 1 uses the supplied argument if it is a symbol, and deparse.level = 2 will deparse the argument.

# Only when exclude is specified (i.e., not by default) and non-empty, will table potentially drop levels of factor arguments.

# useNA controls if the table includes counts of NA values: the allowed values correspond to never ("no"), only if the count is positive ("ifany") and even for zero counts ("always"). Note the somewhat “pathological” case of two different kinds of NAs which are treated differently, depending on both useNA and exclude, see d.patho in the ‘Examples:’ below.

# Both exclude and useNA operate on an “all or none” basis. If you want to control the dimensions of a multiway table separately, modify each argument using factor or addNA.

# Non-factor arguments a are coerced via factor(a, exclude=exclude). Since R 3.4.0, care is taken not to count the excluded values (where they were included in the NA count, previously).

# The summary method for class "table" (used for objects created by table or xtabs) which gives basic information and performs a chi-squared test for independence of factors (note that the function chisq.test currently only handles 2-d tables).

# Value
# table() returns a contingency table, an object of class "table", an array of integer values. Note that unlike S the result is always an array, a 1D array if one factor is given.

# as.table and is.table coerce to and test for contingency table, respectively.

# The as.data.frame method for objects inheriting from class "table" can be used to convert the array-based representation of a contingency table to a data frame containing the classifying factors and the corresponding entries (the latter as component named by responseName). This is the inverse of xtabs.

# References
# Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.

# See Also
# tabulate is the underlying function and allows finer control.

# Use ftable for printing (and more) of multidimensional tables. margin.table, prop.table, addmargins.

# addNA for constructing factors with NA as a level.

# xtabs for cross tabulation of data frames with a formula interface.

# Examples

require(stats) # for rpois and xtabs
## Simple frequency distribution
table(rpois(100, 5))
## Check the design:
with(warpbreaks, table(wool, tension))
table(state.division, state.region)

# simple two-way contingency table
with(airquality, table(cut(Temp, quantile(Temp)), Month))

a <- letters[1:3]
table(a, sample(a))                    # dnn is c("a", "")
table(a, sample(a), deparse.level = 0) # dnn is c("", "")
table(a, sample(a), deparse.level = 2) # dnn is c("a", "sample(a)")

## xtabs() <-> as.data.frame.table() :
UCBAdmissions ## already a contingency table
DF <- as.data.frame(UCBAdmissions)
class(tab <- xtabs(Freq ~ ., DF)) # xtabs & table
## tab *is* "the same" as the original table:
all(tab == UCBAdmissions)
all.equal(dimnames(tab), dimnames(UCBAdmissions))

a <- rep(c(NA, 1/0:3), 10)
table(a)                 # does not report NA's
table(a, exclude = NULL) # reports NA's
b <- factor(rep(c("A","B","C"), 10))
table(b)
table(b, exclude = "B")
d <- factor(rep(c("A","B","C"), 10), levels = c("A","B","C","D","E"))
table(d, exclude = "B")
print(table(b, d), zero.print = ".")

## NA counting:
is.na(d) <- 3:4
d. <- addNA(d)
d.[1:7]
table(d.) # ", exclude = NULL" is not needed
## i.e., if you want to count the NA's of 'd', use
table(d, useNA = "ifany")

## "pathological" case:
d.patho <- addNA(c(1,NA,1:2,1:3))[-7]; is.na(d.patho) <- 3:4
d.patho
## just 3 consecutive NA's ? --- well, have *two* kinds of NAs here :
as.integer(d.patho) # 1 4 NA NA 1 2
##
## In R >= 3.4.0, table() allows to differentiate:
table(d.patho)                   # counts the "unusual" NA
table(d.patho, useNA = "ifany")  # counts all three
table(d.patho, exclude = NULL)   #  (ditto)
table(d.patho, exclude = NA)     # counts none

## Two-way tables with NA counts. The 3rd variant is absurd, but shows
## something that cannot be done using exclude or useNA.
with(airquality,
   table(OzHi = Ozone > 80, Month, useNA = "ifany"))
with(airquality,
   table(OzHi = Ozone > 80, Month, useNA = "always"))
with(airquality,
   table(OzHi = Ozone > 80, addNA(Month)))