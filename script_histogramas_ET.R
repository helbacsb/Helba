setwd("D:/Helba/ElementosTransponiveis") #Indicando qual o diretorio de trabalho
#install.packages("dplyr") #instalando o pacote dplyr
#install.packages("gdata") #instalando o pacote gdata
#install.packages("data.table") #instalando o pacote data.table
#install.packages("stringr") #instalando o pacote stringr
#install.packages("plyr") #instalando o pacote plyr
#install.packages("filesstrings") #instalando o pacote filesstrings
#install.packages("splitstackshape") #instalando o pacote splitstackshape
library(dplyr) #Chama o pacote dplyr
library(gdata) #Chama o pacote gdata
library(data.table) #Chama o pacote data.table
library(stringr) #Chamando o pacote stringr
library(plyr) #Chama o pacote plyr
library(filesstrings) #Chama o pacote filesstrings
library(splitstackshape) #Chama o pacote splitstackshape
Dados <- data.frame(read.csv("D:/Helba/ElementosTransponiveis/dados_Histograma_ET.csv", header=TRUE, sep="\t")) #lendo o conteudo do arquivo
HELITRON_022_O03 <- filter(Dados, qseqid=="HELITRON_022_O03")
HELITRON_022_O03_Length <- HELITRON_022_O03[, c(4)]
HELITRON_028_K12 <- filter(Dados, qseqid=="HELITRON_028_K12")
HELITRON_028_K12_Length <- HELITRON_028_K12[, c(4)]
HELITRON_041_N14 <- filter(Dados, qseqid=="HELITRON_041_N14")
HELITRON_041_N14_Length <- HELITRON_041_N14[, c(4)]
HELITRON_170_G03 <- filter(Dados, qseqid=="HELITRON_170_G03")
HELITRON_170_G03_Length <- HELITRON_170_G03[, c(4)]
HELITRON_18509 <- filter(Dados, qseqid=="HELITRON_18509")
HELITRON_18509_Length <- HELITRON_18509[, c(4)]
HELITRON_7172 <- filter(Dados, qseqid=="HELITRON_7172")
HELITRON_7172_Length <- HELITRON_7172[, c(4)]
HELITRON_7709 <- filter(Dados, qseqid=="HELITRON_7709")
HELITRON_7709_Length <- HELITRON_7709[, c(4)]
scAle_1.2 <- filter(Dados, qseqid=="scAle_1.2")
scAle_1.2_Length <- scAle_1.2[, c(4)]
scAle_2.1 <- filter(Dados, qseqid=="scAle_2.1")
scAle_2.1_Length <- scAle_2.1[, c(4)]
scAle_3.1 <- filter(Dados, qseqid=="scAle_3.1")
scAle_3.1_Length <- scAle_3.1[, c(4)]
scAle_4.1 <- filter(Dados, qseqid=="scAle_4.1")
scAle_4.1_Length <- scAle_4.1[, c(4)]
scAle_5.1 <- filter(Dados, qseqid=="scAle_5.1")
scAle_5.1_Length <- scAle_5.1[, c(4)]
scAngela_1.1 <- filter(Dados, qseqid=="scAngela_1.1")
scAngela_1.1_Length <- scAngela_1.1[, c(4)]
scAngela_2.1 <- filter(Dados, qseqid=="scAngela_2.1")
scAngela_2.1_Length <- scAngela_2.1[, c(4)]
scAngela_3.1 <- filter(Dados, qseqid=="scAngela_3.1")
scAngela_3.1_Length <- scAngela_3.1[, c(4)]
scDEL_1.1 <- filter(Dados, qseqid=="scDEL_1.1")
scDEL_1.1_Length <- scDEL_1.1[, c(4)]
scDEL_2.1 <- filter(Dados, qseqid=="scDEL_2.1")
scDEL_2.1_Length <- scDEL_2.1[, c(4)]
scDEL_2.2 <- filter(Dados, qseqid=="scDEL_2.2")
scDEL_2.2_Length <- scDEL_2.2[, c(4)]
scDEL_3.1 <- filter(Dados, qseqid=="scDEL_3.1")
scDEL_3.1_Length <- scDEL_3.1[, c(4)]
scDEL_4.1 <- filter(Dados, qseqid=="scDEL_4.1")
scDEL_4.1_Length <- scDEL_4.1[, c(4)]
scDEL_5.1 <- filter(Dados, qseqid=="scDEL_5.1")
scDEL_5.1_Length <- scDEL_5.1[, c(4)]
scDEL_6.1 <- filter(Dados, qseqid=="scDEL_6.1")
scDEL_6.1_Length <- scDEL_6.1[, c(4)]
SChAT124F07 <- filter(Dados, qseqid=="SChAT124F07")
SChAT124F07_Length <- SChAT124F07[, c(4)]
SChAT152D05 <- filter(Dados, qseqid=="SChAT152D05")
SChAT152D05_Length <- SChAT152D05[, c(4)]
SChAT160F01 <- filter(Dados, qseqid=="SChAT160F01")
SChAT160F01_Length <- SChAT160F01[, c(4)]
SChAT167G07 <- filter(Dados, qseqid=="SChAT167G07")
SChAT167G07_Length <- SChAT167G07[, c(4)]
SChAT170C07 <- filter(Dados, qseqid=="SChAT170C07")
SChAT170C07_Length <- SChAT170C07[, c(4)]
SChAT185O22 <- filter(Dados, qseqid=="SChAT185O22")
SChAT185O22_Length <- SChAT185O22[, c(4)]
SChAT92C13 <- filter(Dados, qseqid=="SChAT92C13")
SChAT92C13_Length <- SChAT92C13[, c(4)]
SChATG1 <- filter(Dados, qseqid=="SChATG1")
SChATG1_Length <- SChATG1[, c(4)]
scHel1 <- filter(Dados, qseqid=="scHel1")
scHel1_Length <- scHel1[, c(4)]
scHel36 <- filter(Dados, qseqid=="scHel36")
scHel36_Length <- scHel36[, c(4)]
scHel37 <- filter(Dados, qseqid=="scHel37")
scHel37_Length <- scHel37[, c(4)]
scHel38 <- filter(Dados, qseqid=="scHel38")
scHel38_Length <- scHel38[, c(4)]
scHel39 <- filter(Dados, qseqid=="scHel39")
scHel39_Length <- scHel39[, c(4)]
scHel40 <- filter(Dados, qseqid=="scHel40")
scHel40_Length <- scHel40[, c(4)]
scHel41 <- filter(Dados, qseqid=="scHel41")
scHel41_Length <- scHel41[, c(4)]
scHel42 <- filter(Dados, qseqid=="scHel42")
scHel42_Length <- scHel42[, c(4)]
scHel43 <- filter(Dados, qseqid=="scHel43")
scHel43_Length <- scHel43[, c(4)]
scHel44 <- filter(Dados, qseqid=="scHel44")
scHel44_Length <- scHel44[, c(4)]
scHel45 <- filter(Dados, qseqid=="scHel45")
scHel45_Length <- scHel45[, c(4)]
scIvana_1.1 <- filter(Dados, qseqid=="scIvana_1.1")
scIvana_1.1_Length <- scIvana_1.1[, c(4)]
scIvana_2.1 <- filter(Dados, qseqid=="scIvana_2.1")
scIvana_2.1_Length <- scIvana_2.1[, c(4)]
scIvana_3.1 <- filter(Dados, qseqid=="scIvana_3.1")
scIvana_3.1_Length <- scIvana_3.1[, c(4)]
scIvana_4.1 <- filter(Dados, qseqid=="scIvana_4.1")
scIvana_4.1_Length <- scIvana_4.1[, c(4)]
scIvana_5.1 <- filter(Dados, qseqid=="scIvana_5.1")
scIvana_5.1_Length <- scIvana_5.1[, c(4)]
scIvana_6.1 <- filter(Dados, qseqid=="scIvana_6.1")
scIvana_6.1_Length <- scIvana_6.1[, c(4)]
scMaximus_1.1 <- filter(Dados, qseqid=="scMaximus_1.1")
scMaximus_1.1_Length <- scMaximus_1.1[, c(4)]
scMaximus_2.1 <- filter(Dados, qseqid=="scMaximus_2.1")
scMaximus_2.1_Length <- scMaximus_2.1[, c(4)]
scMaximus_3.1 <- filter(Dados, qseqid=="scMaximus_3.1")
scMaximus_3.1_Length <- scMaximus_3.1[, c(4)]
scMaximus_4.1 <- filter(Dados, qseqid=="scMaximus_4.1")
scMaximus_4.1_Length <- scMaximus_4.1[, c(4)]
scMutator_classI <- filter(Dados, qseqid=="scMutator_classI")
scMutator_classI_Length <- scMutator_classI[, c(4)]
scMutator_classII <- filter(Dados, qseqid=="scMutator_classII")
scMutator_classII_Length <- scMutator_classII[, c(4)]
scMutator_ClassIII_Mustang <- filter(Dados, qseqid=="scMutator_ClassIII_Mustang")
scMutator_ClassIII_Mustang_Length <- scMutator_ClassIII_Mustang[, c(4)]
scMutator_ClassIV_Mustang <- filter(Dados, qseqid=="scMutator_ClassIV_Mustang")
scMutator_ClassIV_Mustang_Length <- scMutator_ClassIV_Mustang[, c(4)]
scReina_1.1 <- filter(Dados, qseqid=="scReina_1.1")
scReina_1.1_Length <- scReina_1.1[, c(4)]
scReina_2.1 <- filter(Dados, qseqid=="scReina_2.1")
scReina_2.1_Length <- scReina_2.1[, c(4)]
scReina_3.1 <- filter(Dados, qseqid=="scReina_3.1")
scReina_3.1_Length <- scReina_3.1[, c(4)]
scReina_4.1 <- filter(Dados, qseqid=="scReina_4.1")
scReina_4.1_Length <- scReina_4.1[, c(4)]
scTat_1.1 <- filter(Dados, qseqid=="scTat_1.1")
scTat_1.1_Length <- scTat_1.1[, c(4)]
scTat_2.1 <- filter(Dados, qseqid=="scTat_2.1")
scTat_2.1_Length <- scTat_2.1[, c(4)]
scTat_3.1 <- filter(Dados, qseqid=="scTat_3.1")
scTat_3.1_Length <- scTat_3.1[, c(4)]
scTat_4.1 <- filter(Dados, qseqid=="scTat_4.1")
scTat_4.1_Length <- scTat_4.1[, c(4)]
scTat_5.1 <- filter(Dados, qseqid=="scTat_5.1")
scTat_5.1_Length <- scTat_5.1[, c(4)]
scTat_6.1 <- filter(Dados, qseqid=="scTat_6.1")
scTat_6.1_Length <- scTat_6.1[, c(4)]
scTat_7.1 <- filter(Dados, qseqid=="scTat_7.1")
scTat_7.1_Length <- scTat_7.1[, c(4)]

