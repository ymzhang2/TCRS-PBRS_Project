#install.packages("RMySQL")
library("DBI")
library("RMySQL")
### connect with ECR database
mydb = dbConnect(MySQL(), user='innerfile', password='Appletree321', dbname='ecrdata', host = '173.194.252.123')
dbListTables(mydb)

dbListFields(mydb, 'V') ### show me the variable in V
rs = dbSendQuery(mydb, "select visit
                 from V;")### show students' visit for each week through a year
df = fetch(rs, n=-1)
table(df)### the table that shows students' visit for each week through a year
hist(df$visit, freq=T,breaks=30)### make histogram to show the table
quantile(df$visit, 0.9,na.rm = T)### get the quantiles
quantile(df$visit, probs=c(0,0.25, 0.5,0.65,0.75,0.8,0.85,0.9,0.95),na.rm=T)

rs1 <- dbSendQuery(mydb,"select leaId, avg(time) avg_time, avg(visit) avg_visit,month
                   from V
                   group by leaID, month
                   order by leaID,month;")### get the average visit to sit&watch spot by lea for each month
df1 <- fetch(rs1,n=-1)


df1 <- na.omit(df1)###remove null data

colnames(df1)
str(df1)

df1$leaID <- as.factor(df1$leaID)### change the data type of leaID from character to factor 
library(ggplot2)
### PLot: average visit to sit&watch spot for each month by lea
p = ggplot(df1, aes(x=month, y=avg_visit,fill=leaID)) +  geom_point(size=4,shape=21) + geom_line()
p
df1
month1[month1$avg_visit>=4,]
p + facet_grid(leaID~.)### split the above plot


rs2 <- dbSendQuery(mydb,"select leaId, campusID,avg(time) 'avg_time',avg(visit)'avg_visit',month
                   from V
                   group by leaID, campusID,month
                   order by leaID,campusID,month;")### get the average visit to sit&watch spot by lea and campus for each month
df2 <- fetch(rs2, n=-1)

df2 <- na.omit(df2)##remove missing value
df2
df2$leaID <- as.factor(df2$leaID)
df2$campusID <- as.factor(df2$campusID)

df2.AELPCS <- df2[df2$leaID=="AELPCS",]

p.AELPCS <- ggplot(df2.AELPCS, aes(x=month, y=avg_visit,fill=campusID)) +  geom_point(size=4,shape=21) + geom_line()
p.AELPCS### PLot:students'average visit for  each campus in AELPCS
p.AELPCS + facet_grid(campusID~.)

df2.CC <- df2[df2$leaID=="CC",]
p.CC <- ggplot(df2.CC, aes(x=month, y=avg_visit,fill=campusID)) +  geom_point(size=4,shape=21) + geom_line()
p.CC### students' average visit for each campus in CC
p.CC + facet_grid(campusID~.)

