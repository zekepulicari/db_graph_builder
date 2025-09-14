# Set wd
setwd("C:/Users/")

# Loading packages
library(Hmisc)
library(reshape)

# Reading csv file
FQ_enzim_agras_hong_func_CLASIF <- read.delim("./data", row.names= 1)

# Subset the df by treatment
tabAN <- FQ_enzim_agras_hong_func_CLASIF[(35:50), ]
tabAN <- as.matrix(tabAN)

# Correlation analysis
corrAN <- rcorr(tabAN, type= "pearson")
corrANp <- corrAN$P
corrANp[upper.tri(corrANp)] <- NA

# Reshaping dataframes
longR <- melt(corrANr, id.vars= "row.names")
names(longR) <- c("funcion1", "funcion2", "R")
longP <- melt(corrANp, id.vars="row.names")
names(longP) <- c("funcion1", "funcion2", "P")
longRP<-cbind(longR,longP$P)
names(longRP) <- c("funcion1", "funcion2", "R", "P")

# Subsetting significant correlations
corr.imp.7 <- longRP[which(abs(longRP$R) > 0.7), ]
fix(corr.imp.7)

# Removing NAs
corr.imp.7.nNA <- corr.imp.7[complete.cases(corr.imp.7), ]
fix(corr.imp.7.nNA)

# Writing to csv file
write.table(corr.imp.7.nNA, "correlation_07.csv", row.names=FALSE,sep="\t", quote=FALSE)