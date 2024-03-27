#install.packages("VennDiagram")
#install.packages("venn")
library(VennDiagram)
library(venn)

dataframe <- read.csv("SP80_dataframe.csv", header = TRUE, sep = ",")
dataframe$SP80.NI1[which(dataframe$SP80.NI1 != "NA")] <- 1
dataframe$SP80.XG[which(dataframe$SP80.XG != "NA")] <- 1
dataframe$SP80.G[which(dataframe$SP80.G != "NA")] <- 1
dataframe$SP80.NI2[which(dataframe$SP80.NI2 != "NA")] <- 1
dataframe$SP80.S[which(dataframe$SP80.S != "NA")] <- 1
dataframe$SP80.L[which(dataframe$SP80.L != "NA")] <- 1
dataframe$SP80.X[which(dataframe$SP80.X != "NA")] <- 1
dataframe <- replace(dataframe, is.na(dataframe), 0)
venn(dataframe, snames = "", counts = NULL, ilabels = TRUE, ellipse = FALSE, zcolor = "style", opacity = 0.4, size = 15, cexil = 0.7, cexsn = 0.9, borders = TRUE)