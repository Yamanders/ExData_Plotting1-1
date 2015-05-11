# Plot image 2
# Amanda Molling

getData <- function(filepath = "exdata-data-household_power_consumption.zip"){
  # This is the code to unzip the file if you need to 
  # unzip.
  # unzip(filepath)
  data <- read.table("household_power_consumption.txt", sep = ";")
  # Copied the data so that I could manipulate without changing 
  # the original table read
  data2 <- data
  # Converted the date column into a date function
  data2$V1 <- as.Date(data$V1, "%d/%m/%Y")
  # Selected the columns which occured on the day we need.
  data3 <- data2[which( (data2$V1 == "2007-02-01") | (data2$V1 == "2007-02-02") ),]
  # had to convert this data to numeric to generate the plots.
  # I could have read in the data as factors = False, but I didn't.
  data3$V3 <- as.numeric(levels(data3$V3))[data3$V3]
  # Return this frame to give it to plot function.
  return(data3)
}

plot2 <- function(){
  data <- getData()
  # open png plot and explicitely define 
  # width and height because the defaults could 
  # change and this will remain correct.
  png("plot2.png", width = 480, height = 480)
  fullTime <- strptime(paste(data[,1], data[,2]), "%Y-%m-%d %H:%M:%S")
  plot(fullTime, data$V3, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
  dev.off()
}

plot2();
