Sys.setlocale("LC_TIME", 'en_US.UTF-8')
library(data.table)
library(dplyr)
library(lubridate)
DT<-fread("./household_power_consumption.txt",na.strings = "?")

newDT<-DT%>%
  filter(dmy(Date)==ymd("2007-2-1")|dmy(Date)==ymd("2007-2-2"))%>%
  mutate(Global_active_power=as.numeric(Global_active_power))%>%
  mutate(Global_reactive_power=as.numeric(Global_reactive_power))%>%
  mutate(Voltage=as.numeric(Voltage))%>%
  mutate(Global_intensity=as.numeric(Global_intensity))%>%
  mutate(Sub_metering_1=as.numeric(Sub_metering_1))%>%
  mutate(Sub_metering_2=as.numeric(Sub_metering_2))%>%
  mutate(Sub_metering_3=as.numeric(Sub_metering_3))%>%
  mutate(DateTime=dmy_hms(paste(Date,Time)))

#plot4
par(mfrow = c(2, 2))
with(newDT,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power",xlab=""))
with(newDT,plot(DateTime,Voltage,type="l",ylab="Voltage",xlab="datetime"))
with(newDT,plot(DateTime,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=""))
with(newDT,points(DateTime,Sub_metering_2,type="l",col="red"))
with(newDT,points(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",inset =c(0.05,0),cex=0.75,bty="n",lty="solid", col = c("black","blue", "red"), legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(newDT,plot(DateTime,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime"))
dev.copy(png, file = "plot4.png",width=480,height=480,units="px")
dev.off()