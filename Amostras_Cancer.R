#script em R para comparar variantes de Amostras

#setwd("C:/Users/Adenina/Documents/Helba_Cirino/CompararAmostrasCancer") #Indicando qual o diretorio de trabalho

#install.packages("vcfR")
#install.packages("plyr")
#install.packages("tidyverse")
#install.packages("VennDiagram")
#install.packages("venn")
#install.packages("dplyr") #instalando o pacote dplyr
#install.packages("data.table")#instalando o pacote data.table
library(vcfR) #Carregando o pacote vcfR
library(plyr)#Chama o pacote plyr
library(tidyverse)#Chama o pacote tidyverse
library(dplyr)#Chama o pacote dplyr
library(VennDiagram)
library(venn)#Chama o pacote Venn
library(data.table) #Chama o pacote data.table

NomeAmostra1 <- readline(prompt="Qual o nome do arquivo da Amostra 01 do Paciente Sensivel a Doxorubicina? ")#Imprimindo a frase e lendo o nome do arquivo da Amostra do Paciente
NomeAmostra2 <- readline(prompt="Qual o nome do arquivo da Amostra 02 do Paciente Sensivel a Doxorubicina? ")
NomeAmostra3 <- readline(prompt="Qual o nome do arquivo da Amostra 03 do Paciente Sensivel a Doxorubicina? ")
NomeAmostra4 <- readline(prompt="Qual o nome do arquivo da Amostra 04 do Paciente Sensivel a Doxorubicina? ")
NomeAmostra5 <- readline(prompt="Qual o nome do arquivo da Amostra 01 do Paciente Resistente a Doxorubicina? ")
NomeAmostra6 <- readline(prompt="Qual o nome do arquivo da Amostra 02 do Paciente Resistente a Doxorubicina? ")
NomeAmostra7 <- readline(prompt="Qual o nome do arquivo da Amostra 03 do Paciente Resistente a Doxorubicina? ")
Amostra1 <- read.vcfR(NomeAmostra1, verbose = FALSE)#lendo o conteudo do arquivo da amostra do Paciente
Amostra2 <- read.vcfR(NomeAmostra2, verbose = FALSE)
Amostra3 <- read.vcfR(NomeAmostra3, verbose = FALSE)
Amostra4 <- read.vcfR(NomeAmostra4, verbose = FALSE)
Amostra5 <- read.vcfR(NomeAmostra5, verbose = FALSE)
Amostra6 <- read.vcfR(NomeAmostra6, verbose = FALSE)
Amostra7 <- read.vcfR(NomeAmostra7, verbose = FALSE)

NomeAmostra1 <- gsub(".vcf","",NomeAmostra1)
NomeAmostra2 <- gsub(".vcf","",NomeAmostra2)
NomeAmostra3 <- gsub(".vcf","",NomeAmostra3)
NomeAmostra4 <- gsub(".vcf","",NomeAmostra4)
NomeAmostra5 <- gsub(".vcf","",NomeAmostra5)
NomeAmostra6 <- gsub(".vcf","",NomeAmostra6)
NomeAmostra7 <- gsub(".vcf","",NomeAmostra7)

Amostra1_FIX<-getFIX(Amostra1)#pegando as sete primeiras colunas do arquivo vcf da amostra 1
Amostra1_FIX <- data.frame(Amostra1_FIX)#transformando em dataframe
Amostra2_FIX<-getFIX(Amostra2)#pegando as sete primeiras colunas do arquivo vcf da amostra 2
Amostra2_FIX <- data.frame(Amostra2_FIX)#transformando em dataframe
Amostra3_FIX<-getFIX(Amostra3)
Amostra3_FIX <- data.frame(Amostra3_FIX)
Amostra4_FIX<-getFIX(Amostra4)
Amostra4_FIX <- data.frame(Amostra4_FIX)
Amostra5_FIX<-getFIX(Amostra5)
Amostra5_FIX <- data.frame(Amostra5_FIX)
Amostra6_FIX<-getFIX(Amostra6)
Amostra6_FIX <- data.frame(Amostra6_FIX)
Amostra7_FIX<-getFIX(Amostra7)
Amostra7_FIX <- data.frame(Amostra7_FIX)

