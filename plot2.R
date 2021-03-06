#########################################################################################################
### Course Project 2: Exploratory Data Analysis
### Plot2.R
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

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system to make a plot answering this question.


NEI_BALTIMORE <- NEI [which (NEI$fips=="24510"),]
dim (NEI_BALTIMORE)
aggregated_data <- aggregate (Emissions ~ year, NEI_BALTIMORE, sum)

png(filename="plot2.png", height=480, width=480)

par(mar=c(5,10,2,2))
barplot (height=aggregated_data$Emissions,
         names.arg=aggregated_data$year, 
         xlab="Year",
         ylab=expression ("Total PM2.5 emmission"),
         main= "Total PM2.5 emission by year in Baltimore",
         col=c("darkblue", "blue", "dodgerblue2", "cornflowerblue"), 
         border="black",
         las=0,
         cex.axis=1.2,
         cex.lab=1.5)

dev.off()
