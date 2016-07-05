# IPtoCountry

[![Build Status](https://travis-ci.org/gitronald/IPtoCountry.svg?branch=master)](https://travis-ci.org/gitronald/IPtoCountry)

<!--
[![CRAN_Downloads_Badge](http://cranlogs.r-pkg.org/badges/grand-total/IPtoCountry)](http://cran.r-project.org/package=IPtoCountry)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/IPtoCountry)](http://cran.r-project.org/package=IPtoCountry)
-->


* Functions for converting IP addresses (IPv4) into country names or location details in R.

<sub>Default database is available by Creative Commons Attribution-ShareAlike 4.0 Interational license (CC-BY-SA 4.0).  
This site or product includes IP2Location LITE data available from http://www.ip2location.com.</sub>

### Getting Started
``` {r}
devtools::install_github("gitronald/IPtoCountry")
library(IPtoCountry)
data(IPs)
```

### IP Addresses
Internet Protocol (IP) addresses serve as the feelers upon which the Internet is able to connect computers and servers across great distances and within complicated clusters. These IP addresses come in two forms, IPv4 and IPv6:  
* Example IPv4 address: `180.20.23.162`  
* Example IPv6 address: `2001:0db8:0000:0042:0000:8a2e:0370:7334`  

IPv6 was built to overcome the eventual exhaustion of available IPv4 addresses, but that hasn't largely happened yet, so our focus here in on IPv4.

------
### How to Determine the Location of an IP Address

##### Step 1 - Split IP address into four octets  

``` {r}
> IP_split("180.20.23.162")
```
```{r}
         [,1] [,2] [,3] [,4]
ip.split  180   20   23  162
```

##### Step 2 - Calculate IP Integer from Octets  

* By hand:

``` {r}
> Octet1 = 180
> Octet2 = 20
> Octet3 = 23
> Octet4 = 162
> (Octet1 * 256^3) + (Octet2 * 256^2) + (Octet3 * 256^1) + (Octet4 * 256^0)
```

``` {r}
[1] 3021215650
```

* Function:

``` {r}
> IP_integer("180.20.23.162")
```

``` {r}
[1] 3021215650
```

##### Step 3 - Lookup IP Integer in a Database  

``` {r}
> IP_lookup(3021215650)
```
``` {r}
[1] "China"
```

------
### IP_country - Convert IP address to country name
* All of the above in one simple function
* Powered by `data.table`

``` {r}
> IP_country("180.20.23.162")

```

``` {r}
[1] China
Levels: China
```

------
### IP_location - Convert IP address into detailed location 
* Produces dataframe with country abreviation, country name, region, city, zip code, latitude, longitude, and GMT

``` {r}
> IP_location("180.20.23.162")

```

``` {r}
  abrv country  region    city    zip     lat      long    gmt
1   CN   China Beijing Beijing 100006 39.9075 116.39723 +08:00
```

------
### IP_plot - Convert IPs to countries and plot on world map
* Enter IPs, get a  map with gradient coloring reflecting the percentage of IP addresses originating in each country

``` {r}
> IP_plot(IPs)
```

![](https://i.imgur.com/Fymyju2.png)

------
### IP_generator - Generate random IP addresses
* Generate five random IP addresses
``` {r}
> IP_generator(5)
```

``` {r}
[1] "125.65.50.53"    "79.250.76.62"    "142.245.152.177" "230.76.201.42"   "107.182.57.171" 
```

------
### Speed

* IPs to country names
``` {r}
# Test processing speed on sample of 1000 IPs
> library(microbenchmark)
> microbenchmark(IP_country(IPs))
```
``` {r}
Unit: milliseconds
            expr      min       lq    mean  median       uq      max neval
 IP_country(IPs) 85.27124 87.03638 91.0021 87.6341 89.12941 206.8301   100
```

* IPs to full location details
``` {r}
> microbenchmark(IP_location(IPs))
```

``` {r}
Unit: seconds
             expr      min       lq     mean  median       uq     max neval
 IP_location(IPs) 3.673867 4.228647 4.614923 4.44011 4.993532 6.40974   100
```

