library(dplyr)
## Download file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "consumption.zip")
unzip(zipfile = "consumption.zip")

## Load the file into memory.
consumption <- tbl_df(read.delim("household_power_consumption.txt", 
                                 sep = ";", 
                                 na.strings = "?"))

## Clean the Date and Time columns
consumption <- mutate(consumption, Time = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")))
consumption <- mutate(consumption, Date = as.Date(Date, format = "%d/%m/%Y"))

## Filter down to dates in question.
confilter <- filter(consumption, Date >= "2007-02-01" & Date <= "2007-02-02")

## Create plot3.png
png(filename = "plot3.png")

with(confilter, plot(Time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = NA))
with(confilter, points(Time, Sub_metering_2, type = "l", col = "red"))
with(confilter, points(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, 
       col = c("black", "red", "blue"), 
       cex = .75)

dev.off()