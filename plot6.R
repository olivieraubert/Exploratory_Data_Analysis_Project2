#########################################################################################################
### Course Project 2: Exploratory Data Analysis
### Plot6.R
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

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
# California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

Subset_LA_BALT <- NEI[which((NEI$fips=="24510" | NEI$fips=="06037") & NEI$type=="ON-ROAD"),]
names (Subset_LA_BALT)
dim (Subset_LA_BALT)

aggregated_LA_BALT <- aggregate (Emissions ~ year+fips, Subset_LA_BALT, sum)
names (aggregated_LA_BALT)

png(filename="plot6.png", height=900, width=1400)

library (ggplot2)
library (ggthemes)

aggregated_LA_BALT$City <- ifelse (aggregated_LA_BALT$fips=="06037", "Los Angeles County", "Baltimore City")
PLOT_LA_BALT <- ggplot (aggregated_LA_BALT, aes (year, Emissions,shape=factor(City),color=City))
PLOT_LA_BALT + geom_line(aes(colour=factor(aggregated_LA_BALT$City)),size=1.5)+
  theme_hc()  + xlab ("Year") + ylab ("Total PM2.5 emmission") + 
  ggtitle ("Total PM2.5 emission by year from motor vehicle sources") +
  theme(legend.position= c(0.9,0.7),
        legend.text = element_text(colour="black", size = 22, face = "bold"),
        legend.title= element_text(colour="black", size = 20, face = "bold"),
        axis.title.x = element_text(color="black", size=20, face= "bold"),
        axis.title.y = element_text(color="black", size=20, face= "bold"),
        plot.title= element_text(color="black", size=20, face="bold"),
        legend.background = element_rect(fill="white",size=1, linetype="solid", colour ="black")) +
  scale_color_manual (values=c("red", "blue"))



dev.off()
