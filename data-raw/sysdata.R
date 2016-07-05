library(devtools)

# Load hand matched country names
sysdata = read.table("data-raw/matched_country_names.txt", sep= "\t", quote = "", header = TRUE)

# Clean extra quotes
sysdata$IP.Countries = gsub("\"", "", sysdata$IP.Countries)

# Save data
use_data(sysdata, internal = T)