Amostra1_FIX["VID"]<- paste(Amostra1_FIX$CHROM,":", Amostra1_FIX$POS,":",Amostra1_FIX$REF,":",Amostra1_FIX$ALT)#Compondo a coluna VID da Amostra 1
Amostra2_FIX["VID"]<- paste(Amostra2_FIX$CHROM,":", Amostra2_FIX$POS,":",Amostra2_FIX$REF,":",Amostra2_FIX$ALT)#Compondo a coluna VID da Amostra 2
Amostra3_FIX["VID"]<- paste(Amostra3_FIX$CHROM,":", Amostra3_FIX$POS,":",Amostra3_FIX$REF,":",Amostra3_FIX$ALT)
Amostra4_FIX["VID"]<- paste(Amostra4_FIX$CHROM,":", Amostra4_FIX$POS,":",Amostra4_FIX$REF,":",Amostra4_FIX$ALT)
Amostra5_FIX["VID"]<- paste(Amostra5_FIX$CHROM,":", Amostra5_FIX$POS,":",Amostra5_FIX$REF,":",Amostra5_FIX$ALT)
Amostra6_FIX["VID"]<- paste(Amostra6_FIX$CHROM,":", Amostra6_FIX$POS,":",Amostra6_FIX$REF,":",Amostra6_FIX$ALT)
Amostra7_FIX["VID"]<- paste(Amostra7_FIX$CHROM,":", Amostra7_FIX$POS,":",Amostra7_FIX$REF,":",Amostra7_FIX$ALT)

Amostra1_FIX["Sensivel_1"] <- NomeAmostra1
Amostra2_FIX["Sensivel_2"] <- NomeAmostra2
Amostra3_FIX["Sensivel_3"] <- NomeAmostra3
Amostra4_FIX["Sensivel_4"] <- NomeAmostra4
Amostra5_FIX["Resistente_1"] <- NomeAmostra5
Amostra6_FIX["Resistente_2"] <- NomeAmostra6
Amostra7_FIX["Resistente_3"] <- NomeAmostra7

Amostra1_FIX <- Amostra1_FIX[, c(8,9,1:7)]#Reordenando as colunas da tabela Amostra1_FIX
Amostra2_FIX <- Amostra2_FIX[, c(8,9,1:7)]
Amostra3_FIX <- Amostra3_FIX[, c(8,9,1:7)]
Amostra4_FIX <- Amostra4_FIX[, c(8,9,1:7)]
Amostra5_FIX <- Amostra5_FIX[, c(8,9,1:7)]
Amostra6_FIX <- Amostra6_FIX[, c(8,9,1:7)]
Amostra7_FIX <- Amostra7_FIX[, c(8,9,1:7)]

VID_1 <- Amostra1_FIX[1:2]
VID_2 <- Amostra2_FIX[1:2]
VID_3 <- Amostra3_FIX[1:2]
VID_4 <- Amostra4_FIX[1:2]
VID_5 <- Amostra5_FIX[1:2]
VID_6 <- Amostra6_FIX[1:2]
VID_7 <- Amostra7_FIX[1:2]

tabela<- merge(VID_1, VID_2, by.x = "VID", by.y = "VID", all.x = TRUE, all.y = TRUE)
tabela<- merge(tabela, VID_3, by.x = "VID", by.y = "VID", all.x = TRUE, all.y = TRUE)
tabela<- merge(tabela, VID_4, by.x = "VID", by.y = "VID", all.x = TRUE, all.y = TRUE)
tabela<- merge(tabela, VID_5, by.x = "VID", by.y = "VID", all.x = TRUE, all.y = TRUE)
tabela<- merge(tabela, VID_6, by.x = "VID", by.y = "VID", all.x = TRUE, all.y = TRUE)
tabela<- merge(tabela, VID_7, by.x = "VID", by.y = "VID", all.x = TRUE, all.y = TRUE)

