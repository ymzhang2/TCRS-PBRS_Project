###get domain score
setwd("/Users/yimanzhang/Desktop")
tcrs <- read.csv("cleandata.csv",header=T)
tcrs <- tcrs[1:786,]

d <- tcrs[,-c(1:6,39:42)]
head(d)
names(d)
to1 <- rowSums(d[,c(1,9,17,25)])
to2 <- rowSums(d[,c(5,13,21,29)])
to3 <- to2-to1
to4 <- to3+to1

Task_Orientation <- to4
bc1 <- rowSums(d[,c(6,14,22,30)])
bc2 <- rowSums(d[,c(2,10,18,26)])
bc3 <- 24-bc2
bc4 <- bc1 + bc3
Behavior_Control <- bc4
as1 <- rowSums(d[,c(3,11,19,27)])
as2 <- rowSums(d[,c(7,15,23,31)])
as3 <- 24-as2
as4 <- as1 + as3
Assertiveness <- as4
pss1 <- rowSums(d[,c(8,16,24,32)])
pss2 <- rowSums(d[,c(4,12,20,28)])
pss3 <- 24-pss2
pss4 <- pss1 + pss3
Peer_Social_Skills <- pss4

domainscore <- cbind(Task_Orientation, Behavior_Control, Assertiveness,Peer_Social_Skills)
domainscore <- as.data.frame(domainscore)

#write.csv(domainscore,"domainscore.csv")
#names(tcrs)
###domain Task Orientation
tcrs <- read.csv("cleandata.csv",header=T)
tcrs <- tcrs[1:786,]
names(tcrs)
low_to <- tcrs[tcrs$Task_Orientation <= quantile(to4,0.25),c(2,4,6,39,41,42,43:46)]

##domain Behavior Control
low_bc <- tcrs[tcrs$Behavior_Control <= quantile(bc4,0.25),c(2,4,6,39,41,42,43:46)]
### domain Assertiveness
low_as <- tcrs[tcrs$Assertiveness <= quantile(as4,0.25),c(2,4,6,39,41,42,43:46)]
### domain Peer Social Skill
low_pss <- tcrs[tcrs$Peer_Social_Skills <= quantile(pss4,0.25),c(2,4,6,39,41,42,43:46)]
#names(low_to)
dim(low_as)
#dim(low_bc)
#dim(low_pss)
bottom25 <- rbind(low_as,low_to,low_bc,low_pss)
question <- unique(bottom25)
question1 <- question

question1$Task_Orientation <- ifelse(question$Task_Orientation<=quantile(to4,0.25),question$Task_Orientation,NA)
question1$Behavior_Control <- ifelse(question$Behavior_Control<=quantile(bc4,0.25),question$Task_Orientation,NA)
question1$Assertiveness <- ifelse(question$Assertiveness<=quantile(as4,0.25),question$Task_Orientation,NA)
question1$Peer_Social_Skills <- ifelse(question$Peer_Social_Skills<=quantile(pss4,0.25),question$Task_Orientation,NA)
question1[,7:10]
numNAs <- 4-(apply(question1[,7:10], 1, function(z) sum(is.na(z))))###count NAs by row
table(numNAs)
question1 <- cbind(question1,numNAs)
write.csv(question1,"question1.csv")###form domain score table ###



##get plots
###transform my dataset


library("plyr")
campus_gender <- ddply(low_to, .(Campus, Grade),nrow)
#campus_gender <- ddply(campus_gender, "Campus", transform, label_y=cumsum(V1))
campus_gender <- ddply(campus_gender, "Campus", transform, label_y=cumsum(V1)-0.5*V1)
##get the name list by gender
#bygender <- arrange(low_to,Campus,Classroom,Gender)
#write.csv(bygender,"bygender.csv")

library(ggplot2)
campus_gender$Campus <- gsub(" ","",gsub("[a-z]","",campus_gender$Campus))
campus_gender$Campus[which(campus_gender$Campus=="S")]="SW"
campus_gender$Campus[which(campus_gender$Campus=="P")]="PL"
campus_gender$Campus[which(campus_gender$Campus=="OA")]="OK"
###gender count by campus
ggplot(campus_gender, aes(x=Campus, y=V1, fill=Grade)) + geom_bar(stat="identity")+guides(fill=guide_legend(reverse=T))+geom_text(aes(y=label_y,label=V1),colour="white",size=4,vjust=1.5)+ggtitle("The number")

classroom_gender <- ddply(low_to, .(Campus, Classroom,Gender),nrow)
classroom_gender <- ddply(classroom_gender, "Classroom", transform, label_y=cumsum(V1)-0.5*V1)
#classroom_gender <- ddply(classroom_gender, "Classroom", transform, label_y=cumsum(V1))
classroom_gender$Classroom <- as.numeric(gsub("[A-Z]","",classroom_gender$Classroom))
classroom_gender$Campus <- gsub(" ","",gsub("[a-z]","",classroom_gender$Campus))
classroom_gender$Campus[which(classroom_gender$Campus=="S")]="SW"
classroom_gender$Campus[which(classroom_gender$Campus=="P")]="PL"
classroom_gender$Campus[which(classroom_gender$Campus=="OA")]="OK"
###gender count by classroom 
ggplot(classroom_gender, aes(x=Classroom, y=V1, fill=Gender)) + geom_bar(stat="identity")+guides(fill=guide_legend(reverse=T))+geom_text(aes(y=label_y,label=V1),colour="white",size=3,vjust=1.0)+facet_grid(Campus~Classroom,scales = "free")+scale_x_continuous(breaks=1:8)

