#########################################################################################################
### Course Project 2: Exploratory Data Analysis
### Plot4.R
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

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

merged_data <- merge (NEI, SCC, by="SCC")
names (merged_data)

SubsetCoal <- merged_data[grepl("coal", merged_data$Short.Name, ignore.case=TRUE), ]

aggregated_data_coal <- aggregate (Emissions ~ year, SubsetCoal, sum)

png(filename="plot4.png", height=900, width=1400)


library (ggplot2)
library (ggthemes)

PLOT_COAL <- ggplot (aggregated_data_coal, aes (year, Emissions))
PLOT_COAL + geom_line(aes(colour=aggregated_data_coal$Emissions),size=1.5) +
  theme_hc()  + xlab ("Year") + ylab ("Total PM2.5 emmission") + 
  ggtitle ("Total PM2.5 emission in Baltimore by year from Coal combustion-related sources") +
  theme(axis.title.x = element_text(color="black", size=20, face= "bold"),
        axis.title.y = element_text(color="black", size=20, face= "bold"),
        plot.title= element_text(color="black", size=20, face="bold"),
        legend.position="none") +
  scale_colour_gradient(low="black", high="blue") 


dev.off()
