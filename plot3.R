getData <- function(filepath = "exdata-data-household_power_consumption.zip"){
  # unzip(filepath)
  # Read in table from local directory
  data <- read.table("household_power_consumption.txt", sep = ";")
  data$V1 <- as.Date(data$V1, "%d/%m/%Y")
  data3 <- data[which( (data$V1 == "2007-02-01") | (data$V1 == "2007-02-02") ),]
  # I had to convert each of these columns to numeric so 
  # they could get plotted properly.
  data3$V4 <- as.numeric(levels(data3$V4))[data3$V4]
  data3$V5 <- as.numeric(levels(data3$V5))[data3$V5]
  # submeter 1 , 2, and 3:
  data3$V7 <- as.numeric(levels(data3$V7))[data3$V7]
  data3$V8 <- as.numeric(levels(data3$V8))[data3$V8]
  data3$V9 <- as.numeric(levels(data3$V9))[data3$V9]
  return(data3)
}

plot3 <- function(){
  data <- getData()
  # Open the PNG
  png("plot3.png", width = 480, height = 480)
  # Combine year, month, day with hour minute second to get a 
  # string containing the expanded time corresponding to that data
  fullTime <- strptime(paste(data[,1], data[,2]), "%Y-%m-%d %H:%M:%S")
  #Make the plot 
  plot(fullTime, data$V9, type = "l", col = "blue", ylim = c(0,38), xlab = "", ylab = "Energy sub metering")
  # Print the next line to the plot
  lines(fullTime, data$V7, col = "black")
  # print the final data line to the plot  ( We want V7 - V9 from the data)
  lines(fullTime, data$V8, col = "red")
  legend(bty = "n", "topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1 )
  dev.off()
}
plot3()