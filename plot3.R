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

#Plot 3 - Energy Submetering split by 
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

#put out put to working DIR
getwd()
#save it to disk in a PNG file
#?png()
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# set style
par(mfrow=c(1,1))
# plot as 3 lines 
plot( x = houseconsumption$Date_time, y = houseconsumption$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(x = houseconsumption$Date_time, y = houseconsumption$Sub_metering_2, col = "red")
lines(x = houseconsumption$Date_time, y = houseconsumption$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))
#finish writing the file and close
dev.off()


