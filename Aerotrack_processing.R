### Aerotrak QAQC and summary stats ##################

# read in csv
data<-read.csv("C:/Users/clair/Desktop/SMASH/Aerotrak/SMASH_wen0809.csv", header=FALSE)
View(data)

temp<-data[,c(2, 4, 16, 20, 24, 28, 32, 36, 38, 40)]
View(temp)
colnames(temp) <- c("Date","Time","Bin_0.3","Bin_0.5","Bin_1","Bin_4","Bin_5","Bin_10","Volume_m3","Flow_lmp")

#create datetime
temp$date2<-as.Date(temp$Date, format = "%m/%d/%y")
temp$datetime<-as.POSIXct(paste(as.Date(temp$date2), temp$Time))

#check volume and flows for anomolies#
plot(temp$Volume_m3~temp$datetime)
plot(temp$Flow_lmp~temp$datetime)

#box plot
library(reshape2)
temp.m <- melt(temp,id.vars='datetime', measure.vars=c("Bin_0.3","Bin_0.5","Bin_1","Bin_4","Bin_5","Bin_10"))
library(ggplot2)
p1 <- ggplot(temp.m) +
  geom_boxplot(aes(x=variable, y=value))+ylim(0,100000)
p1

#time series all bins
p2<-ggplot(temp.m, aes(x = datetime, y = value)) + 
  geom_line(aes(color = variable), size = 1) 
p2

#box plot all bins
p3<-ggplot(temp.m, aes(x=variable, y=value, color = variable)) +
  geom_boxplot()+theme(legend.position="none")
p3
