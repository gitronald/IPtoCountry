#' Random IP address generator
#'
#' @param n number of IP addresses to return
#'
#' @return Returns a random IP address vector of length \code{n}
#' @export
#'
#' @examples
#' # Generate 100 random IP addresses
#' IP_generator(100)
IP_generator <- function(n) {
  ips <- vector("list", n)
  ips <- lapply(ips, function(x) x <- paste(sample(1:255, 1),
                                            sample(0:255, 1),
                                            sample(0:255, 1),
                                            sample(0:255, 1),
                                            sep = "."))
  ips <- unlist(ips)

  return(ips)
}
