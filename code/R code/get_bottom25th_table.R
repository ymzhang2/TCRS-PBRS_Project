###get domain score
setwd("/Users/yimanzhang/Desktop")
tcrs <- read.csv("tcrs.csv",header=T)
names(tcrs)
tcrs <- tcrs[,-1]
f1 <- function(y,g){


  to=quantile(tcrs[tcrs$Grade==g,]$Task_Orientation,0.25)
  bc=quantile(tcrs[tcrs$Grade==g,]$Behavior_Control,0.25)
  as=quantile(tcrs[tcrs$Grade==g,]$Assertiveness,0.25)
  pss=quantile(tcrs[tcrs$Grade==g,]$Peer_Social_Skills,0.25)
  low_to <- y[y$Task_Orientation <= to,c(2,4,6,39,41,42,43:46)]
#names(tcrs)
  ##domain Behavior Control
  low_bc <- y[y$Behavior_Control <= bc,c(2,4,6,39,41,42,43:46)]
  ### domain Assertiveness
  low_as <- y[y$Assertiveness <= as,c(2,4,6,39,41,42,43:46)]
  ### domain Peer Social Skill
  low_pss <- y[y$Peer_Social_Skills <= pss,c(2,4,6,39,41,42,43:46)]
  bottom25 <- rbind(low_as,low_to,low_bc,low_pss)
  question <- unique(bottom25)
  question1 <- question
  question1$Task_Orientation <- ifelse(question$Task_Orientation<=to,question$Task_Orientation,NA)
  question1$Behavior_Control <- ifelse(question$Behavior_Control<=bc,question$Behavior_Control,NA)
  question1$Assertiveness <- ifelse(question$Assertiveness<=as,question$Assertiveness,NA)
  question1$Peer_Social_Skills <- ifelse(question$Peer_Social_Skills<=pss,question$Peer_Social_Skills,NA)
  question1[,7:10]
  numNAs <- 4-(apply(question1[,7:10], 1, function(z) sum(is.na(z))))###count NAs by row
  
  question1 <- cbind(question1,numNAs)
  return(question1)
}
f1(tcrs[tcrs$Grade=="PK",],"PK")
bottom25th_PS <- f1(tcrs[tcrs$Grade=="PS",],"PS")
bottom25th_PK <-f1(tcrs[tcrs$Grade=="PK",],"PK")
bottom25th <- rbind(bottom25th_PS, bottom25th_PK)
write.csv(bottom25th_PS,"bottom25th_PS.csv")
write.csv(bottom25th_PK,"bottom25th_PK.csv")
write.csv(bottom25th,"bottom25th.csv")

