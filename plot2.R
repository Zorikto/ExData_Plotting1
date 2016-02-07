#download and upload file in R
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = TRUE, sep = ';')
unlink(temp)

#subsetting only necessary date
plot_data<-subset(data, Date=='1/2/2007'|Date=='2/2/2007')

#converting measures to numeric type
plot_data$Global_active_power<-as.numeric(levels(plot_data$Global_active_power)[plot_data$Global_active_power])

#concatenate date and time
plot_data$date_time<-paste(plot_data$Date, plot_data$Time, sep=' ')
#Change to date format
plot_data$date_time<-strptime(as.character(plot_data$date_time),format = "%d/%m/%Y %H:%M:%S")

#plot2
png(file="plot2.png", width=480, height=480)
with(plot_data, plot(date_time,Global_active_power, ylab='Global Active Power (kilowatts)', xlab = "",type = 'o', pch ='.'))
dev.off()