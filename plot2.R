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

## Plot the second plot
plot(power_new$Global_active_power~power_new$dateTime,type="l",  ylab="Global Active Power (kilowatts)", xlab="")

## save the plot as png file
dev.copy(png,"plot2.png", width=480, height=480)
## close the Device
dev.off()