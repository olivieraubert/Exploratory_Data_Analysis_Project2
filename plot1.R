#########################################################################################################
### Course Project 2: Exploratory Data Analysis
### Plot1.R
#########################################################################################################
setwd("/Users/olivieraubert/Desktop/R/EXERCIE_COURSERA/Exploratory_Data_Analysis_Project2")

# Download the dataset then unzip the dataset:
FILE <- "getdata_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="./FNEI_data.zip", method="curl")
unzip ("./FNEI_data.zip")
getwd()

## Reading the files
NEI <- readRDS("summarySCC_PM25.rds")
dim (NEI)
names (NEI)
head (NEI, n=3)
SCC <- readRDS("Source_Classification_Code.rds")
dim (SCC)
names (SCC)
head (SCC, n=3)
View (SCC)

## 1/ Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base 
## plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999
## , 2002, 2005, and 2008.

table (NEI$year)
aggregated_data <- aggregate (Emissions ~ year, NEI, sum)

png(filename="plot1.png", height=480, width=480)

par(mar=c(5,10,2,2))
barplot (height=aggregated_data$Emissions,
         names.arg=aggregated_data$year, 
         xlab="Year",
         ylab=expression ("Total PM2.5 emmission"),
         main= "Total PM2.5 emission by year",
         col=c("darkblue", "blue", "dodgerblue2", "cornflowerblue"), 
         border="black",
         las=0,
         cex.axis=1.2,
         cex.lab=1.5)

dev.off()
