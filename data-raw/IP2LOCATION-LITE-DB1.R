# IP to country database
# http://download.ip2location.com/lite/
#
# DB1.LITE edition is licensed under Creative Commons
# Attribution-ShareAlike 4.0 International License
#
# This site or product includes IP2Location LITE data
# available from # http://lite.ip2location.com.
# IP2Location LITE Edition is free package with accuracy up to Class C (192.168.1.X) only.

# Download data from website
download.file("http://download.ip2location.com/lite/IP2LOCATION-LITE-DB1.CSV.ZIP",
              "data-raw/ip2location.lite.db1.zip",
              mode = "wb")

# Unzip and read in
ip2location.lite.db1 <- read.csv(unzip("data-raw/ip2location.db1.zip",
                                       "IP2LOCATION-LITE-DB1.CSV"),
                                       col.names = c("IPfrom", "IPto", "Abrv", "Country"),
                                 sep = ",")

# Save to /data
devtools::use_data(ip2location.lite.db1, overwrite = T)
