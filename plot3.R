# Downloaded and extracted file to current working directory

# read the csv/txt file, sep = ';'
data <- read.csv('household_power_consumption.txt',sep = ';', header = TRUE)

data$Date_Clean = as.Date(data$Date,"%d/%m/%Y")
data$Time_Clean = strptime(data$Time,format = "54%H:%M:%S")
data$weekday =  weekdays(data$Date_Clean)

# filter just for 2007-02-01 and 2007-02-02
two_days <- subset(data,data$Date_Clean >= "2007-02-01" & data$Date_Clean <= "2007-02-02")
two_days$Global_active_power_new = as.numeric(as.character(two_days$Global_active_power))
# add a combined datetime field
two_days$DateTime = as.POSIXct(paste(two_days$Date, two_days$Time), format="%d/%m/%Y %H:%M:%S")

# create the png
png(filename = "plot3.png",width = 480, height = 480)

# create the histogram
plot(two_days$DateTime, as.numeric(as.character(two_days$Sub_metering_1)), 
     ylab = "Energy sub metering",xlab  = '', type = "n")
lines(two_days$DateTime,as.numeric(as.character(two_days$Sub_metering_1)))
lines(two_days$DateTime,as.numeric(as.character(two_days$Sub_metering_2)),col = "red")
lines(two_days$DateTime,as.numeric(as.character(two_days$Sub_metering_3)),col = "blue")

# add the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col = c("black","red", "blue"),lty = c(1,1,1))

# turn dev off
dev.off()
