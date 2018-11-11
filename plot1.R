## read the dataset

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", 
                   colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))


## Format date type
power$Date <- as.Date(power$Date, "%d/%m/%Y")

## subset only the 2 relevant days
power_new<- subset(power,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## Remove NA part from the data set
power_new <- power_new[complete.cases(power_new),]


## Plot the first plot
hist(power_new$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")