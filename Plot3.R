if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://github.com/rdpeng/ExData_Plotting1/archive/master.zip"
download.file(fileUrl, destfile = "./data/plotting1.zip")

## step 2: unzip data
listZip <- unzip("./data/plotting1.zip", exdir = "./data")
mydata<-read.table("household_power_consumption.txt", sep = ";", header = T, stringsAsFactors = F)
mydata$Date_time<-paste(mydata$Date,mydata$Time)
if("lubridate" %in% rownames(installed.packages())==F) {install.packages("lubridate")}
mydata$Date_time<-dmy_hms(mydata$Date_time)

mydatafiltered<-mydata[mydata$Date_time<"2007-02-03 01:00:00 UTC"&mydata$Date_time>="2007-02-01 01:00:00 UTC",]
mydatafiltered$Global_active_power<-as.numeric(mydatafiltered$Global_active_power)
mydatafiltered$Global_reactive_power<-as.numeric(mydatafiltered$Global_reactive_power)
mydatafiltered$Voltage<-as.numeric(mydatafiltered$Voltage)
mydatafiltered$Global_intensity<-as.numeric(mydatafiltered$Global_intensity)
mydatafiltered$Sub_metering_1<-as.numeric(mydatafiltered$Sub_metering_1)
mydatafiltered$Sub_metering_2<-as.numeric(mydatafiltered$Sub_metering_2)


#Chart3
png(filename = "plot3.png", width = 480, height = 480 )

plot(mydatafiltered$Date_time,mydatafiltered$Sub_metering_1, type="n",xlab = "", ylab = "Energy sub metering")
lines(mydatafiltered$Date_time,mydatafiltered$Sub_metering_1)
lines(mydatafiltered$Date_time,mydatafiltered$Sub_metering_2, col="red")
lines(mydatafiltered$Date_time,mydatafiltered$Sub_metering_3, col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)

dev.off()