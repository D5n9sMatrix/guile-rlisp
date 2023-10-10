#!/usr/bin/r

# Color Palettes

# Description
# Create a vector of n contiguous colors.

# Usage
# hcl.colors(n, palette = "viridis", alpha = NULL, rev = FALSE, fixup = TRUE)
# hcl.pals(type = NULL)

# rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n,
#         alpha, rev = FALSE)
# heat.colors(n, alpha, rev = FALSE)
# terrain.colors(n, alpha, rev = FALSE)
# topo.colors(n, alpha, rev = FALSE)
# cm.colors(n, alpha, rev = FALSE)
# Arguments
# n	
# the number of colors (≥ 1) to be in the palette.

# palette	
# a valid palette name (one of hcl.pals()). The name is matched to the list of available palettes, ignoring upper vs. lower case, spaces, dashes, etc. in the matching.

# alpha	
# an alpha-transparency level in the range [0,1] (0 means transparent and 1 means opaque), see argument alpha in hsv and hcl, respectively.
# Since R 4.0.0, a missing, i.e., not explicitly specified alpha is equivalent to alpha = NULL, which does not add opacity codes ("FF") to the individual color hex codes.

# rev	
# logical indicating whether the ordering of the colors should be reversed.

# fixup	
# logical indicating whether the resulting color should be corrected to RGB coordinates in [0,1], see hcl.

# type	
# the type of palettes to list: "qualitative", "sequential", "diverging", or "divergingx". NULL lists all palettes.

# s, v	
# the ‘saturation’ and ‘value’ to be used to complete the HSV color descriptions.

# start	
# the (corrected) hue in [0,1] at which the rainbow begins.

# end	
# the (corrected) hue in [0,1] at which the rainbow ends.

# Details
# All of these functions (except the helper function hcl.pals) create a vector of n contiguous colors, either based on the HSV color space (rainbow, heat, terrain, topography, and cyan-magenta colors) or the perceptually-based HCL color space.

# HSV (hue-saturation-value) is a simple transformation of the RGB (red-green-blue) space which was therefore a convenient choice for color palettes in many software systems (see also hsv). However, HSV colors capture the perceptual properties hue, colorfulness/saturation/chroma, and lightness/brightness/luminance/value only poorly and consequently the corresponding palettes are typically not a good choice for statistical graphics and data visualization.

# In contrast, HCL (hue-chroma-luminance) colors are much more suitable for capturing human color perception (see also hcl) and better color palettes can be derived based on HCL coordinates. Conceptually, three types of palettes are often distinguished:

# Qualitative: For coding categorical information, i.e., where no particular ordering of categories is available and every color should receive the same perceptual weight.

# Sequential: For coding ordered/numeric information, i.e., where colors go from high to low (or vice versa).

# Diverging: Designed for coding numeric information around a central neutral value, i.e., where colors diverge from neutral to two extremes.

# The hcl.colors function provides a basic and lean implementation of the pre-specified palettes in the colorspace package. In addition to the types above, the functions distinguish “diverging” palettes where the two arms are restricted to be rather balanced as opposed to flexible “divergingx” palettes that combine two sequential palettes without any restrictions. The latter group also includes the cividis palette as it is based on two different hues (blue and yellow) but it is actually a sequential palette (going from dark to light).

# The names of all available HCL palettes can be queried with the hcl.pals function and they are also visualized by color swatches in the examples. Many of the palettes closely approximate palettes of the same name from various other packages (including RColorBrewer, rcartocolor, viridis, scico, among others).

# The default HCL palette is the widely used viridis palette which is a sequential palette with relatively high chroma throughout so that it also works reasonably well as a qualitative palette. However, while viridis is a rather robust default palette, more suitable HCL palettes are available for most visualizations.

# For example, "Dark 3" works well for shading points or lines in up to five groups, "YlGnBu" is a sequential palette similar to "viridis" but with aligned chroma/luminance, and "Green-Brown" or "Blue-Red 3" are colorblind-safe diverging palettes.

# Further qualitative palettes are provided in the palette.colors function. While the qualitative palettes in hcl.colors are always based on the same combination of chroma and luminance, the palette.colors vary in chroma and luminance up to a certain degree. The advantage of fixing chroma/luminance is that the perceptual weight of the resulting colors is more balanced. The advantage of allowing variation is that more distinguishable colors can be obtained, especially for viewers with color vision deficiencies.

# Note that the rainbow function implements the (in-)famous rainbow (or jet) color palette that was used very frequently in many software packages but has been widely criticized for its many perceptual problems. It is specified by a start and end hue with red = 0, yellow = 1/6, green = 2/6, cyan = 3/6, blue = 4/6, and magenta = 5/6. However, these are very flashy and unbalanced with respect to both chroma and luminance which can lead to various optical illusions. Also, the hues that are equispaced in RGB space tend to cluster at the red, green, and blue primaries. Therefore, it is recommended to use a suitable palette from hcl.colors instead of rainbow.

