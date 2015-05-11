# Function to get data is  get Data. It is called in each 
## script that the plots scripts can be independent.;
# I had to comment every line because graders did
# not understand the code.
# Amanda Molling

getData <- function(filepath = "exdata-data-household_power_consumption.zip"){
  # This is the code to unzip the file if you need to 
  # unzip.
   unzip(filepath)
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

plot1 <- function(){
  # Call get data function and store to data.
  data <- getData()
  # open png device 
  png("plot1.png", width = 480, height = 480)
  # make hist using base plotting with main = title
  hist(data$V3, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
}

## Run the plot function.
plot1();