quadro<-tabela[2:8]
quadro_1<-data.frame(!(is.na(quadro)))

quadro_1$Sensivel_1[which(quadro_1$Sensivel_1 == "FALSE")] <- 0
quadro_1$Sensivel_2[which(quadro_1$Sensivel_2 == "FALSE")] <- 0
quadro_1$Sensivel_3[which(quadro_1$Sensivel_3 == "FALSE")] <- 0
quadro_1$Sensivel_4[which(quadro_1$Sensivel_4 == "FALSE")] <- 0
quadro_1$Resistente_1[which(quadro_1$Resistente_1 == "FALSE")] <- 0
quadro_1$Resistente_2[which(quadro_1$Resistente_2 == "FALSE")] <- 0
quadro_1$Resistente_3[which(quadro_1$Resistente_3 == "FALSE")] <- 0

quadro_1$Sensivel_1[which(quadro_1$Sensivel_1 == "TRUE")] <- 1
quadro_1$Sensivel_2[which(quadro_1$Sensivel_2 == "TRUE")] <- 1
quadro_1$Sensivel_3[which(quadro_1$Sensivel_3 == "TRUE")] <- 1
quadro_1$Sensivel_4[which(quadro_1$Sensivel_4 == "TRUE")] <- 1
quadro_1$Resistente_1[which(quadro_1$Resistente_1 == "TRUE")] <- 1
quadro_1$Resistente_2[which(quadro_1$Resistente_2 == "TRUE")] <- 1
quadro_1$Resistente_3[which(quadro_1$Resistente_3 == "TRUE")] <- 1

venn(quadro_1, snames = "", counts = NULL, ilabels = FALSE, ellipse = FALSE, zcolor = "style", opacity = 0.4, size = 15, cexil = 0.7, cexsn = 0.9, borders = TRUE)

png(file="Venn7.png", res=148, width=960,height=960)
dev.off()

now<-format(Sys.time(), "%Y_%m_%d_%X")#Pegando a data e a hora
now <- str_replace_all(now, ":", "_")#trocando : por _

NameFile<-paste0("Resistentes","_","Sensiveis","_", now ,".csv")#Montando o nome do arquivo

write.table(tabela, file = NameFile, row.names=FALSE, sep="\t") #criando o arquivo Resistentes_Sensiveis

quadro_1$Numero_de_Sensiveis <- (quadro_1$Sensivel_1 + quadro_1$Sensivel_2 + quadro_1$Sensivel_3 + quadro_1$Sensivel_4)
quadro_1$Numero_de_Resistentes <- (quadro_1$Resistente_1 + quadro_1$Resistente_2 + quadro_1$Resistente_3)

Ocorrencia_1 <- quadro_1[8:9]
Ocorrencia_1$Numero_de_Sensiveis[which(Ocorrencia_1$Numero_de_Sensiveis >= 1)] <- 1
Ocorrencia_1$Numero_de_Resistentes[which(Ocorrencia_1$Numero_de_Resistentes >= 1)] <- 1
venn(Ocorrencia_1, snames = "", counts = NULL, ilabels = FALSE, ellipse = FALSE, zcolor = "style", opacity = 0.4, size = 15, cexil = 0.7, cexsn = 0.9, borders = TRUE)
png(file="Venn2_Ocorrencia_1.png", res=148, width=960,height=960)
dev.off()

