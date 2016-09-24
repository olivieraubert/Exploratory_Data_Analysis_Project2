#########################################################################################################
### Course Project 2: Exploratory Data Analysis
### Plot3.R
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

# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

NEI_BALTIMORE <- NEI [which (NEI$fips=="24510"),]
dim (NEI_BALTIMORE)
aggregated_data <- aggregate (Emissions ~ year+type, NEI_BALTIMORE, sum)

png(filename="plot3.png", height=900, width=1400)

library (ggplot2)
library (ggthemes)


PLOT_BY_TYPE <- ggplot (aggregated_data, aes (year, Emissions, shape=factor(type),color=type))
PLOT_BY_TYPE + geom_line(aes(colour=factor(aggregated_data$type)),size=1.5)+
  theme_hc()  + xlab ("Year") + ylab ("Total PM2.5 emmission") + ggtitle ("Total PM2.5 emission in Baltimore by year and type of sources") +
  theme(legend.position= c(0.9,0.9),
    legend.text = element_text(colour="black", size = 22, face = "bold"),
    legend.title= element_text(colour="black", size = 20, face = "bold"),
    legend.background = element_rect(fill="white",size=1, linetype="solid", colour ="black"),
    axis.title.x = element_text(color="black", size=20, face= "bold"),
    axis.title.y = element_text(color="black", size=20, face= "bold"),
    plot.title= element_text(color="black", size=20, face="bold")) +
  scale_color_manual (values=c("red", "blue", "orange", "purple"))
  

dev.off()