# Value
# A character vector cv containing either palette names (for hcl.pals) or n hex color codes (for all other functions). The latter can be used either to create a user-defined color palette for subsequent graphics by palette(cv), a col = specification in graphics functions or in par.

# References
# Wikipedia (2019). HCL color space – Wikipedia, The Free Encyclopedia. https://en.wikipedia.org/w/index.php?title=HCL_color_space&oldid=883465135. Accessed March 26, 2019.

# Zeileis, A., Fisher, J. C., Hornik, K., Ihaka, R., McWhite, C. D., Murrell, P., Stauffer, R. and Wilke, C. O. (2019). “colorspace: A toolbox for manipulating and assessing colors and palettes.” arXiv:1903.06490, arXiv.org E-Print Archive. https://arxiv.org/abs/1903.06490.

# Ihaka, R. (2003). “Colour for presentation graphics.” Proceedings of the 3rd International Workshop on Distributed Statistical Computing (DSC 2003), March 20-22, 2003, Technische Universität Wien, Vienna, Austria. http://www.ci.tuwien.ac.at/Conferences/DSC-2003/.

# Zeileis, A., Hornik, K. and Murrell, P. (2009). Escaping RGBland: Selecting colors for statistical graphics. Computational Statistics & Data Analysis, 53, 3259–3270. doi: 10.1016/j.csda.2008.11.033.

# See Also
# colors, palette, gray.colors, hsv, hcl, rgb, gray and col2rgb for translating to RGB numbers.

# Examples

require("graphics")

# color wheels in RGB/HSV and HCL space
par(mfrow = c(2, 2))
pie(rep(1, 12), col = rainbow(12), main = "RGB/HSV")
pie(rep(1, 12), col = hcl.colors(12, "Set 2"), main = "HCL")
par(mfrow = c(1, 1))

## color swatches for RGB/HSV palettes
demo.pal <-
  function(n, border = if (n < 32) "light gray" else NA,
           main = paste("color palettes;  n=", n),
           ch.col = c("rainbow(n, start=.7, end=.1)", "heat.colors(n)",
                      "terrain.colors(n)", "topo.colors(n)",
                      "cm.colors(n)"))
{
    nt <- length(ch.col)
    i <- 1:n; j <- n / nt; d <- j/6; dy <- 2*d
    plot(i, i+d, type = "n", yaxt = "n", ylab = "", main = main)
    for (k in 1:nt) {
        rect(i-.5, (k-1)*j+ dy, i+.4, k*j,
             col = eval(str2lang(ch.col[k])), border = border)
        text(2*j,  k * j + dy/4, ch.col[k])
    }
}
demo.pal(16)

## color swatches for HCL palettes
hcl.swatch <- function(type = NULL, n = 5, nrow = 11,
  border = if (n < 15) "black" else NA) {
    palette <- hcl.pals(type)
    cols <- sapply(palette, hcl.colors, n = n)
    ncol <- ncol(cols)
    nswatch <- min(ncol, nrow)

    par(mar = rep(0.1, 4),
        mfrow = c(1, min(5, ceiling(ncol/nrow))),
        pin = c(1, 0.5 * nswatch),
        cex = 0.7)

    while (length(palette)) {
        subset <- 1:min(nrow, ncol(cols))
        plot.new()
        plot.window(c(0, n), c(0, nrow + 1))
        text(0, rev(subset) + 0.1, palette[subset], adj = c(0, 0))
        y <- rep(subset, each = n)
        rect(rep(0:(n-1), n), rev(y), rep(1:n, n), rev(y) - 0.5,
             col = cols[, subset], border = border)
        palette <- palette[-subset]
        cols <- cols[, -subset, drop = FALSE]
    }

    par(mfrow = c(1, 1), mar = c(5.1, 4.1, 4.1, 2.1), cex = 1)
}
hcl.swatch()
hcl.swatch("qualitative")
hcl.swatch("sequential")
hcl.swatch("diverging")
hcl.swatch("divergingx")

## heat maps with sequential HCL palette (purple)
image(volcano, col = hcl.colors(11, "purples", rev = TRUE))
filled.contour(volcano, nlevels = 10,
               color.palette = function(n, ...)
                   hcl.colors(n, "purples", rev = TRUE, ...))

## list available HCL color palettes
hcl.pals("qualitative")
hcl.pals("sequential")
hcl.pals("diverging")
hcl.pals("divergingx")
