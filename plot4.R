## load the full data
data_full <- read.csv("~/Documents/R/expdata/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")

## subset the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)

## convert dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 4 
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power", xlab="", cex.lab=0.8)
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage", xlab="datetime", cex.lab=0.8)
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy sub metering", xlab="", cex.lab=0.8)
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", cex=0.7, inset=c(.08,0.01), y.intersp=0.7,
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global_rective_power",xlab="datetime", cex.lab=0.8)
})

## Save as plot4.png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()