library(data.table)
pathToData <- "~/Downloads/household_power_consumption.txt"
# set path to Data
data <- fread(pathToData, na.strings = "?")
# reads data into object data (noting that no data is marked with "?")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
# convert Date variable into Date class
data$newdate <- with(data, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M"))
# write new variable "newdate" as old Date and Time
d1 <- as.Date("2007-02-01")
d2 <- as.Date("2007-02-02")
newdata <- data[data$Date %in% d1:d2,]
# subsets data for required dates and stores in new object newdata

png(file="plot4.png")
# opens graphics device
par(mar = c(4, 4, 2, 2))
#sets margins
par(mfrow = c(2,2))
#sets plot layout - 2 x 2 grid of plots by row
plot(newdata$newdate, newdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")
plot(newdata$newdate, newdata$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
plot(newdata$newdate, newdata$Sub_metering_1, type= "n", ylab = "Energy sub metering", xlab = "")
lines(newdata$newdate, newdata$Sub_metering_1)
lines(newdata$newdate, newdata$Sub_metering_2, col="red")
lines(newdata$newdate, newdata$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1, bty = "n")
plot(newdata$newdate, newdata$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
#creates four plots required
dev.off()
#closes graphics device