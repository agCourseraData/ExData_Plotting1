# load data
sDataFile <- "household_power_consumption.txt"
data <- read.table(sDataFile, sep=";", header=TRUE)
days <- as.Date(data$Date, , format='%d/%m/%Y')
ids <- days == "2007-02-01" | days == "2007-02-02"
 query_data <- data[ids,]

# Draw
x <- query_data$Global_active_power
x <- levels(x)[x][]
x <- as.numeric(x[x!="?"])

sTitle <- "Global Active Power"
sLabel <- "Global Active Power (kilowatts)"
hist(x, col="red", main=sTitle, xlab=sLabel, ps=40)

## save plot as png
sPngFile = "plot1.png"
dev.copy(png, file = sPngFile, width=480, height=480)
dev.off()
