# Plot 1
library("data.table")

#Get data and Subset it
TablePower <- data.table::fread(input = "household_power_consumption.txt"
                                , na.strings="?")


# Change var Date Column to Date Type
TablePower[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Prevent Sci Notation
TablePower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# Filter Dates for 2007-02-01 and 2007-02-02
TablePower <- TablePower[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(TablePower[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
#________________________________
