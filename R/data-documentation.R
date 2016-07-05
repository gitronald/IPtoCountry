#' IP addresses
#'
#' A dataset containing 1000 randomly generated IP addresses
#'
#' @format A character vector with length 1000
#' @source Generated using \code{\link{IP_generator}}
"IPs"


#' IP database - small
#'
#' A dataset containing 149,449 IP integer ranges and their corresponding country
#' names and abbreviations
#'
#' Last updated: 06/06/2016
#'
#' @format A data.frame with four variables
#' \describe{
#'   \item{IPfrom}{Start of IP integer range}
#'   \item{IPto}{End of IP integer range}
#'   \item{Abrv}{Two-character country code based on ISO 3166.}
#'   \item{Country}{Country name based on ISO 3166.}
#' }
#' @source \url{http://lite.ip2location.com}
"ip2location.lite.db1"


#' IP database - large
#'
#' A dataset containing 3,832,909 IP integer ranges and their corresponding country
#' names, abbreviations, regions, cities, latitudes, longitudes, zip codes, and Greenwich Mean Times
#'
#' Last updated: 06/02/2016
#'
#'
#' @format A data.frame with ten variables
#' \describe{
#'   \item{IPfrom}{Start of IP integer range}
#'   \item{IPto}{End of IP integer range}
#'   \item{Abrv}{Two-character country code based on ISO 3166.}
#'   \item{Country}{Country name based on ISO 3166.}
#'   \item{Region}{Region within country}
#'   \item{City}{City within region}
#'   \item{Lat}{Latitude}
#'   \item{Long}{Longitude}
#'   \item{Zip}{Zip code}
#'   \item{GMT}{Greenwich Mean Time}
#' }
#' @source \url{http://lite.ip2location.com}
"ip2location.lite.db11"
