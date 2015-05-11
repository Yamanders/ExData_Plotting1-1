getData <- function(filepath = "exdata-data-household_power_consumption.zip"){
  # unzip(filepath)
  data <- read.table("household_power_consumption.txt", sep = ";")
  data$V1 <- as.Date(data$V1, "%d/%m/%Y")
  data3 <- data[which( (data$V1 == "2007-02-01") | (data$V1 == "2007-02-02") ),]
  data3$V7 <- as.numeric(levels(data3$V7))[data3$V7]
  data3$V8 <- as.numeric(levels(data3$V8))[data3$V8]
  data3$V9 <- as.numeric(levels(data3$V9))[data3$V9]
  return(data3)
}

plot4 <- function( ){
  
  data <- getData()
  png("plot4.png", width = 480, height = 480)
  # Break up my plot space into 4
  par(mfrow = c(2,2))
  fullTime <- strptime(paste(data[,1], data[,2]), "%Y-%m-%d %H:%M:%S")
  plot(fullTime, data$V3, type = "l", ylab = "Global Active Power", xlab = "")
  
  plot(fullTime, data$V5, ylab = "Voltage", type = "l", xlab = "")
  
  plot(fullTime, data$V9, type = "l", col = "blue", ylim = c(0,38), xlab = "", ylab = "Energy sub metering")
  lines(fullTime, data$V7, col = "black")
  lines(fullTime, data$V8, col = "red")
  legend(bty = "n", border = "white", "topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1 )
  
  plot(fullTime, data$V4, type = "l", xlab = "", ylab = "Global_Reactive_Power")
  dev.off()
  
}
plot4()