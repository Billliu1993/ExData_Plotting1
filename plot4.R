## The raw data file has been save to the current working directory
## Load the data into R
DT <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
## Subset the data from 2007-02-01 to 2007-02-02
DT2 <- rbind(DT[DT$Date == "1/2/2007",], DT[DT$Date == "2/2/2007",])
## Checking DT2
## str(DT2)
## 'data.frame':	2880 obs. of  9 variables:
## $ Date                 : Factor w/ 1442 levels "1/1/2007","1/1/2008",..: 16 16 16 16 16 16 16 16 16 16 ...
## $ Time                 : Factor w/ 1440 levels "00:00:00","00:01:00",..: 1 2 3 4 5 6 7 8 9 10 ...
## $ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
## $ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
## $ Voltage              : num  243 243 244 244 243 ...
## $ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
## $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
## $ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
## $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

## Convert the Date and Time variables to Date/Time classes
DT2$Date <- as.Date(DT2$Date, "%d/%m/%Y")
DT3<-cbind(DT2, "DateTime" = as.POSIXct(paste(DT2$Date, DT2$Time)))

## Plot 4 code
par(mfcol = c(2,2))

plot(DT3$Global_active_power ~ DT3$DateTime, type = "l", xlab = "", ylab = "Global Active Power")

with(DT3, plot(Sub_metering_1 ~ DateTime, type = "l", xlab = "", ylab = "Energy Sub Metering"))
lines(DT3$Sub_metering_2 ~ DT3$DateTime, col = 'Red')
lines(DT3$Sub_metering_3 ~ DT3$DateTime, col = 'Blue')
legend("topright", lty = 1, lwd = 1, bty = "n", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(DT3$Voltage ~ DT3$DateTime, type = "l", xlab = "datetime", ylab = "Voltage")

plot(DT3$Global_reactive_power ~ DT3$DateTime, type="l", xlab = "datetime", ylab = "Global Active Power")

## Export to png
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()