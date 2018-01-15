#Plot 3
library(datasets)
library(dplyr)
library(ggplot2)
library(devtools)
#install_github("boxuancui/DataExplorer", ref="develop")
library(DataExplorer)
library(graphics)

#SETUP 
#Convert date strings to Date type
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )


feb1<-as.Date("01/02/2007",format="%d/%m/%Y")
feb2<-as.Date("02/02/2007",format="%d/%m/%Y")


dfFeb01 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c('Date'='myDate', 'Time'='character','Global_active_power'='numeric','Global_reactive_power' = 'numeric','Voltage' = 'numeric','Global_intensity'='numeric','Sub_metering_1' = 'numeric', 'Sub_metering_2' = 'numeric', 'Sub_metering_3'= 'numeric'), stringsAsFactors = FALSE, na.strings = "?") %>% subset(Date==feb1) 
dfFeb02 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c('Date'='myDate', 'Time'='character','Global_active_power'='numeric','Global_reactive_power' = 'numeric','Voltage' = 'numeric','Global_intensity'='numeric','Sub_metering_1' = 'numeric', 'Sub_metering_2' = 'numeric', 'Sub_metering_3'= 'numeric'), stringsAsFactors = FALSE, na.strings = "?") %>% subset(Date==feb2)
dfFeb0102 <- rbind(dfFeb01,dfFeb02)
v1 = min(dfFeb0102$Voltage)
v2 = max(dfFeb0102$Voltage)

#Change Time to be Date and Time
dateTime = paste(as.character(dfFeb0102$Date),dfFeb0102$Time)
dateTime2 = as.POSIXlt(dateTime)
dfFeb0102$Time = dateTime2

png(filename="Plot3.png")
# Plot 1
plot( x=dfFeb0102$Time, y=dfFeb0102$Sub_metering_1, col="gray25",xlab="", ylab="Energy sub metering", type="l")
lines(x=dfFeb0102$Time, y=dfFeb0102$Sub_metering_2,  type="l", col="red")
lines(x=dfFeb0102$Time, y=dfFeb0102$Sub_metering_3,  type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("gray25","red","blue"),lty = c(1, 1, 1))

dev.off()