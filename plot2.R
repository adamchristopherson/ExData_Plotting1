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
png(file="plot2.png")
# opens graphics device
plot(newdata$newdate, newdata$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
#creates plot
dev.off()
#closes graphics device