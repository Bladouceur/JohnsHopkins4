# Plot 2

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

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = TablePower[, dateTime]
     , y = TablePower[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

#__________________________________________________________________