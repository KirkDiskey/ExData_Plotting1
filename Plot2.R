plot2 <- function(){
        ## 1. This reads the household_power_consumption.txt file from working directory
        ## 2. and subsets for data taken from 2 days: 2007-02-01 and 2007-02-02
        ## 3. and finally generates a plot of global active power (Y axis) vs. time (X axis)

        ## read data
        powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
        
        ## Create column with date and time combined
        FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
        ##head(FullTimeDate)
        ##Bind this new column into the data
        powerdata <- cbind(powerdata, FullTimeDate)
        ##head(powerdata)
        ## change class date and time columns 
        powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
        powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
        ##change class on remaining columns to numerics
        powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
        powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
        powerdata$Voltage <- as.numeric(powerdata$Voltage)
        powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
        powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
        powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
        powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)
        
        ## subsets the data from 2007-02-01 and 2007-02-02
        subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")
        ##head(subsetdata)
        ## plots global active power vs date & time
        png("plot2.png", width=480, height=480)
        with(subsetdata, plot(FullTimeDate, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
        dev.off()
}