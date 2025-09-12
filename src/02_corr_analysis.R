library(Hmisc)
library(reshape)
setwd("C:/Users/")
FQ_enzim_agras_hong_func_CLASIF <- read.delim("Filename.csv", row.names=1)
tabAN<-FQ_enzim_agras_hong_func_CLASIF[(35:50),]
tabAN<-as.matrix(tabAN)
corrAN<-rcorr(tabAN, type="pearson")
corrANp<-corrAN$P
corrANp[upper.tri(corrANp)]<- NA
longR<-melt(corrANr, id.vars="row.names")
names(longR) <- c("funcion1","funcion2", "R")
longP<-melt(corrANp, id.vars="row.names")
names(longP) <- c("funcion1","funcion2", "P")
longRP<-cbind(longR,longP$P)
names(longRP) <- c("funcion1","funcion2","R","P")
corr.imp.7<-longRP[which(abs(longRP$R)>0.7),]
fix(corr.imp.7)
corr.imp.7.nNA<-corr.imp.7[complete.cases(corr.imp.7),]
fix(corr.imp.7.nNA)
write.table(corr.imp.7.nNA,"Filename.csv",row.names=FALSE,sep="\t",quote=FALSE)
