# Load necessary libraries
install.packages("dplyr")
library(dplyr)

# Read the data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Convert the 'Date' column to Date type
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Filter the data for the specific dates
filtered_data <- data %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

filtered_data$Sub_metering_1 <- as.numeric(as.character(filtered_data$Sub_metering_1))
filtered_data$Sub_metering_2 <- as.numeric(as.character(filtered_data$Sub_metering_2))
filtered_data$Sub_metering_3 <- as.numeric(as.character(filtered_data$Sub_metering_3))

# Combine 'Date' and 'Time' into a new 'DateTime' column
filtered_data$DateTime <- strptime(paste(filtered_data$Date, filtered_data$Time), 
                                   format = "%Y-%m-%d %H:%M:%S")

# Open a PNG device with the desired dimensions
png("plot3.png", width = 480, height = 480)

# Determine the start and end dates
start_date <- min(filtered_data$DateTime)
end_date <- max(filtered_data$DateTime)

# Calculate the middle date
middle_date <- start_date + (end_date - start_date) / 2

# Convert dates to numeric for axis function
start_num <- as.numeric(start_date)
middle_num <- as.numeric(middle_date)
end_num <- as.numeric(end_date)

# Define labels with formatted dates
labels <- c(paste("Thursday"), 
            paste("Friday"), 
            paste("Saturday"))
# Plot Sub_metering_1
plot(filtered_data$DateTime, filtered_data$Sub_metering_1, type = "l",
     col = "black", xlab = "", ylab = "Energy sub metering",
     xaxt = "n", ylim = range(filtered_data$Sub_metering_1, filtered_data$Sub_metering_2, filtered_data$Sub_metering_3))

# Add Sub_metering_2 and Sub_metering_3 to the plot
lines(filtered_data$DateTime, filtered_data$Sub_metering_2, type = "l", col = "red")
lines(filtered_data$DateTime, filtered_data$Sub_metering_3, type = "l", col = "blue")

# Add custom x-axis
axis(1, at = c(start_num, middle_num, end_num), labels = labels)

# Add a legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# Close the PNG device
dev.off()
