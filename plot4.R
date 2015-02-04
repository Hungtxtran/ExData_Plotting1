
filename<- "household_power_consumption.txt"

lines <- readLines(filename)

date1 <- grep("^1/2/2007", lines)
date2 <- grep("^2/2/2007", lines)

cnames <- read.table(filename, nrows=1, header = FALSE, sep =';', stringsAsFactors = FALSE)

data1 <- read.table(filename, skip=date1[1]-1,nrows = length(date1), header = FALSE, sep =';', stringsAsFactors = FALSE)
data2 <- read.table(filename, skip=date2[1]-1,nrows = length(date2), header = FALSE, sep =';', stringsAsFactors = FALSE)

data3<- rbind(data1,data2)

colnames(data3)<- cnames

data3$Date<- strptime(data3$Date, "%d/%m/%Y")

datetime<- paste(data3$Date, data3$Time)
datetime<- strptime(datetime, "%Y-%m-%d %H:%M:%S")

data3$Datetime<- datetime

#png() command will create a png file 
#with default values of width and height are 480 and value of units is "px"   

###### Plot4


png(filename = "plot4.png")

par(mfrow=c(2,2))

with(data3,plot(Datetime,Global_active_power,type="l",xlab="",ylab="Global active power"))

with(data3,plot(Datetime,Voltage,type="l",ylab="Voltage"))

with(data3,plot(Datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(data3,lines(Datetime,Sub_metering_2,type="l",col="red"))
with(data3,lines(Datetime,Sub_metering_3,type="l",col="blue"))
with(data3,legend("topright",bty="n", col=c("black","red","blue"),lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")))

with(data3,plot(Datetime,Global_reactive_power,ylab="Global_reactive_power",type="l"))

dev.off()
