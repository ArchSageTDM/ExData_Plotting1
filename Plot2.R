
## First load data.table for the fread function
library(data.table)

## Use fread to easily read the data into HouseHold Power Consumption (HHPC)
## specifying ";" seperators and "?" as how N/A was recorded
HHPC <- fread("exdata_data_household_power_consumption//household_power_consumption.txt", sep=';', na.strings = '?')

## Create a subset of HHPC as HHPC reduced (HHPCr), including only the Dates 1/2/2007 and 2/2/2007
HHPCr <- subset(HHPC, Date == "1/2/2007" | Date == "2/2/2007")

## Combine the Date and Time columns into DateTime, which is required for these specified
HHPCr$DateTime <- paste(HHPCr$Date, HHPCr$Time)
HHPCr$DateTime <- strptime(HHPCr$DateTime, format="%d/%m/%Y %H:%M:%S")

## Plot DateTime versus Global Active Power, plotting as a line and useing the appropriate formatting
plot(HHPCr$DateTime, HHPCr$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Save the screen plot as a .png with 480x480 pixels
dev.copy(png, file = "plot2.png", height= 480, width = 480, units = "px")
dev.off()