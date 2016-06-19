#install.packages("vcd")
library("vcd")

low_as$Campus <- gsub(" ","",gsub("[a-z]","",low_as$Campus))
low_as$Campus[which(low_as$Campus=="S")]="SW"
low_as$Campus[which(low_as$Campus=="P")]="PL"
low_as$Campus[which(low_as$Campus=="OA")]="OK" 
low_as$Classroom <- as.numeric(gsub("[A-Z]","",low_as$Classroom))
low_as$Gender <- gsub("[a-z]","",low_as$Gender)
mytable <- xtabs(~Campus+Gender+Classroom, data=low_as)
mosaic( ~ Campus + Gender+Classroom, data=mytable,
        highlighting="Gender", highlighting_fill=c("pink","lightblue"),
        direction=c("v","v","h"),labeling = labeling_values)
mytable1 <- xtabs(~Campus+Race,data=low_as)
mosaic( ~ Campus + Race, data=mytable1,
        highlighting="Race", highlighting_fill=c("pink","lightblue","red","brown","green","White"),
        direction=c("v","V"),labeling = labeling_values)
table(low_as$Race)


