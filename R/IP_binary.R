#' Convert IP address to binary
#'
#' Create method for splitting an IP address values into lists of binary values
#'
#' @param IP.address A character vector of IP addresses
#' @param as.list logical, \code{FALSE} returns a named character vector instead of a list
#'
#' @return A list of IP addresses converted to character strings of binary
#'   values
#' @export
#'
IP_binary <- function(IP.address, as.list = FALSE) {
  IPs <- IP_split(IP.address)
  IPs <- split(IPs, seq(nrow(IPs)))

  IPs2 <- lapply(IPs, function(x) {
    lapply(x, function(y){
      binary_vector <- rev(as.numeric(intToBits(y)))
      binary_vector <- binary_vector[-(1:(length(binary_vector) - 8))]
    })
  })

  binary.collapse <- lapply(IPs2, function(x){
    lapply(x, paste, collapse = "")
  })

  binary.collapse <- lapply(binary.collapse, paste, collapse = "")
  if(!as.list){
    binary.collapse <- unlist(binary.collapse)
  }

  return(binary.collapse)
}
