####################################
# create a temporary file
temp <- tempfile()
# download the file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
# unzip the data into the target temp file (note %2F means html unicode for / )

#unzip the temp file
#skip the first line as it has nothing in it (v1), then 
data <- read.table(unz(temp, "household_power_consumption.txt"), header = FALSE, sep = ";", skip = 1, na.strings = "?")

#read the headings out of the zip file on row[1] second, seperate by ; 
colnames <- strsplit(readLines(unz(temp, "household_power_consumption.txt"), 1), ";", fixed = TRUE)

#set col names
names(data) <- colnames[[1]]

# remove the temp file with unlink()
unlink(temp)

#check what we have
head(data)

#how much data
dim(data)

#get a subset for 2007-02-01 and 2007-02-02
houseconsumption <- subset(data, Date == "1/2/2007"| Date ==  "2/2/2007")

#change the date formats using R functions the  strptime()  and  as.Date() 
# paste Date and Time together and then change the format, adding them into a new column on the dataframe called Date_time
houseconsumption$Date_time <- strptime(paste(householdpower$Date, householdpower$Time), "%d/%m/%Y %H:%M:%S")
head(houseconsumption)

#Plot 4 - 4 graphs of type line plot

#put out put to working DIR
getwd()
#save it to disk in a PNG file
#?png()
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))
# set style - 2 rows and 2 cols of graphs
par(mfrow=c(2,2))
# add margins
# par(mfrow=c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# plot a - Global Active Power/Time
plot(x = houseconsumption$Date_time, y = houseconsumption$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# plot b - Voltage/Time
plot(x = houseconsumption$Date_time, y = houseconsumption$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")


# plot c - Energy sub metering/Time'
plot(x = houseconsumption$Date_time, y = houseconsumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = houseconsumption$Date_time, y = houseconsumption$Sub_metering_2, col = "red")
lines(x = houseconsumption$Date_time, y = houseconsumption$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")


# plot d - Global_reactive_power/Time
plot(x = houseconsumption$Date_time, y = householdpower$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")

#finish writing the file and close
dev.off()


