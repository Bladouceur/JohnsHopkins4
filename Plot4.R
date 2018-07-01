# Plot 4

library("data.table")

#Get data and Subset it
TablePower <- data.table::fread(input = "household_power_consumption.txt"
                                , na.strings="?")

# Change POSIX to time of day filtering
TablePower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Prevent Sci Notation
TablePower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# Filter Dates for 2007-02-01 and 2007-02-02
TablePower <- TablePower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

# Create the frame to present the 4 graphs in a single png
par(mfrow=c(2,2))

# Recreate the 4 graphs (to comply with all code to a single file requirement)
# Plot 1
plot(TablePower[, dateTime], TablePower[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(TablePower[, dateTime],TablePower[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(TablePower[, dateTime], TablePower[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(TablePower[, dateTime], TablePower[, Sub_metering_2], col="red")
lines(TablePower[, dateTime], TablePower[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(TablePower[, dateTime], TablePower[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()