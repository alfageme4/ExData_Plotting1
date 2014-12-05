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

#plot2
par(mfrow=c(1,1))
with(newDT,plot(DateTime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.copy(png, file = "plot2.png",width=480,height=480,units="px")
dev.off()