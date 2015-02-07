
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

data3$datetime<- datetime

#png() command will create a png file 
#with default values of width and height are 480 and value of units is "px"   

###### Plot2
png(filename = "plot2.png")

with(data3,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))

dev.off()
