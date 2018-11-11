## read the dataset

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                    colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


## Format date type
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## subset only the 2 relevant days
power_new<- subset(power,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Remove NA part from the data set
power_new <- power_new[complete.cases(power_new),]

## create a new column by combining Date and Time column
dateTime <- paste(power_new$Date, power_new$Time)

## Name the vector as DateTime
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
power_new <- power_new[ ,!(names(power_new) %in% c("Date","Time"))]

## Add DateTime column to the data set
power_new <- cbind(dateTime, power_new)

## Format dateTime Column
power_new$dateTime <- as.POSIXct(dateTime)

## Create Plot3
with(power_new, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## save the plot as png file
dev.copy(png,"plot3.png", width=480, height=480)
## close the Device
dev.off()