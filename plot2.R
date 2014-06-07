# load data
sDataFile <- "household_power_consumption.txt"
data <- read.table(sDataFile, sep=";", header=TRUE)
days <- as.Date(data$Date, , format='%d/%m/%Y')
ids <- days == "2007-02-01" | days == "2007-02-02"
query_data <- data[ids,]

## get kilowatts
y <- query_data$Global_active_power
y <- levels(y)[y]
pids <- (y != "?")
y <- y[pids]
y <- as.numeric(y)

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
# lct <- Sys.getlocale("LC_TIME")
# Sys.setlocale("LC_TIME", "C")
t <- strptime(t, "%d/%m/%Y %H:%M:%S")
sLabel <- "Global Active Power (kilowatts)"
plot(t, y, type="l", ylab=sLabel, xlab="")
# Sys.setlocale("LC_TIME", lct)

## save plot as png
sPngFile = "plot2.png"
dev.copy(png, file = sPngFile, width=480, height=480)
dev.off()
