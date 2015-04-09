#download and unzip data file, create directory "data" if not existing
if (!file.exists("data")) {
  dir.create("data")
}
if (!file.exists("data/household_power_consumption.zip")) {
  fileurl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  #add method = "curl" for mac
  download.file(fileurl, destfile="data/household_power_consumption.zip")
  unzip("data/household_power_consumption.zip", exdir = "data")
}

startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

# read whole file
data <- read.csv("data/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=F, header=T)
data[,1] <- as.Date(data[,1], "%d/%m/%Y")

#filter by date
data <- data[data$Date >= startDate & data$Date <= endDate, ]

# set locale, otherwise x axis days could be written in italian
Sys.setlocale("LC_TIME", "English")

#plot 1
png(filename="plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", main="", xlab="", ylab="")
title(main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
