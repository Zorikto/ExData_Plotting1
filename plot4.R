#download and upload file in R
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = TRUE, sep = ';')
unlink(temp)

#subsetting only necessary date
plot_data<-subset(data, Date=='1/2/2007'|Date=='2/2/2007')

#converting measures to numeric type
plot_data$Global_active_power<-as.numeric(levels(plot_data$Global_active_power)[plot_data$Global_active_power])
plot_data$Sub_metering_1<-as.numeric(levels(plot_data$Sub_metering_1)[plot_data$Sub_metering_1])
plot_data$Sub_metering_2<-as.numeric(levels(plot_data$Sub_metering_2)[plot_data$Sub_metering_2])
plot_data$Voltage<-as.numeric(levels(plot_data$Voltage)[plot_data$Voltage])
plot_data$Global_reactive_power<-as.numeric(levels(plot_data$Global_reactive_power)[plot_data$Global_reactive_power])

#concatenate date and time
plot_data$date_time<-paste(plot_data$Date, plot_data$Time, sep=' ')

#Change to date format
plot_data$date_time<-strptime(as.character(plot_data$date_time),format = "%d/%m/%Y %H:%M:%S")

#plot4
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
with(plot_data, plot(date_time,Global_active_power, ylab='Global Active Power (kilowatts)', xlab = "",type = 'o', pch ='.'))
with(plot_data, plot(date_time,Voltage, ylab='Voltage', xlab = "datetime",type = 'o', pch ='.'))
with(plot_data, plot(date_time,Sub_metering_1, ylab='Energy sub metering', xlab = "",type = 'o', pch ='.'))
lines(plot_data$date_time, plot_data$Sub_metering_2, col="red")
lines(plot_data$date_time, plot_data$Sub_metering_3, col="blue")
legend("topright",lty = c(1,1,1),col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
with(plot_data, plot(date_time,Global_reactive_power, ylab='Global_reactive_power', xlab = "datetime",type = 'o', pch ='.'))
dev.off()