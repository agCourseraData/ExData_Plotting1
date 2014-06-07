# load data
sDataFile <- "household_power_consumption.txt"
data <- read.table(sDataFile, sep=";", header=TRUE)
days <- as.Date(data$Date, , format='%d/%m/%Y')
ids <- days == "2007-02-01" | days == "2007-02-02"
query_data <- data[ids,]

## get data
s1 <- query_data$Sub_metering_1
s1 <- levels(s1)[s1]
s2 <- query_data$Sub_metering_2
s2 <- levels(s2)[s2]
s3 <- query_data$Sub_metering_3

pids <- (s1 != "?") & (s2 != "?")
s1 <- as.numeric(s1[pids])
s2 <- as.numeric(s2[pids])
s3 <- s3[pids]


## get hours
h <- query_data$Time
h <- levels(h)[h]

## get date
d <- query_data$Date
d <- levels(d)[d]

# combine time
t <- paste(d, h)
t <- t[pids]


## Commented lines are to change dates to english (Thursday, Friday,...)
lct <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
t <- strptime(t, "%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_TIME", lct)


# Draw
par(mfrow = c(2,2))

#NW
y <- query_data$Global_active_power
y <- levels(y)[y]
pids <- (y != "?")
y <- y[pids]
y <- as.numeric(y)
sLabel <- "Global Active Power"
plot(t, y, type="l", ylab=sLabel, xlab="")

#NE
y <- query_data$Voltage
y <- levels(y)[y]
pids <- (y != "?")
y <- y[pids]
y <- as.numeric(y)
sLabelX <- "datetime"
sLabelY <- "Voltage"
plot(t, y, type="l", xlab=sLabelX, ylab=sLabelY)

#SW
s1 <- query_data$Sub_metering_1
s1 <- levels(s1)[s1]
s2 <- query_data$Sub_metering_2
s2 <- levels(s2)[s2]
s3 <- query_data$Sub_metering_3

pids <- (s1 != "?") & (s2 != "?")
s1 <- as.numeric(s1[pids])
s2 <- as.numeric(s2[pids])
s3 <- s3[pids]

sLabelY <- "Energy sub metering"
plot(t, s1, type="l", ylab=sLabelY, xlab="", col="black")
points(t, s2, col="red", type="l")
points(t, s3, col="blue", type="l")

legend("topright", pch = NA, bty="n", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#SE
y <- query_data$Global_reactive_power
y <- levels(y)[y]
pids <- (y != "?")
y <- y[pids]
y <- as.numeric(y)
sLabelX <- "datetime"
sLabelY <- "Global_reactive_power"
plot(t, y, type="l", xlab=sLabelX, ylab=sLabelY)

# ## save plot as png
sPngFile = "plot4.png"
dev.copy(png, file = sPngFile, width=480, height=480)
dev.off()
