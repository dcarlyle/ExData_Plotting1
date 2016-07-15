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

#Plot 2 - Global Active Power/day
#put out put to working DIR
getwd()
#save it to disk in a PNG file
#?png()
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res = NA, family = "", restoreConsole = TRUE,
    type = c("windows", "cairo", "cairo-png"))

# set style
par(mfrow=c(1,1))
# plot as type line (type = "l")
plot(x = houseconsumption$Date_time, y = householdpower$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
#finish writing the file and close
dev.off()


