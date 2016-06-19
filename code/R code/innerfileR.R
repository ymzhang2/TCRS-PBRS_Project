#install.packages("RMySQL")
library("DBI")
library("RMySQL")

mydb = dbConnect(MySQL(), user='innerfile', password='Appletree321', dbname='ecrdata', host = '173.194.252.123')
dbListTables(mydb)
dbListFields(mydb, 'V')
rs = dbSendQuery(mydb, "select visit
                        from V;")
df = fetch(rs, n=-1)
table(df)
hist(df$visit, freq=T,breaks=30)
quantile(df$visit, 0.9,na.rm = T)
quantile(df$visit, probs=c(0,0.25, 0.5,0.65,0.75,0.8,0.85,0.9,0.95),na.rm=T)
### get the average visit to sit&watch spot by lea for each month
rs1 <- dbSendQuery(mydb,"select leaId, avg(time) avg_time, avg(visit) avg_visit,month
                   from V
                   group by leaID, month
                   order by leaID,month;")
df1 <- fetch(rs1,n=-1)

###remove null data
df1 <- na.omit(df1)

colnames(df1)
str(df1)
### change the data type of leaID from character to factor 
df1$leaID <- as.factor(df1$leaID)
### PLot: average visit to sit&watch spot for each month by lea
p = ggplot(df1, aes(x=month, y=avg_visit,fill=leaID)) +  geom_point(size=2,shape=21) + geom_line()
### split the above plot
p + facet_grid(leaID~.)

### get the average visit to sit&watch spot by lea and campus for each month
rs2 <- dbSendQuery(mydb,"select leaId, campusID,avg(time) 'avg_time',avg(visit)'avg_visit',month
                         from V
                         group by leaID, campusID,month
                         order by leaID,campusID,month;")
df2 <- fetch(rs2, n=-1)
##remove nas
df2 <- na.omit(df2)
df2

### draw graph of average visit for  each campus in AELPCS
df2.AELPCS <- df2[df2$leaID=="AELPCS",]
p.AELPCS <- ggplot(df2.AELPCS, aes(x=month, y=avg_visit,fill=campusID)) +  geom_point(size=4,shape=21) + geom_line()
p.AELPCS
p.AELPCS + facet_grid(campusID~.)
### draw graph of average visit for each campus in CC
df2.CC <- df2[df2$leaID=="CC",]
p.CC <- ggplot(df2.CC, aes(x=month, y=avg_visit,fill=campusID)) +  geom_point(size=4,shape=21) + geom_line()
p.CC
p.CC + facet_grid(campusID~.)

