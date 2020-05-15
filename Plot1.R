
## First load data.table for the fread function
library(data.table)

## Use fread to easily read the data into HouseHold Power Consumption (HHPC)
## specifying ";" seperators and "?" as how N/A was recorded
HHPC <- fread("exdata_data_household_power_consumption//household_power_consumption.txt", sep=';', na.strings = '?')

## Create a subset of HHPC as HHPC reduced (HHPCr), including only the Dates 1/2/2007 and 2/2/2007
HHPCr <- subset(HHPC, Date == "1/2/2007" | Date == "2/2/2007")

## Create a histogram of Global Active Power, with appropriate formatting
hist(HHPCr$Global_active_power, breaks = 12, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

## Save the screen plot as a .png with 480x480 pixels
dev.copy(png, file = "plot1.png", height= 480, width = 480, units = "px")
dev.off()