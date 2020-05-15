
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

## Plot DateTime versus three Sub-metering columns, plotting as a step function and using the appropriate formatting
plot(HHPCr$DateTime, HHPCr$Sub_metering_1, type = "s", col = "black", xlab = "", ylab = "Energy sub metering")
points(HHPCr$DateTime, HHPCr$Sub_metering_2, type = "s", col = "red")
points(HHPCr$DateTime, HHPCr$Sub_metering_3, type = "s", col = "blue")

## Save the screen plot as a .png with 480x480 pixels
dev.copy(png, file = "plot3.png", height= 480, width = 480, units = "px")

## Legend added to the .png instead of screen device for easier alignment
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = "__", col= c("black", "red", "blue"))

## Closing the .png device
dev.off()