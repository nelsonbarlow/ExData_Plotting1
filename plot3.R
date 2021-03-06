# using basic bash commands like grep and wc -l, I was able to determine
# where the data for the 2 dates were in the file. First line of 
# date 2007-02-01 was 66638, so I use the skip command to start there,
# and read until 2880 lines after that which is the last row of 2007-02-02
df <- read.table("household_power_consumption.txt", 
                 na.strings = "?", 
                 sep = ";",
                 skip = 66637, nrows = 2880, 
                 col.names = c("Date", 
                               "Time", 
                               "Global_active_power",
                               "Global_reactive_power",
                               "Voltage",
                               "Global_intensity",
                               "Sub_metering_1",
                               "Sub_metering_2",
                               "Sub_metering_3"
                 )
)

#Adding a new column with DateTime
df$DateTime <- paste(df$Date, df$Time)
df$DateTime <- strptime(df$DateTime, "%d/%m/%Y %T")

png(filename = "plot3.png", width = 480, height = 480)
plot(df$DateTime, df$Sub_metering_1, xlab = "", ylab = "Energy Sub Metering", type = "l")
lines(df$DateTime ,df$Sub_metering_2, col = "red")
lines(df$DateTime ,df$Sub_metering_3, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lwd = c(1,1,1),
       col = c("black", "red", "blue") 
       )
dev.off()

