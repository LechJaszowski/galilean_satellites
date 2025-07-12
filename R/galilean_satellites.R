radians <- function(degree) {
    degree * pi / 180
}

degrees <- function(radian) {
    radian * 180 / pi
}

u1_corrected <<- 0
u2_corrected <<- 0
u3_corrected <<- 0
u4_corrected <<- 0

#' Calculate the positions of the Galilean satellites
#'
#' @description
#' `galsat()` is used to determine the positions of the four greatest satellites
#' of Jupiter (called Galilean satellites). Positions are calculated for any
#' given time (ET – Ephemeris Time) with respect to the planet, as seen from the Earth.
#'
#' The `galsat()` function displays numerical values of the satellites’ positions:
#'
#'   x – the apparent rectangular coordinate of the satellite with respect to the
#' center of Jupiter’s disk in the equatorial plane in the units of Jupiter’s
#' equatorial radius; X is positive toward the west
#'
#'   y – the apparent rectangular coordinate of the satellite with respect to the
#' center of Jupiter’s disk from the equatorial plane in the units of Jupiter’s
#' equatorial radius; Y is positive toward the north
#'
#' @details
#' The function is based on algorithms in the book:
#' Astronomical Formulae for Calculators (4th edition), Jean Meeus, Willmann-Bell Inc., 1988
#'
#' @param year Type in the year (integer number greater then or equal 0).
#' @param month Type in the month (integer number from 1 to 12).
#' @param day Type in the day (integer number from 1 to 31).
#' @param hour Type in the hour (integer number from 0 to 23).
#' @param minute Type in the minute (integer number from 0 to 59).
#'
#' @returns
#' `data.frame`: 4 observations of 3 variables:
#' $ moon: chr "Io" "Europa" "Ganymede" "Callisto"
#' $ x   : num
#' $ y   : num
#' Four rows - each row has the position (x,y) of one moon.
#'
#' @export
#'
#' @examples
#' galsat(2025, 10, 13, 23, 30)

galsat <- function(year, month, day, hour, minute) {
    print('SATELLITES OF JUPITER')
    print('Positions of the Galilean satellites.')
    cat('Date:', sprintf("%02d", day), '-', sprintf("%02d", month), '-', year, "\n")
    cat('Time [ET]:', sprintf("%02d", hour), ':', sprintf("%02d", minute), "\n")
    DDdd <- day + hour / 24 + minute / 1440
    if (month >= 3) {y <- year; m <- month} else {y <- year - 1; m <- month + 12}
    JD <- floor(365.25 * y) + DDdd + 1720994.5 + floor(30.6001 * (m + 1))
    YYYYMMDDdd <- year + .01 * month + .0001 * DDdd
    if (YYYYMMDDdd >= 1582.1015) {B_c_aux <- floor(.01 * y);
                                  B_correction <- 2 - B_c_aux + floor(B_c_aux / 4);
                                  JD <- JD + B_correction}
    d <- JD - 2415020
    Vdeg <- 134.63 + .00111587 * d
    Mdeg <- 358.476 + .9856003 * d
    Ndeg <- 225.328 + .0830853 * d + .33 * sin(radians(Vdeg))
    Jdeg <- 221.647 + .9025179 * d - .33 * sin(radians(Vdeg))
    Adeg <- 1.916 * sin(radians(Mdeg)) + .02 * sin(radians(2 * Mdeg))
    Bdeg <- 5.552 * sin(radians(Ndeg)) + .167 * sin(radians(2 * Ndeg))
    K <- (Jdeg + Adeg - Bdeg) %% 360
    R_AU <- 1.00014 - .01672 * cos(radians(Mdeg)) - .00014 * cos(radians(2 * Mdeg))
    rj_AU <- 5.20867 - .25192 * cos(radians(Ndeg)) - .0061 * cos(radians(2 * Ndeg))
    delta_AU <- sqrt(R_AU ** 2 + rj_AU ** 2 - 2 * R_AU * rj_AU * cos(radians(K)))
    psi <- degrees(asin(R_AU * sin(radians(K)) / delta_AU))
    u1_deg <- 84.5506 + psi - Bdeg + 203.405863 * (d - delta_AU / 173)
    u2_deg <- 41.5015 + psi - Bdeg + 101.2916323 * (d - delta_AU / 173)
    u3_deg <- 109.977 + psi - Bdeg + 50.2345169 * (d - delta_AU / 173)
    u4_deg <- 176.3586 + psi - Bdeg + 21.4879802 * (d - delta_AU / 173)
    Gdeg <- 187.3 + 50.310674 * (d - delta_AU / 173)
    Hdeg <- 311.1 + 21.569229 * (d - delta_AU / 173)
    u1_correction <- .472 * sin(radians(2 * (u1_deg - u2_deg)))
    u2_correction <- 1.073 * sin(radians(2 * (u2_deg - u3_deg)))
    u3_correction <- .174 * sin(radians(Gdeg))
    u4_correction <- .845 * sin(radians(Hdeg))
    r1 <- 5.9061 - .0244 * cos(radians(2 * (u1_deg - u2_deg)))
    r2 <- 9.3972 - .0889 * cos(radians(2 * (u2_deg - u3_deg)))
    r3 <- 14.9894 - .0227 * cos(radians(Gdeg))
    r4 <- 26.3649 - .1944 * cos(radians(Hdeg))
    u1_corrected <<- (u1_deg + u1_correction) %% 360
    u2_corrected <<- (u2_deg + u2_correction) %% 360
    u3_corrected <<- (u3_deg + u3_correction) %% 360
    u4_corrected <<- (u4_deg + u4_correction) %% 360
    lambd <- 238.05 + .083091 * d + .33 * sin(radians(Vdeg)) + Bdeg
    De <- 3.07 * sin(radians(lambd + 44.5)) - 1.31 * (rj_AU - delta_AU) *
        sin(radians(lambd - 99.4)) / delta_AU - 2.15 * sin(radians(psi)) * cos(radians(lambd + 24))
    x1 <- r1 * sin(radians(u1_corrected))
    x2 <- r2 * sin(radians(u2_corrected))
    x3 <- r3 * sin(radians(u3_corrected))
    x4 <- r4 * sin(radians(u4_corrected))
    y1 <- -r1 * cos(radians(u1_corrected)) * sin(radians(De))
    y2 <- -r2 * cos(radians(u2_corrected)) * sin(radians(De))
    y3 <- -r3 * cos(radians(u3_corrected)) * sin(radians(De))
    y4 <- -r4 * cos(radians(u4_corrected)) * sin(radians(De))

    # shows results to 3 decimal places
    print("x: West(+), East(-)")
    cat("Io       ", round(x1, 3), "\n")
    cat("Europa   ", round(x2, 3), "\n")
    cat("Ganymede ", round(x3, 3), "\n")
    cat("Callisto ", round(x4, 3), "\n")
    print("y: North(+), South(-)")
    cat("Io       ", round(y1, 3), "\n")
    cat("Europa   ", round(y2, 3), "\n")
    cat("Ganymede ", round(y3, 3), "\n")
    cat("Callisto ", round(y4, 3), "\n")

    result <- data.frame(
        moon = c("Io", "Europa", "Ganymede", "Callisto"),
        x = c(x1, x2, x3, x4),
        y = c(y1, y2, y3, y4)
    )

    return(result)
}
