
<!-- README.md is generated from README.Rmd. Please edit that file -->

# galisats

<!-- badges: start -->

<!-- badges: end -->

galisats is used to determine the positions of the four greatest
satellites of Jupiter (called Galilean satellites). Positions are
calculated for any given time (ET – Ephemeris Time) with respect to the
planet, as seen from the Earth.

The galsat() function displays numerical values of the satellites’
positions:

x – the apparent rectangular coordinate of the satellite with respect to
the center of Jupiter’s disk in the equatorial plane in the units of
Jupiter’s equatorial radius; X is positive toward the west

y – the apparent rectangular coordinate of the satellite with respect to
the center of Jupiter’s disk from the equatorial plane in the units of
Jupiter’s equatorial radius; Y is positive toward the north

The function is based on algorithms in the book:

Astronomical Formulae for Calculators (4th edition), Jean Meeus,
Willmann-Bell Inc., 1988

## Installation

You can install the development version of galisats from \[GitHub\]
(<https://github.com/>) with:

``` r
# install.packages("galisats")
# devtools::install_github("...")
```

## Example

This is an example of using the function galsat():

``` r
library(galisats)
galsat(2025, 10, 24, 21, 40)
#> [1] "SATELLITES OF JUPITER"
#> [1] "Positions of the Galilean satellites."
#> Date: 24 - 10 - 2025 
#> Time [ET]: 21 : 40 
#> [1] "x: West(+), East(-)"
#> Io        -3.256 
#> Europa    -9.34 
#> Ganymede  -9.426 
#> Callisto  21.316 
#> [1] "y: North(+), South(-)"
#> Io        0.126 
#> Europa    -0.034 
#> Ganymede  0.297 
#> Callisto  0.389
#>       moon         x           y
#> 1       Io -3.255759  0.12577187
#> 2   Europa -9.340223 -0.03425914
#> 3 Ganymede -9.425965  0.29703775
#> 4 Callisto 21.315965  0.38917625
```
