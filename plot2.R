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

## Create plot2.png
png(filename = "plot2.png")
with(confilter, 
     plot(Time, 
          Global_active_power, 
          type = "l", 
          ylab = "Global Active Power (kilowatts)", 
          xlab = NA))
dev.off()