#Import zip file from website and unzip to create a dataset
library(RCurl)
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
HPC <- read.csv(unz(temp, "household_power_consumption.txt"), header = TRUE, sep = ";", na.string = "?")
unlink(temp)

#convert Date column to date format
HPC$Date <- as.Date(HPC$Date, format = "%d/%m/%Y")

#create a subset dataset for the 2 days in February
days <- subset(HPC, Date == "2007-02-01"| Date == "2007-02-02")

#delete HPC table to save computing space
HPC <-NULL

#convert the columns used in plot to the correct classes
days$Global_active_power <- as.numeric(days$Global_active_power)
days$Timestamp <- strptime(paste(days$Date, days$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")
days$Sub_metering_1 <- as.numeric(days$Sub_metering_1)
days$Sub_metering_2 <- as.numeric(days$Sub_metering_2)
days$Sub_metering_3 <- as.numeric(days$Sub_metering_3)

#make plot3.png file, using the following steps
#1 open new png file named plot3
#2 create plot
#3 close png file
png("plot3.png", width = 480, height = 480, units = "px")
with(days, plot(Timestamp,Sub_metering_1, type ="s", xlab = "", ylab ="Energy sub metering"))
with(days, points(Timestamp, Sub_metering_2, type ="s", col = "red"))
with(days, points(Timestamp, Sub_metering_3, type ="s", col = "blue"))
legend("topright", lty = 1, lwd = 2.5, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()