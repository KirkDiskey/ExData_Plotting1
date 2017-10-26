plot1<- function(){
        ## 1. This reads the household_power_consumption.txt file located in Working Directory
        ## 2. subsets data for 2 days: 2007-02-01 and 2007-02-02
        ## 3. and generates a histogram of global active power
        
        ## read data from working directory
        powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
        ##head(powerdata)
        ##Change date and time columns to correct class / format
        powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
        powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
        ##Change remaining columns to ensure they are numerics
        powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
        powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
        powerdata$Voltage <- as.numeric(powerdata$Voltage)
        powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
        powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
        powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
        powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)
        
        ##subsets data from 2007-02-01 and 2007-02-02
        subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")
        ##head(subsetdata)
        ## plots histogram with title of global active power for those 2 days.  480x480, red color with x and y labels
        png("plot1.png", width=480, height=480)
        hist(subsetdata$Global_active_power, col="red", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
        dev.off()
}