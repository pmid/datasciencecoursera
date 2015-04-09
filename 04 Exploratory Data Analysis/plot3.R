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

# add DateTime column
d1  <- paste(data$Date, data$Time)
data$DateTime <- strptime(d1, "%Y-%m-%d %H:%M:%S")

#plot 3
# dimension graph with pmax(Sub_metering_1, Sub_metering_2, Sub_metering_3) so that max of the three vectors is used
png(filename="plot3.png", width=480, height=480)
with (data, {
  plot(DateTime, pmax(Sub_metering_1, Sub_metering_2, Sub_metering_3), xlab="", ylab="Energy sub metering", type="n")
  lines(DateTime, Sub_metering_1, type="l", col = "black")
  lines(DateTime, Sub_metering_2, type="l", col = "red")
  lines(DateTime, Sub_metering_3, type="l", col = "blue")

  legend("topright", lwd=1, lty=c(1,1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()