Ocorrencia_2 <- quadro_1[8:9]
expr <- data.table(Ocorrencia_2) #variavel expr recebe o conteudo da tabela Ocorrencia_2 em forma de data frame.
#Variavel Ocorrencia_2 recebe apenas as Variantes com ocorrencia em pelo menos 2 amostras
#Ocorrencia_2<-expr[((Numero_de_Sensiveis >= 2)||(Numero_de_Resistentes >= 2))]
Ocorrencia_2$Numero_de_Sensiveis[which(Ocorrencia_2$Numero_de_Sensiveis < 2)] <- 0
Ocorrencia_2$Numero_de_Resistentes[which(Ocorrencia_2$Numero_de_Resistentes < 2)] <- 0
Ocorrencia_2$Numero_de_Sensiveis[which(Ocorrencia_2$Numero_de_Sensiveis >= 2)] <- 1
Ocorrencia_2$Numero_de_Resistentes[which(Ocorrencia_2$Numero_de_Resistentes >= 2)] <- 1
venn(Ocorrencia_2, snames = "", counts = NULL, ilabels = FALSE, ellipse = FALSE, zcolor = "style", opacity = 0.4, size = 15, cexil = 0.7, cexsn = 0.9, borders = TRUE)
png(file="Venn2_Ocorrencia_2.png", res=148, width=960,height=960)
dev.off()

Ocorrencia_3 <- quadro_1[8:9]
expr <- data.table(Ocorrencia_3) #variavel expr recebe o conteudo da tabela Ocorrencia_3 em forma de data frame.
#Variavel Ocorrencia_3 recebe apenas as Variantes com ocorrencia em pelo menos 3 amostras
#Ocorrencia_3<-expr[((Numero_de_Sensiveis >= 3)||(Numero_de_Resistentes >= 3))]
Ocorrencia_3$Numero_de_Sensiveis[which(Ocorrencia_3$Numero_de_Sensiveis < 3)] <- 0
Ocorrencia_3$Numero_de_Resistentes[which(Ocorrencia_3$Numero_de_Resistentes < 3)] <- 0
Ocorrencia_3$Numero_de_Sensiveis[which(Ocorrencia_3$Numero_de_Sensiveis >= 3)] <- 1
Ocorrencia_3$Numero_de_Resistentes[which(Ocorrencia_3$Numero_de_Resistentes >= 3)] <- 1
venn(Ocorrencia_3, snames = "", counts = NULL, ilabels = FALSE, ellipse = FALSE, zcolor = "style", opacity = 0.4, size = 15, cexil = 0.7, cexsn = 0.9, borders = TRUE)
png(file="Venn2_Ocorrencia_3.png", res=148, width=960,height=960)
dev.off()

Ocorrencia_3_4 <- quadro_1[8:9]
expr <- data.table(Ocorrencia_3_4) #variavel expr recebe o conteudo da tabela Ocorrencia_3 em forma de data frame.
#Variavel Ocorrencia_3 recebe apenas as Variantes com ocorrencia em pelo menos 3 amostras
#Ocorrencia_3_4<-expr[((Numero_de_Sensiveis >= 3)||(Numero_de_Resistentes >= 3))]
Ocorrencia_3_4$Numero_de_Sensiveis[which(Ocorrencia_3_4$Numero_de_Sensiveis < 4)] <- 0
Ocorrencia_3_4$Numero_de_Resistentes[which(Ocorrencia_3_4$Numero_de_Resistentes < 3)] <- 0
Ocorrencia_3_4$Numero_de_Sensiveis[which(Ocorrencia_3_4$Numero_de_Sensiveis >= 4)] <- 1
Ocorrencia_3_4$Numero_de_Resistentes[which(Ocorrencia_3_4$Numero_de_Resistentes >= 3)] <- 1
venn(Ocorrencia_3_4, snames = "", counts = NULL, ilabels = FALSE, ellipse = FALSE, zcolor = "style", opacity = 0.4, size = 15, cexil = 0.7, cexsn = 0.9, borders = TRUE)
png(file="Venn2_Ocorrencia_3_4.png", res=148, width=960,height=960)
dev.off()


