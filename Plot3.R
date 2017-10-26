plot3 <- function(){
        ## 1. This reads the household_power_consumption.txt file from the working directory
        ## 2. then subsets for data taken from 2 days: 2007-02-01 and 2007-02-02
        ## 3. and finally generates a plot of energy sub-metering vs time
        
        
        ## reads data from working directory
        powerdata <- read.table("./household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )
        
        ## Creates a new column with date and time merged together
        FullTimeDate <- strptime(paste(powerdata$Date, powerdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
        ##head(FullTimeDate)
        ##Binds the new column into the data
        powerdata <- cbind(powerdata, FullTimeDate)
        #head(powerdata)
        ## change class for date and time to correct class
        powerdata$Date <- as.Date(powerdata$Date, format="%d/%m/%Y")
        powerdata$Time <- format(powerdata$Time, format="%H:%M:%S")
        ##change class on remaining colunns to numeric
        powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
        powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)
        powerdata$Voltage <- as.numeric(powerdata$Voltage)
        powerdata$Global_intensity <- as.numeric(powerdata$Global_intensity)
        powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
        powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
        powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)
        
        ## subsets the data from 2007-02-01 and 2007-02-02
        subsetdata <- subset(powerdata, Date == "2007-02-01" | Date =="2007-02-02")
        
        ## plots global active power vs date & time
        png("plot3.png", width=480, height=480)
        with(subsetdata, plot(FullTimeDate, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
        lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_2,type="l", col= "red")
        lines(subsetdata$FullTimeDate, subsetdata$Sub_metering_3,type="l", col= "blue")
        legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
        dev.off()
}