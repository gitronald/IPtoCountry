# This line of code appeases the CRAN check for visible bindings, see:
# http://stackoverflow.com/questions/9439256/how-can-i-handle-r-cmd-check-no-visible-binding-for-global-variable-notes-when?rq=1
utils::globalVariables(c("ip2location.lite.db1", "IPfrom", "IPto",
                         "Country", ".", ":=", "i", "Abrv",
                         "City", "GMT", "Lat", "Long", "Region",
                         "Zip", "aggregate", "group", "ip2location.lite.db11",
                         "lat", "long", "prop"
                         )
                       )


#' Convert IP address to country name
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see \code{?ip2location.lite.db1}
#' @return Returns a factor vector of country names corresponding to
#'   \code{IP.address}
#'
#' @export
#' @examples
#' IP_country(IPs)
#'
IP_country <- function(IP.address, IP.database = NULL) {
  IP.integer <- IP_integer(IP.address)
  country <- IP_lookup(IP.integer, IP.database)
  country <- factor(country)
  return(country)
}


#' Convert IP address to IP integer
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @return Returns a numeric vector of IP integers from \code{IP.address}. The
#'   coversion formula used here splits the string into four octets, multiplies
#'   the first three by 256^(4-n), and takes the sum of the four modified
#'   octets.
#' @export
#' @examples
#' head(IP_integer(IPs))
#'
IP_integer <- function(IP.address) {

  ip.split <- IP_split(IP.address)
  ip.integer = unname(16777216*ip.split[, 1] + 65536*ip.split[, 2] + 256*ip.split[, 3] + ip.split[, 4])
  return(ip.integer)
}


#' Split IP addresses
#'
#' @param IP.address vector of IPv4 addresses
#' @param integer logical, convert output to class integer
#' @param data.frame logical, convert output to data.frame
#'
#' @return Returns a matrix or data.frame with four columns and as many rows as
#'   IP.addresses were inputted
#' @export
#'
#' @examples
#' head(IP_split(IPs))
IP_split <- function(IP.address, integer = TRUE, data.frame = TRUE) {
  ip.split <- strsplit(IP.address, "\\.")
  ip.split <- do.call(rbind, ip.split)
  if(integer) ip.split <- apply(ip.split, 2, as.integer)
  if(data.frame) ip.split <- as.data.frame(ip.split)
  if(length(IP.address) == 1) ip.split = t(ip.split)
  return(ip.split)
}

#' Match IP integer to country name
#'
#' @param IP.integer a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see \code{?ip2location.lite.db1} for details on
#'   default database from \url{http://lite.ip2location.com}
#' @return Returns country from IP integers
#' @importFrom data.table setDT setkey data.table foverlaps
#' @export
#' @examples
#' IP.integer <- IP_integer(IPs)
#' IP_lookup(IP.integer)
IP_lookup <- function(IP.integer, IP.database = NULL) {
  if(is.null(IP.database)) IP.database <- ip2location.lite.db1
  DT <- setDT(IP.database)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = IP.integer, IPto = IP.integer)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Country)]
  final <- as.character(final[[1]])
  return(final)
}


#' Match IP integer to all location data
#'
#' @param IP.integer a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see \code{?ip2location} for details on
#'   default database from \url{http://lite.ip2location.com}
#' @return Returns country from IP integers
#' @importFrom data.table setDT setkey data.table foverlaps
#' @export
#' @examples
#' IP.integer <- IP_integer(IPs)
#' IP_lookup_full(IP.integer)
IP_lookup_full <- function(IP.integer, IP.database = NULL) {
  if(is.null(IP.database)) IP.database <- ip2location.lite.db11
  DT <- setDT(IP.database)
  setkey(DT, IPfrom, IPto)
  DT2 <- data.table(IPfrom = IP.integer, IPto = IP.integer)
  res <- foverlaps(DT2, DT[, .(IPfrom, IPto)], type="within")
  res[, i:=seq_len(nrow(res))]
  setkey(res, i)
  final <- merge(res, DT, by=c("IPfrom", "IPto"))[order(i), .(Abrv, Country,
                                                              Region, City,
                                                              Zip, Lat,
                                                              Long, GMT)]

  abrv <- as.vector(as.character(final[[1]]))
  country <- as.vector(as.character(final[[2]]))
  region <- as.vector(as.character(final[[3]]))
  city <- as.vector(as.character(final[[4]]))
  zip <- as.vector(as.character(final[[5]]))
  lat <- as.vector(as.character(final[[6]]))
  long <- as.vector(as.character(final[[7]]))
  gmt <- as.vector(as.character(final[[8]]))

  final <- data.frame(abrv, country, region, city, zip, lat, long, gmt)
  return(final)
}


#' Convert IP address to location (country name, region, city, zip code,
#' latitude, longitude, and GMT)
#'
#' @param IP.address a character or factor vector of one or more IP addresses
#' @param IP.database an IP database, see \code{?ip2location.lite.db11}
#' @return Returns a data.frame containin the country name, region, city, and
#'   zip code corresponding to \code{IP.address}
#'
#' @export
#' @examples
#' IP_location(IPs)
#'
IP_location <- function(IP.address, IP.database = NULL) {
  IP.integer <- IP_integer(IP.address)
  country <- IP_lookup_full(IP.integer, IP.database)
  return(country)
}
