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

# Open a PNG device with the desired dimensions
png("plot1.png", width = 480, height = 480)

# Redraw your plot here
hist(filtered_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

# Close the PNG device
dev.off()
