# Create test data

IPs <- IP_generator(1000)

devtools::use_data(IPs, overwrite = T)
