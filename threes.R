library(ggplot2)
library(plyr)
library(dplyr)
library(plotly)

#three point attempts 2014-15 
threes=read.csv("14_15_threesX.csv")

#correlation matrix 
threes1<-threes[,c(14,18,19,21,22)]
corr<-cor(threes1)
round(corr,2)
summary(threes1) 

#2015-16 
threes2=read.csv("threes1.csv") 
korver=subset(threes2,name=="Kyle Korver") 

#korver shot chart 
ggplot(korver, aes(x=x, y=y)) + 
  annotation_custom(court, -250, 250, -52, 418) +
  stat_binhex(bins = 25, colour = "gray", alpha = 0.7) +
  scale_fill_gradientn(colours = c("yellow","orange","red")) +
  guides(alpha = FALSE, size = FALSE) +
  xlim(250, -250) +
  ylim(-52, 418) +
  geom_rug(alpha = 0.2) +
  coord_fixed() +theme(plot.title = element_text(hjust = 0.5))+
  ggtitle(paste("Shot Chart\n Kyle Korver 2015-2016", sep = "")) +
  theme(line = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(size = 17, lineheight = 1.2, face = "bold"))


#korver shots made 
ggplot(korver, aes(x=x, y=y,color=shot_made_flag)) + 
  annotation_custom(court, -250, 250, -52, 418) +
  #stat_binhex(bins = 25, colour = "gray", alpha = 0.7) +
  scale_fill_gradientn(colours = c("yellow","orange","red")) +
  guides(alpha = FALSE, size = FALSE) +
  xlim(250, -250) +
  ylim(-52, 418) +
  geom_rug(alpha = 0.2) +
  coord_fixed() +theme(plot.title = element_text(hjust = 0.5))+
  ggtitle(paste("Shot Chart\n Kyle Korver 2014-2015", sep = "")) +
  theme(line = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        legend.title = element_blank(),
        plot.title = element_text(size = 17, lineheight = 1.2, face = "bold"))

drib15=read.csv("dribbles_15.csv")
drib16=read.csv("dribbles_16.csv")

merge=merge(drib15,drib16,by="team_name")
hist(merge$avg_dribbles.x)
hist(merge$avg_dribbles.y)

#1. dribbles viz
dribbles=read.csv("dribbles.csv")

ggplot(dribbles, aes(x=avg_dribbles)) +
  geom_histogram(position="identity", alpha=0.4)+
  labs(x="Average Dribbles",y="Count",
       title="Average Dribbles Before Attempting Three Pointers",
       subtitle="2014-2015 NBA season")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(plot.subtitle = element_text(hjust = 0.5))
ggplotly()

#2. 2015-16 season 
dribs16=read.csv("dribs_16.csv")

ggplot(dribs16, aes(x=avg_dribbles)) +
  geom_histogram(position="identity", alpha=0.4)+
  labs(x="Average Dribbles",y="Count",
       title="Average Dribbles Against Defender",
       subtitle="2015-2016 NBA season")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(plot.subtitle = element_text(hjust = 0.5))

#3. analyzing metrics 13-14,14-15,15-16 seasons 

threes_14=read.csv("threes_2013_14.csv")
threes_15=read.csv("threes_2014_15.csv")
threes_16=read.csv("threes_2015_16.csv")

mergeOne=merge(threes_14,threes_15,by="name")
mergeOne$avg_pctX=(mergeOne$avg_threes.x+mergeOne$avg_threes.y)/2 
mergeOne$avg_dribblesX=(mergeOne$avg_dribbles.x+mergeOne$avg_dribbles.y)/2
mergeOne$avg_touchX=(mergeOne$avg_touch.x+mergeOne$avg_touch.y)/2
mergeOne$avg_distX=(mergeOne$avg_dist.y+mergeOne$avg_dist.x)/2

mergeOne=subset(mergeOne,select=c("name","avg_pctX","avg_dribblesX","avg_touchX","avg_distX"))
mergeDos=merge(mergeOne,threes_16,by="name") 
inc_dribs=subset(mergeDos,DIFF_dribbles>=0,select=c("name","DIFF_dribbles"))

mergeDos$DIFF_dribbles=mergeDos$avg_dribbles-mergeDos$avg_dribblesX
mergeDos$DIFF_pct=mergeDos$avg_threes-mergeDos$avg_pctX
mergeDos$DIFF_touch=mergeDos$avg_touch-mergeDos$avg_touchX
mergeDos$DIFF_dist=mergeDos$avg_dist-mergeDos$avg_distX

pct_hl=subset(mergeDos,DIFF_pct<=-0.031,select=c(name,avg_pctX,avg_threes,DIFF_pct))
write.csv(pct_hl,file="pct_hl.csv")

#dribbles across seasons? 
drib_14=threes_14$avg_shot_clock
drib_14=as.data.frame(drib_14)
drib_14$Year="2013-2014"
colnames(drib_14)=c("dribbles","Year")

drib_15=threes_15$avg_shot_clock
drib_15=as.data.frame(drib_15)
drib_15$Year="2014-2015"
colnames(drib_15)=c("dribbles","Year")

drib_16=threes_16$avg_shot_clock
drib_16=as.data.frame(drib_16)
drib_16$Year="2015-2016"
colnames(drib_16)=c("dribbles","Year")

bind=rbind(drib_14,drib_16) 

#viz 1 
g <- ggplot(bind, aes(bind$dribbles))
g + geom_density(aes(fill=factor(Year)), alpha=0.8) + 
  labs(title="Average Time Before Taking Three Pointer", 
       x="Seconds",
       fill="Season")+theme(plot.title = element_text(hjust = 0.5))

#viz 2 
ggplot(bind, aes(x=bind$dribbles)) +
  geom_histogram(position="identity", alpha=0.4)+
  labs(x="Average Touch (s)",y="density",
       title="Average Touch Time Before Taking Three Pointer",
       subtitle="2014-2015 NBA season")+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(plot.subtitle = element_text(hjust = 0.5))