png(file="D:/Helba/ElementosTransponiveis/histogram_01.png", width=750, height=350)
hist(HELITRON_022_O03_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_022_O03 (8916pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_02.png", width=750, height=350)
hist(HELITRON_028_K12_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_028_K12 (9945pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,3500), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_03.png", width=750, height=350)
hist(HELITRON_041_N14_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_041_N14 (10654pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_04.png", width=750, height=350)
hist(HELITRON_170_G03_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_170_G03 (7141pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_05.png", width=750, height=350)
hist(HELITRON_18509_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_18509 (18509pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_06.png", width=750, height=350)
hist(HELITRON_7172_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_7172 (7172pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_07.png", width=750, height=350)
hist(HELITRON_7709_Length,  
           main = "Distribuição do tamanho dos contigs em HELITRON_7709 (7709pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#3b528b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_08.png", width=750, height=350)
hist(scAle_1.2_Length,  
           main = "Distribuição do tamanho dos contigs em scAle_1.2 (5962pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#f1605d"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_09.png", width=750, height=350)
hist(scAle_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAle_2.1 (4849pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#f1605d"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_10.png", width=750, height=350)
hist(scAle_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAle_3.1 (4788pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#f1605d"), 
           border = FALSE, 
           xlim = c(0,500), ylim = c(0,100),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_11.png", width=750, height=350)
hist(scAle_4.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAle_4.1 (4866pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#f1605d"), 
           border = FALSE, 
           xlim = c(0,2500), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_12.png", width=750, height=350)
hist(scAle_5.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAle_5.1 (5303pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#f1605d"), 
           border = FALSE, 
           xlim = c(0,7000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_13.png", width=750, height=350)
hist(scAngela_1.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAngela_1.1 (6662pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#cd4071"), 
           border = FALSE, 
           xlim = c(0,6000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_14.png", width=750, height=350)
hist(scAngela_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAngela_2.1 (8576pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#cd4071"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_15.png", width=750, height=350)
hist(scAngela_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scAngela_3.1 (6560pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#cd4071"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_16.png", width=750, height=350)
hist(scDEL_1.1_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_1.1 (16709pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,12000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_17.png", width=750, height=350)
hist(scDEL_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_2.1 (13894pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,7000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_18.png", width=750, height=350)
hist(scDEL_2.2_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_2.2 (13908pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,7000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_19.png", width=750, height=350)
hist(scDEL_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_3.1 (11304pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,10000), ylim = c(0,800),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_20.png", width=750, height=350)
hist(scDEL_4.1_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_4.1 (11894pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,10000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_21.png", width=750, height=350)
hist(scDEL_5.1_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_5.1 (11722pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_22.png", width=750, height=350)
hist(scDEL_6.1_Length,  
           main = "Distribuição do tamanho dos contigs em scDEL_6.1 (14462pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#0d0887"), 
           border = FALSE, 
           xlim = c(0,10000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_23.png", width=750, height=350)
hist(SChAT124F07_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT124F07 (4840pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_24.png", width=750, height=350)
hist(SChAT152D05_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT152D05 (5252pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,4000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_25.png", width=750, height=350)
hist(SChAT160F01_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT160F01 (6484pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_26.png", width=750, height=350)
hist(SChAT167G07_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT167G07 (6051pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,4000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_27.png", width=750, height=350)
hist(SChAT170C07_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT170C07 (5014pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,4000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_28.png", width=750, height=350)
hist(SChAT185O22_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT185O22 (3773pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,4000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_29.png", width=750, height=350)
hist(SChAT92C13_Length,  
           main = "Distribuição do tamanho dos contigs em SChAT92C13 (3288pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_30.png", width=750, height=350)
hist(SChATG1_Length,  
           main = "Distribuição do tamanho dos contigs em SChATG1 (4616pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#ed7953"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_31.png", width=750, height=350)
hist(scHel1_Length,  
           main = "Distribuição do tamanho dos contigs em scHel1 (11314pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,10000), ylim = c(0,600),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_32.png", width=750, height=350)
hist(scHel36_Length,  
           main = "Distribuição do tamanho dos contigs em scHel36 (10401pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_33.png", width=750, height=350)
hist(scHel37_Length,  
           main = "Distribuição do tamanho dos contigs em scHel37 (4101pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_34.png", width=750, height=350)
hist(scHel38_Length,  
           main = "Distribuição do tamanho dos contigs em scHel38 (9701pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_35.png", width=750, height=350)
hist(scHel39_Length,  
           main = "Distribuição do tamanho dos contigs em scHel39 (9701pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_36.png", width=750, height=350)
hist(scHel40_Length,  
           main = "Distribuição do tamanho dos contigs em scHel40 (3901pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,14000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_37.png", width=750, height=350)
hist(scHel41_Length,  
           main = "Distribuição do tamanho dos contigs em scHel41 (5701pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,14000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_38.png", width=750, height=350)
hist(scHel42_Length,  
           main = "Distribuição do tamanho dos contigs em scHel42 (5701pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,14000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_39.png", width=750, height=350)
hist(scHel43_Length,  
           main = "Distribuição do tamanho dos contigs em scHel43 (16001pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_40.png", width=750, height=350)
hist(scHel44_Length,  
           main = "Distribuição do tamanho dos contigs em scHel44 (6001pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_41.png", width=750, height=350)
hist(scHel45_Length,  
           main = "Distribuição do tamanho dos contigs em scHel45 (11001pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fd9b6b"), 
           border = FALSE, 
           xlim = c(0,7000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_42.png", width=750, height=350)
hist(scIvana_1.1_Length,  
           main = "Distribuição do tamanho dos contigs em scIvana_1.1 (5275pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#c03a76"), 
           border = FALSE, 
           xlim = c(0,7000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_43.png", width=750, height=350)
hist(scIvana_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scIvana_2.1 (5201pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#c03a76"), 
           border = FALSE, 
           xlim = c(0,500), ylim = c(0,100),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_44.png", width=750, height=350)
hist(scIvana_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scIvana_3.1 (5300pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#c03a76"), 
           border = FALSE, 
           xlim = c(0,6000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_45.png", width=750, height=350)
hist(scIvana_4.1_Length,  
           main = "Distribuição do tamanho dos contigs em scIvana_4.1 (5325pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#c03a76"), 
           border = FALSE, 
           xlim = c(0,6000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_46.png", width=750, height=350)
hist(scIvana_5.1_Length,  
           main = "Distribuição do tamanho dos contigs em scIvana_5.1 (5034pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#c03a76"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_47.png", width=750, height=350)
hist(scIvana_6.1_Length,  
           main = "Distribuição do tamanho dos contigs em scIvana_6.1 (5948pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#c03a76"), 
           border = FALSE, 
           xlim = c(0,7000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_48.png", width=750, height=350)
hist(scMaximus_1.1_Length,  
           main = "Distribuição do tamanho dos contigs em scMaximus_1.1 (13646pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#29af7f"), 
           border = FALSE, 
           xlim = c(0,14000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_49.png", width=750, height=350)
hist(scMaximus_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scMaximus_2.1 (11046pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#29af7f"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_50.png", width=750, height=350)
hist(scMaximus_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scMaximus_3.1 (10586pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#29af7f"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_51.png", width=750, height=350)
hist(scMaximus_4.1_Length,  
           main = "Distribuição do tamanho dos contigs em scMaximus_4.1 (10446pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#29af7f"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_52.png", width=750, height=350)
hist(scMutator_classI_Length,  
           main = "Distribuição do tamanho dos contigs em scMutator_classI (2086pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#71196e"), 
           border = FALSE, 
           xlim = c(0,3000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_53.png", width=750, height=350)
hist(scMutator_classII_Length,  
           main = "Distribuição do tamanho dos contigs em scMutator_classII (2448pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#71196e"), 
           border = FALSE, 
           xlim = c(0,6000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_54.png", width=750, height=350)
hist(scMutator_ClassIII_Mustang_Length,  
           main = "Distribuição do tamanho dos contigs em scMutator_ClassIII_Mustang (2132pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#71196e"), 
           border = FALSE, 
           xlim = c(0,4000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_55.png", width=750, height=350)
hist(scMutator_ClassIV_Mustang_Length,  
           main = "Distribuição do tamanho dos contigs em scMutator_ClassIV_Mustang (2250pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#71196e"), 
           border = FALSE, 
           xlim = c(0,10000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_56.png", width=750, height=350)
hist(scReina_1.1_Length,  
           main = "Distribuição do tamanho dos contigs em scReina_1.1 (5163pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fccd25"), 
           border = FALSE, 
           xlim = c(0,3000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_57.png", width=750, height=350)
hist(scReina_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scReina_2.1 (5747pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fccd25"), 
           border = FALSE, 
           xlim = c(0,8000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_58.png", width=750, height=350)
hist(scReina_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scReina_3.1 (5489pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fccd25"), 
           border = FALSE, 
           xlim = c(0,6000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_59.png", width=750, height=350)
hist(scReina_4.1_Length,  
           main = "Distribuição do tamanho dos contigs em scReina_4.1 (5203pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("#fccd25"), 
           border = FALSE, 
           xlim = c(0,3500), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_60.png", width=750, height=350)
hist(scTat_1.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_1.1 (15078pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,12000), ylim = c(0,500),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_61.png", width=750, height=350)
hist(scTat_2.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_2.1 (17145pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_62.png", width=750, height=350)
hist(scTat_3.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_3.1 (9565pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,4000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_63.png", width=750, height=350)
hist(scTat_4.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_4.1 (17771pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,12000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_64.png", width=750, height=350)
hist(scTat_5.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_5.1 (10809pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,12000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_65.png", width=750, height=350)
hist(scTat_6.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_6.1 (9208pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,5000), ylim = c(0,400),
           labels = TRUE)
dev.off()

png(file="D:/Helba/ElementosTransponiveis/histogram_66.png", width=750, height=350)
hist(scTat_7.1_Length,  
           main = "Distribuição do tamanho dos contigs em scTat_7.1 (12358pb)", 
           xlab = "tamanho dos contigs", ylab = "Frequência", 
           col = c("lightblue"), 
           border = FALSE, 
           xlim = c(0,2500), ylim = c(0,400),
           labels = TRUE)
dev.off()







