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

#make plot1.png file, using the following steps
#1 open new png file named plot1
#2 create plot
#3 close png file
png("plot1.png",width = 480, height = 480, units = "px")
hist(days$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()