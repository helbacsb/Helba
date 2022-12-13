##############################################################################################
#                                                                                            #
#           script em R para calcular o valor de cobertura no resultado do Blastn            #
#                                                                                            #
##############################################################################################

setwd("C:/Users/CLQ/Documents/Helba/Menores_400/CalculandoCobertura") #Indicando qual o diretorio de trabalho

#install.packages("dplyr") #instalando o pacote dplyr
#install.packages("gdata") #instalando o pacote gdata
#install.packages("data.table") #instalando o pacote data.table
#install.packages("stringr") #instalando o pacote stringr
#install.packages("plyr") #instalando o pacote plyr
#install.packages("filesstrings") #instalando o pacote filesstrings
#install.packages("splitstackshape") #instalando o pacote splitstackshape
#install.packages("ggplot2")
library(dplyr) #Chama o pacote dplyr
library(gdata) #Chama o pacote gdata
library(data.table) #Chama o pacote data.table
library(stringr) #Chamando o pacote stringr
library(plyr) #Chama o pacote plyr
library(filesstrings) #Chama o pacote filesstrings
library(splitstackshape) #Chama o pacote splitstackshape
library("ggplot2")

NomeArquivo <- readline(prompt="Qual o nome do arquivo do Paciente? ")
Arquivo <- data.frame(read.csv(NomeArquivo, header=TRUE, sep="\t"))

Arquivo["Cobertura_SP80_3280"]<- ((Arquivo$length/Arquivo$qlen)*100)
Arquivo["Cobertura_SP78_4467"]<- ((Arquivo$length/Arquivo$slen)*100)

pident_Tam_SP80_3280 <- Arquivo[, c(5,15)]
pident_Tam_SP78_4467 <- Arquivo[, c(5,16)]

#plot(pident_Tam_SP80_3280$qlen, pident_Tam_SP80_3280$Cobertura_SP80_3280, col="red", pch = 19)
hist(pident_Tam_SP80_3280$Cobertura_SP80_3280, breaks= 70, col="blue")
hist(pident_Tam_SP78_4467$Cobertura_SP78_4467, breaks= 70, col="light blue")