# Downloaded and extracted file to current working directory

# read the csv/txt file, sep = ';'
data <- read.csv('household_power_consumption.txt',sep = ';', header = TRUE)

data$Date_Clean = as.Date(data$Date,"%d/%m/%Y")
data$Time_Clean = strptime(data$Time,format = "%H:%M:%S")
data$weekday =  weekdays(data$Date_Clean)

# filter just for 2007-02-01 and 2007-02-02
two_days <- subset(data,data$Date_Clean >= "2007-02-01" & data$Date_Clean <= "2007-02-02")
two_days$Global_active_power_new = as.numeric(as.character(two_days$Global_active_power))

# add a combined datetime field
two_days$DateTime = as.POSIXct(paste(two_days$Date, two_days$Time), format="%d/%m/%Y %H:%M:%S")

# create the png
png(filename = "plot2.png",width = 480, height = 480)

# create the histogram
plot(two_days$DateTime, two_days$Global_active_power_new, 
     ylab = "Global Active Power (kilowatts)",xlab  = '', type = "l")
# turn dev off
dev.off()
