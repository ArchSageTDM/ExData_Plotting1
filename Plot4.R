
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

## Setting up a 2x2 area for the 4 plots
par(mfrow = c (2,2))

## Plot 1 of 4, DateTime versus Global Active Power
plot(HHPCr$DateTime, HHPCr$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

## Plot 2 of 4, DateTime versus Voltage
plot(HHPCr$DateTime, HHPCr$Voltage, type = "l", xlab = "DateTime", ylab = "Voltage")

## Plot 3 of 4, DateTime versus Sub-Metering. Note that legend was created with an inset prior to saving as .png device
plot(HHPCr$DateTime, HHPCr$Sub_metering_1, type = "s", col = "black", xlab = "", ylab = "Energy sub metering")
points(HHPCr$DateTime, HHPCr$Sub_metering_2, type = "s", col = "red")
points(HHPCr$DateTime, HHPCr$Sub_metering_3, type = "s", col = "blue")
legend("topright", inset = c( .15, 0), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch = "__", col= c("black", "red", "blue"))

## Plot 4 of 4, DateTime versus Global Reactive Power
plot(HHPCr$DateTime, HHPCr$Global_reactive_power, type = "l", xlab = "DateTime", ylab = "Global Reactive Power")

## Save the screen plot as a .png with 480x480 pixels and closing the device
dev.copy(png, file = "plot4.png", height= 480, width = 480, units = "px")
dev.off()