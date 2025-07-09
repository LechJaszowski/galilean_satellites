#' Draw the Jupiter and Galilean satellites
#'
#' @description
#' `galdraw()` is used to show the positions of the four greatest satellites
#' of Jupiter (called Galilean satellites). Positions are shown for any
#' given time (ET – Ephemeris Time) with respect to the planet, as seen from the Earth.
#'
#' @param year Type in the year (integer number greater then or equal 0).
#' @param month Type in the month (integer number from 1 to 12).
#' @param day Type in the day (integer number from 1 to 31).
#' @param hour Type in the hour (integer number from 0 to 23).
#' @param minute Type in the minute (integer number from 0 to 59).
#'
#' @returns
#' A plot.
#'
#' @export
#'
#' @examples
#' galdraw(2025, 10, 13, 23, 30)
galdraw <- function(year, month, day, hour, minute) {
    p <- galsat(year, month, day, hour, minute)
    io_x <- p[1, 2]
    io_y <- p[1, 3]
    eu_x <- p[2, 2]
    eu_y <- p[2, 3]
    ga_x <- p[3, 2]
    ga_y <- p[3, 3]
    ca_x <- p[4, 2]
    ca_y <- p[4, 3]
    graphics::plot(c(-30, 30), c(-30, 30), type = "n", axes = FALSE, xlab = "", ylab = "")
    graphics::points(0, 0, col = "black", pch = 1, cex = 2) # Jupiter
    graphics::text(0, 2, "Jupiter", cex = 0.8)
    graphics::points(io_x, io_y, col = "black", pch = 20)
    graphics::points(eu_x, eu_y, col = "black", pch = 20)
    graphics::points(ga_x, ga_y, col = "black", pch = 20)
    graphics::points(ca_x, ca_y, col = "black", pch = 20)
}
