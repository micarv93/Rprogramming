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

filtered_data$Global_active_power <- as.numeric(as.character(filtered_data$Global_active_power))

# Combine 'Date' and 'Time' into a new 'DateTime' column
filtered_data$DateTime <- strptime(paste(filtered_data$Date, filtered_data$Time), 
                                   format = "%Y-%m-%d %H:%M:%S")

# Open a PNG device with the desired dimensions
png("plot2.png", width = 480, height = 480)

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

# Plot without x-axis
plot(filtered_data$DateTime, filtered_data$Global_active_power, type = "l",
     xlab = " ", ylab = "Global Active Power (kilowatts)",
     xaxt = "n")

# Add custom x-axis
axis(1, at = c(start_num, middle_num, end_num), labels = labels)

# Close the PNG device
dev.off()
