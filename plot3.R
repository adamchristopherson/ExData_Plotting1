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
png(file="plot3.png")
# opens graphics device
plot(newdata$newdate, newdata$Sub_metering_1, type= "n", ylab = "Energy sub metering", xlab = "")
#draws empty plot
lines(newdata$newdate, newdata$Sub_metering_1)
lines(newdata$newdate, newdata$Sub_metering_2, col="red")
lines(newdata$newdate, newdata$Sub_metering_3, col="blue")
#adds lines for each variable
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)
#creates legend
dev.off()
#closes graphics device