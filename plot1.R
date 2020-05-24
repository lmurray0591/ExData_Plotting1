# Downloaded and extracted file to current working directory

# read the csv/txt file, sep = ';'
data <- read.csv('household_power_consumption.txt',sep = ';', header = TRUE)

# create a clean Date column (convert factor to Date)
data$Date_Clean = as.Date(data$Date,"%d/%m/%Y")

# filter just for 2007-02-01 and 2007-02-02
two_days <- subset(data,data$Date_Clean >= "2007-02-01" & data$Date_Clean <= "2007-02-02")
two_days$Global_active_power_new = as.numeric(as.character(two_days$Global_active_power))

# create the png
png(filename = "plot1.png",width = 480, height = 480)

# create the histogram
hist(two_days$Global_active_power_new, col = "red", 
     main = "Global Active power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")

# turn dev off
dev.off()
