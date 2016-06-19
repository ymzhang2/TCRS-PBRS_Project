setwd("/Users/yimanzhang/Desktop/intern/datacleaning")
df<-read.csv("tcrs.csv")
name <- names(df)###find colnames
str(name)
dim(df)
length(name)
name

m <- gsub("Please.rate.how.much.you.agree.each.item.describes.this.child...[0-9]..","",name)###remove the "Please.."pattern in the colnames
newm <- gsub("* $","",gsub("  ", "",gsub("^ ","",gsub("[.]"," ",m))))###change the colnames in correct form
write.csv(newm,"newm.csv")
new <- read.csv("newm.csv")
names(df) <- newm
names(df)[c(2,3,5)] <- c("Childs Name","Teacher's Name", "Today's Date") ### add ' in chilren s name and so on. 
names(df)


library(plyr)
change_factor_numeric <- function(x) {revalue(x,c("Agree"=4, "Strongly Agree"=5, "Neutral"=3, "Disagree"=2, "Strongly Disagree"=1))}
### change factor into number factor
data <- apply(df[,7:38], 2, change_factor_numeric)
number <- apply(data,2,as.numeric)###change factor into numbers
df[,7:38] <- number
write.csv(df,"df.csv")
df[,3]


teachername <- df[order(df[,3]),]
teachername_table <-as.data.frame(table(teachername[,3]))
uniquetn <- tolower(as.matrix(teachername_table)[,1])
a1 <- grep(", ", uniquetn)
uniquetn[a1] <- c("teresa butler", "harrison copelin")
b1 <- grep("/", uniquetn)
uniquetn[which(uniquetn=="ms. j. booker")] <- "booker"
c1 <- grep("[.]",uniquetn)
uniquetn[c1] <- gsub("^ ", "", unlist(strsplit(as.character(uniquetn[c1]), "[*.]"))[seq(2,36,2)])
d1 <- grep(" ", uniquetn[-c(a1,b1,c1)])
uniquetn[d1] <- unlist(strsplit(as.character(uniquetn[d1]), "* *"))[seq(2,)]
table[order(table$Freq),]
table[,1][which(table$Freq==1)]
### deal with teachers' name to be corresponding to that in tcrs
staff <- read.csv("staff.csv",header=T)
staff$Lead <- as.character(staff$Lead)

chose <- grep("/", as.character(staff$Lead))
a <- staff$Lead[chose]
chose
b <- unlist(strsplit(as.character(a), "/"))
c <- gsub("* $","",gsub("^ ", "",b))
c
d <- unlist(strsplit(c, " "))
d
last <- matrix(d[seq(2,88,by=2)],ncol=2,byrow=T)
lastname <- apply(last,1,toString)
staff$Lead[chose] <- gsub(", ", "/", lastname)
e <- staff$Lead[-chose]
g <- unlist(strsplit(as.character(e), " "))[seq(2,38,2)]
g
 staff$Lead[-chose]<- g
 write.csv(staff$Lead,"lead.csv")
 
first <- df$`Teacher's Name`%in%table[,1][which(table$Freq==1)]
error1 <- data[which(first==T),]
names(error1)
error11 <- error1[,-c((7:38),1,40)]
error11
write.csv(error11,"error11.csv")
names(data)
write.csv(data[data$Classroom=="PSP3",]$`Child's Name`,"namelist_1.csv")

