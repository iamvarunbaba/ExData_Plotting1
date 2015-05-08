## EXPLORATORY DATA ANALYSIS - COURSE PROJECT 1 - COURSERA (exdata-014)
## SIGNATURE TRACK
## Submission Login : varun.ramakrishnan@gmail.com

############
## Plot 4
############

# File Check/Download
if (!file.exists("household_power_consumption.txt")){
  if(!file.exists("exdata-data-household_power_consumption.zip")) {
    power_consumption_zip <- "exdata-data-household_power_consumption.zip"
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",power_consumption_zip)
    power_consumption_file <- unzip(power_consumption_zip)
  }
  else {
    power_consumption_file <- unzip("exdata-data-household_power_consumption.zip")
  }
}  

# Data Subsetting & Formatting into DataFrame - df
power_cons <- read.table(power_consumption_file, header=T, sep=";");
power_cons$Date <- as.Date(power_cons$Date, format="%d/%m/%Y");

df <- power_cons[(power_cons$Date=="2007-02-01") | (power_cons$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Plot 4 Function & PNG construction
plot4 <- function() {
  par(mfrow=c(2,2))
  
  #Plot 1
  plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  #Plot 2
  plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  #Plot 3
  plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(df$timestamp,df$Sub_metering_2,col="red")
  lines(df$timestamp,df$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  
  #Plot 4
  plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  #OUTPUT
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
}
plot4();