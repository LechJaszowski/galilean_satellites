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
#' @importFrom png readPNG
#'
#' @export
#'
#' @examples
#' galdraw(2025, 10, 13, 23, 30)
galdraw <- function(year, month, day, hour, minute) {

    #storing the results of the galsat function
    p <- galsat(year, month, day, hour, minute)
    io_x <- p[1, 2]
    io_y <- p[1, 3]
    eu_x <- p[2, 2]
    eu_y <- p[2, 3]
    ga_x <- p[3, 2]
    ga_y <- p[3, 3]
    ca_x <- p[4, 2]
    ca_y <- p[4, 3]

    # inserting a title, date and time
    graphics::plot(c(-30, 30), c(-30, 30), type = "n", axes = FALSE, xlab = "", ylab = "", asp = 1)
    graphics::text(0, 28, "SATELLITES OF JUPITER", col = "black", cex = 1.7, adj = 0.5)
    graphics::text(0, 24,
                   paste0('Date: ', year, '-', sprintf("%02d", month), '-', sprintf("%02d", day)),
                   col = "black", cex = 1.2, adj = 0.5)
    graphics::text(0, 21,
                   paste0('Time [ET]: ', sprintf("%02d", hour), ':', sprintf("%02d", minute)),
                   col = "black", cex = 1.2, adj = 0.5)

    # inserting an image of Jupiter in the center of the plot
    jupiter <- png::readPNG(system.file("jupiter.png", package = "galisats"))
    graphics::rasterImage(jupiter, xleft = -1, ybottom = -1, xright = 1, ytop = 1)

    # drawing the moons with their labels
    if (sqrt(io_x^2 + io_y^2) > 1 | u1_corrected < 90 | u1_corrected > 270) {
        graphics::points(io_x, io_y, col = "red", pch = 20);
        graphics::text(io_x, io_y + 3, "I", col = "red", cex = 0.8, adj = 0.5)
    }
    if (sqrt(eu_x^2 + eu_y^2) > 1 | u2_corrected < 90 | u2_corrected > 270) {
        graphics::points(eu_x, eu_y, col = "blue", pch = 20);
        graphics::text(eu_x, eu_y + 3, "E", col = "blue", cex = 0.8, adj = 0.5)
    }
    if (sqrt(ga_x^2 + ga_y^2) > 1 | u3_corrected < 90 | u3_corrected > 270) {
        graphics::points(ga_x, ga_y, col = "green", pch = 20);
        graphics::text(ga_x, ga_y + 3, "G", col = "green", cex = 0.8, adj = 0.5)
    }
    if (sqrt(ca_x^2 + ca_y^2) > 1 | u4_corrected < 90 | u4_corrected > 270) {
        graphics::points(ca_x, ca_y, col = "magenta", pch = 20);
        graphics::text(ca_x, ca_y + 3, "C", col = "magenta", cex = 0.8, adj = 0.5)
    }
}
