# Plot 3

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

png("plot3.png", width=480, height=480)

# Plot 3
plot(TablePower[, dateTime], TablePower[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(TablePower[, dateTime], TablePower[, Sub_metering_2],col="red")
lines(TablePower[, dateTime], TablePower[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()

#___________________________________________