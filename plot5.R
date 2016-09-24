#########################################################################################################
### Course Project 2: Exploratory Data Analysis
### Plot5.R
#########################################################################################################
setwd("/Users/olivieraubert/Desktop/R/EXERCIE_COURSERA/Exploratory_Data_Analysis_Project2")

# Download the dataset then unzip the dataset:
FILE <- "getdata_dataset.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, destfile="./FNEI_data.zip", method="curl")
unzip ("./FNEI_data.zip")

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

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

Subset_vehicle_motor <- NEI[which(NEI$fips=="24510" & NEI$type=="ON-ROAD"),]
names (Subset_vehicle_motor)
dim (Subset_vehicle_motor)

aggregated_vehicle_motor <- aggregate (Emissions ~ year, Subset_vehicle_motor, sum)

png(filename="plot5.png", height=900, width=1400)


library (ggplot2)
library (ggthemes)

PLOT_vehicle_motor <- ggplot (aggregated_vehicle_motor, aes (year, Emissions))
PLOT_vehicle_motor + geom_line(aes(colour=aggregated_vehicle_motor$Emissions),size=1.5) +
  theme_hc()  + xlab ("Year") + ylab ("Total PM2.5 emmission") + 
  ggtitle ("Total PM2.5 emission in Baltimore by year from motor vehicle sources") +
  theme(axis.title.x = element_text(color="black", size=20, face= "bold"),
        axis.title.y = element_text(color="black", size=20, face= "bold"),
        plot.title= element_text(color="black", size=20, face="bold"),
        legend.position="none") +
  scale_colour_gradient(low="black", high="blue") 


dev.off()
