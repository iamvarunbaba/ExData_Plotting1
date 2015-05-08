## EXPLORATORY DATA ANALYSIS - COURSE PROJECT 1 - COURSERA (exdata-014)
## SIGNATURE TRACK
## Submission Login : varun.ramakrishnan@gmail.com

############
## Plot 1
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

# Plot 1 Function & PNG construction
plot1 <- function() {
  hist(df$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
}
plot1();