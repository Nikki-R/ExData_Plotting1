#Download and unzip data
if(!file.exists("assignmentdata")){
        dir.create("assignmentdata")
        }
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./assignmentdata/download.zip" )
if(!file.exists("assignmentdata/as41data")){
        dir.create("assignmentdata/as41data")
}
unzip("./assignmentdata/download.zip",exdir= "./assignmentdata/as41data")

#Read in data
coltypes <- rep("numeric", 7)
coltypes <- c("character", "character", coltypes)
epc <- read.table("./assignmentdata/as41data/household_power_consumption.txt", header=TRUE, sep =";")

#Subset
epc2 <- subset(epc, epc$Date =="1/2/2007" | epc$Date =="2/2/2007")

#Convert dates and times
newdate <- as.Date(epc2$Date, format = "%e/%m/%Y")
datetime <- paste(newdate, epc2$Time, sep=" ")
datetime <- strptime(datetime, format="%Y-%m-%d %H:%M:%S")
epc3 <- cbind(epc2, newdate, datetime)

#Convert to other formats
library(dplyr)
epcdata <- epc3 #rename for simplification
epcdata <- mutate (epcdata, 
                   Global_active_power= as.numeric(as.character(Global_active_power)), 
                   Sub_metering_1= as.numeric(as.character(Sub_metering_1)),
                   Sub_metering_2= as.numeric(as.character(Sub_metering_2)),
                   Sub_metering_3= as.numeric(as.character(Sub_metering_3)),
                   Voltage= as.numeric(as.character(Voltage)),
                   Global_reactive_power= as.numeric(as.character(Global_reactive_power)))

#Initialize png device
png("plot1.png", width=480, height=480)

#Create histogram
hist(epcdata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

#Close png connection
dev.off()
