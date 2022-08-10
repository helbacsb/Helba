#############################################################################################################################
#                                                                                                                           #
#           script em R para correlacioar dados de variantes de um paciente com o banco de dados Gnomad,                    #
#                       aplicando um filtro para retornar apenas as variantes nao benignas                                  #
#                           Adaptado para o arquivo de saida do Ion Reporter (.tsv)                                         #
#                                                                                                                           #
#############################################################################################################################

Variantes_Filtro_BA1 <- function (file1.txt, file2.csv){
  
#setwd("C:/Users/Adenina/Documents/Helba_Cirino/Thermo_Fisher") #Indicando qual o diretorio de trabalho

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

NomePac <- readline(prompt="Qual o nome do arquivo do Paciente? ") #Imprimindo a frase e lendo o nome do arquivo do Paciente
Pac <- data.frame(read.csv(NomePac, header=TRUE, sep="\n")) #lendo o conteudo do arquivo do Paciente
Pac_Temporario <- file(NomePac, open = 'r') #Pac_Temporario recebe o conteudo do arquivo do Paciente
NomeBD <- readline(prompt="Qual o nome do arquivo da Cardiopatia? ") #Imprimindo a frase e lendo o nome do arquivo da Cardiopatia
NomeBD <- paste0("Gnomad_v2/",NomeBD) #incluindo o nome da pasta junto ao nome do arquivo
BD <- data.frame(read.csv(NomeBD, header=TRUE, sep=",")) #lendo o conteudo do arquivo da Cardiopatia
NomePac<-str_replace(NomePac, ".vcf", " ") #substitui o .vcf por espaco no nome do arquivo
NomePac<-str_extract(NomePac, "[:graph:]*")#coleta apenas o que vem antes do espaco no nome do arquivo
NomePac<-str_replace_all(NomePac, " ", "")#retira espacos do nome do arquivo, caso ainda tenha algum

NomeBD <- gsub(".csv","",NomeBD) #excluindo a extensao do nome do arquivo 
NomeBD <- gsub("Gnomad_v2/","",NomeBD)
Nome_Pac_Temporario<-paste0("Temporario_", NomePac,".txt")#Construindo o nome do arquivo temporario

#Salvando em um arquivo temporario todas as linhas que iniciam com o caracter #
while(TRUE) {
     line <- readLines(Pac_Temporario, n = 1)
     if(length(line) == 0){
       close(Pac_Temporario)
       break
     } 
     else if(!startsWith(line, "#")){
         write(line, file = Nome_Pac_Temporario, append = TRUE)
    } 
}

Pac <- data.frame(read.csv(Nome_Pac_Temporario, header=TRUE, sep="\t"))#lendo a tabela que esta no arquivo temporario
file.remove(Nome_Pac_Temporario)#deletando o arquivo temporario
Pac$Locus <- str_sub(Pac$Locus, start = 4)#excluindo os tres primeiros caracteres da coluna Locus (chr)
Pac$VID <- paste0(Pac$Locus,":",Pac$Ref,":",Pac$Observed.Allele)#preenchendo a coluna VID
Pac <-cSplit(Pac, "Genes", ",")#Divindo a coluna Genes em outros colunas. Divide onde esta a virgula

Pac <- Pac[, c(56,1:7,57:59,8:28,43:53)]#reordenando as colunas

#Na sequencia de condicionais abaixo sera executado o trecho de codigo de acordo com o Banco de Dados (ou cardiopatia) escolhido
#Sao 10 (dez) cardiopatias possiveis; O arquivo eh fragmentado (filtrado) de acordo com a o conjunto de genes que definem qual a classificacao de evidecia da variante
#Apos a classificacao as tabelas parciais sao unidas.
#Se ao final de todos os filtros nao sobrar variante(s), ou seja, o numero de linhas eh zero, aparece a mensagem: "Nenhuma variante nao benigna!"
if (NomeBD=="Aortopatias"){
	Pac1 <-Pac
	Pac1$Classificacao <- ("Evidencia definitiva")
	Pac1 <- filter (Pac1, Genes_1=="ACTA2"|Genes_1=="COL3A1"|Genes_1=="FBN1"|Genes_1=="MYH11"|Genes_1=="MYLK"|Genes_1=="SMAD3"|Genes_1=="TGFB2"|
	         Genes_1=="TGFBR1"|Genes_1=="TGFBR2"|Genes_2=="ACTA2"|Genes_2=="COL3A1"|Genes_2=="FBN1"|Genes_2=="MYH11"|Genes_2=="MYLK"|Genes_2=="SMAD3"|
	         Genes_2=="TGFB2"|Genes_2=="TGFBR1"|Genes_2=="TGFBR2"|Genes_3=="ACTA2"|Genes_3=="COL3A1"|Genes_3=="FBN1"|Genes_3=="MYH11"|Genes_3=="MYLK"|
	         Genes_3=="SMAD3"|Genes_3=="TGFB2"|Genes_3=="TGFBR1"|Genes_3=="TGFBR2")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia moderada")
	Pac2 <- filter(Pac2, Genes_1=="EFEMP2"|Genes_2=="EFEMP2"|Genes_3=="EFEMP2")
	Pac3 <-Pac
	Pac3$Classificacao <- ("Evidencia limitada")
	Pac3 <- filter (Pac3, Genes_1=="ELN"|Genes_1=="FBN2"|Genes_1=="NOTCH1"|Genes_1=="SLC2A10"|Genes_1=="SMAD4"|Genes_2=="ELN"|Genes_2=="FBN2"|
	         Genes_2=="NOTCH1"|Genes_2=="SLC2A10"|Genes_2=="SMAD4"|Genes_3=="ELN"|Genes_3=="FBN2"|Genes_3=="NOTCH1"|Genes_3=="SLC2A10"|Genes_3=="SMAD4")
	Pac4 <-Pac
	Pac4$Classificacao <- ("Evidencia incerta")
	Pac4 <- filter(Pac4,Genes_1=="HCN4"|Genes_1=="TGFB3"|Genes_2=="HCN4"|Genes_2=="TGFB3"|Genes_3=="HCN4"|Genes_3=="TGFB3")
	Pac <- rbind.fill(Pac1, Pac2, Pac3, Pac4)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	  }
}
if (NomeBD=="ARVC"){
	Pac1 <-Pac
	Pac1$Classificacao <- ("Evidencia definitiva/forte")
	Pac1 <- filter (Pac1, Genes_1=="DSC2"|Genes_1== "DSG2"|Genes_1=="DSP"|Genes_1=="JUP"|Genes_1=="PKP2"|Genes_1=="TMEM43"|Genes_2=="DSC2"|
	         Genes_2== "DSG2"|Genes_2=="DSP"|Genes_2=="JUP"|Genes_2=="PKP2"|Genes_2=="TMEM43"|Genes_3=="DSC2"|Genes_3== "DSG2"|Genes_3=="DSP"|
	         Genes_3=="JUP"|Genes_3=="PKP2"|Genes_3=="TMEM43")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia moderada")
	Pac2 <- filter(Pac2, Genes_1=="DES"|Genes_1=="LMNA"|Genes_1=="PLN"|Genes_1=="RYR2"|Genes_1=="SCN5A"|Genes_1=="TTN"|Genes_2=="DES"|Genes_2=="LMNA"|
	         Genes_2=="PLN"|Genes_2=="RYR2"|Genes_2=="SCN5A"|Genes_2=="TTN"|Genes_3=="DES"|Genes_3=="LMNA"|Genes_3=="PLN"|Genes_3=="RYR2"|Genes_3=="SCN5A"|Genes_3=="TTN")
	Pac3 <-Pac
	Pac3$Classificacao <- ("Evidencia limitada")
	Pac3 <- filter (Pac3, Genes_1=="TGFB3"|Genes_2=="TGFB3"|Genes_3=="TGFB3")
	Pac <- rbind.fill(Pac1, Pac2, Pac3)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="Brugada"){
	Pac$Classificacao <- ("Evidencia definitiva")
	Pac <- filter (Pac, Genes_1== "SCN5A"|Genes_2== "SCN5A"|Genes_3== "SCN5A")
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="CPVT"){
	Pac1 <-Pac
	Pac1$Classificacao <- ("Evidencia definitiva/forte")
	Pac1 <- filter (Pac1, Genes_1=="CASQ2"|Genes_1== "RYR2"|Genes_2=="CASQ2"|Genes_2== "RYR2"|Genes_3=="CASQ2"|Genes_3== "RYR2")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia moderada")
	Pac2 <- filter(Pac2, Genes_1=="CALM1"|Genes_1=="TRDN"|Genes_2=="CALM1"|Genes_2=="TRDN"|Genes_3=="CALM1"|Genes_3=="TRDN")
	Pac3 <-Pac
	Pac3$Classificacao <- ("Evidencia moderada-Fenocopia")
	Pac3 <- filter(Pac3, Genes_1=="ANK2"|Genes_1=="KCNE1"|Genes_1=="KCNJ2"|Genes_2=="ANK2"|Genes_2=="KCNE1"|Genes_2=="KCNJ2"|Genes_3=="ANK2"|Genes_3=="KCNE1"|Genes_3=="KCNJ2")
	Pac <- rbind.fill(Pac1, Pac2, Pac3)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="DCM"){
	Pac1 <- Pac
	Pac1$Classificacao <- ("Evidencia definitiva/forte")
	Pac1 <- filter (Pac1, Genes_1=="DES"|Genes_1=="DMD"|Genes_1=="LMNA"|Genes_1=="MYH7"|Genes_1=="RBM20"|Genes_1=="SCN5A"|Genes_1=="TAZ"|Genes_1=="TNNT2"|Genes_1=="TTN3"|Genes_2=="DES"|
	           Genes_2=="DMD"|Genes_2=="LMNA"|Genes_2=="MYH7"|Genes_2=="RBM20"|Genes_2=="SCN5A"|Genes_2=="TAZ"|Genes_2=="TNNT2"|Genes_2=="TTN3"|Genes_3=="DES"|Genes_3=="DMD"|
	           Genes_3=="LMNA"|Genes_3=="MYH7"|Genes_3=="RBM20"|Genes_3=="SCN5A"|Genes_3=="TAZ"|Genes_3=="TNNT2"|Genes_3=="TTN3")
	Pac2 <- Pac
	Pac2$Classificacao <- ("Evidencia moderada")
	Pac2 <- filter(Pac2, Genes_1=="BAG3"|Genes_1=="PLN"|Genes_1=="TPM1"|Genes_2=="BAG3"|Genes_2=="PLN"|Genes_2=="TPM1"|Genes_3=="BAG3"|Genes_3=="PLN"|Genes_3=="TPM1")
	Pac3 <- Pac
	Pac3$Classificacao <- ("Evidencia limitada")
	Pac3 <- filter (Pac3, Genes_1=="ABCC9"|Genes_1=="ACTC1"|Genes_1=="ACTN2"|Genes_1=="ANKRD1"|Genes_1=="CRYAB"|Genes_1=="CSRP3"|Genes_1=="DSC2"|Genes_1=="DSG2"|
	         Genes_1=="DSP"|Genes_1=="LDB3"|Genes_1=="MYH6"|Genes_1=="MYPN"|Genes_1=="NEXN"|Genes_1=="SGCB"|Genes_1=="SGCD"|Genes_1=="TCAP"|Genes_1=="TNNC1"|
	         Genes_1=="TNNI3"|Genes_1=="VCL"|Genes_2=="ABCC9"|Genes_2=="ACTC1"|Genes_2=="ACTN2"|Genes_2=="ANKRD1"|Genes_2=="CRYAB"|Genes_2=="CSRP3"|Genes_2=="DSC2"|
	         Genes_2=="DSG2"|Genes_2=="DSP"|Genes_2=="LDB3"|Genes_2=="MYH6"|Genes_2=="MYPN"|Genes_2=="NEXN"|Genes_2=="SGCB"|Genes_2=="SGCD"|Genes_2=="TCAP"|
	         Genes_2=="TNNC1"|Genes_2=="TNNI3"|Genes_2=="VCL"|Genes_3=="ABCC9"|Genes_3=="ACTC1"|Genes_3=="ACTN2"|Genes_3=="ANKRD1"|Genes_3=="CRYAB"|Genes_3=="CSRP3"|
	         Genes_3=="DSC2"|Genes_3=="DSG2"|Genes_3=="DSP"|Genes_3=="LDB3"|Genes_3=="MYH6"|Genes_3=="MYPN"|Genes_3=="NEXN"|Genes_3=="SGCB"|Genes_3=="SGCD"|
	         Genes_3=="TCAP"|Genes_3=="TNNC1"|Genes_3=="TNNI3"|Genes_3=="VCL")
	Pac4 <- Pac
	Pac4$Classificacao <- ("GENE SINDROMICO")
	Pac4 <- filter(Pac4, Genes_1=="ALMS1"|Genes_1=="DNAJC19"|Genes_1=="DOLK"|Genes_1=="HFE"|Genes_2=="ALMS1"|Genes_2=="DNAJC19"|Genes_2=="DOLK"|
	         Genes_2=="HFE"|Genes_3=="ALMS1"|Genes_3=="DNAJC19"|Genes_3=="DOLK"|Genes_3=="HFE")
	Pac <- rbind.fill(Pac1, Pac2, Pac3, Pac4)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="HCM"){
	Pac1 <- Pac
	Pac1$Classificacao <- ("Evidencia definitiva")
	Pac1 <- filter (Pac1, Genes_1=="ACTC1"|Genes_1=="MYBPC3"|Genes_1=="MYH7"|Genes_1=="MYL2"|Genes_1=="MYL3"|Genes_1=="TNNI3"|Genes_1=="TNNT2"|Genes_1=="TPM1"|Genes_2=="ACTC1"|
	         Genes_2=="MYBPC3"|Genes_2=="MYH7"|Genes_2=="MYL2"|Genes_2=="MYL3"|Genes_2=="TNNI3"|Genes_2=="TNNT2"|Genes_2=="TPM1"|Genes_3=="ACTC1"|Genes_3=="MYBPC3"|
	         Genes_3=="MYH7"|Genes_3=="MYL2"|Genes_3=="MYL3"|Genes_3=="TNNI3"|Genes_3=="TNNT2"|Genes_3=="TPM1")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia definitiva - Fenocopia")
	Pac2 <- filter (Pac2,Genes_1=="CACNA1C"|Genes_1=="DES"|Genes_1=="FHL1"|Genes_1=="GLA"|Genes_1=="LAMP2"|Genes_1=="PLN"|Genes_1=="PRKAG2"|Genes_1=="PTPN11"|Genes_1=="RAF1"|
	           Genes_1=="TTR"|Genes_2=="CACNA1C"|Genes_2=="DES"|Genes_2=="FHL1"|Genes_2=="GLA"|Genes_2=="LAMP2"|Genes_2=="PLN"|Genes_2=="PRKAG2"|Genes_2=="PTPN11"|
	           Genes_2=="RAF1"|Genes_2=="TTR"|Genes_3=="CACNA1C"|Genes_3=="DES"|Genes_3=="FHL1"|Genes_3=="GLA"|Genes_3=="LAMP2"|Genes_3=="PLN"|Genes_3=="PRKAG2"|Genes_3=="PTPN11"|Genes_3=="RAF1"|Genes_3=="TTR")
	Pac3 <-Pac
	Pac3$Classificacao <- ("Evidencia moderada")
	Pac3 <- filter(Pac3, Genes_1=="CSRP3"|Genes_1=="JPH2"|Genes_1=="TNNC1"|Genes_2=="CSRP3"|Genes_2=="JPH2"|Genes_2=="TNNC1"|Genes_3=="CSRP3"|Genes_3=="JPH2"|Genes_3=="TNNC1")
	Pac4<-Pac
	Pac4$Classificacao <- ("Evidencia moderada-Fenocopia")
	Pac4 <- filter(Pac4,Genes_1=="ACTN2"|Genes_2=="ACTN2"|Genes_3=="ACTN2")
	Pac5 <- Pac
	Pac5$Classificacao <- ("Evidencia limitada")
	Pac5 <- filter (Pac5, Genes_1=="ANKRD1"|Genes_1=="CALR3"|Genes_1=="KLF10"|Genes_1=="MYH6"|Genes_1=="MYLK2"|Genes_1=="MYOZ2"|Genes_1=="MYPN"|Genes_1=="NEXN"|Genes_1=="PDLIM3"|
	         Genes_1=="RYR2"|Genes_1=="TCAP"|Genes_1=="TRIM63"|Genes_1=="TTN"|Genes_1=="VCL"|Genes_2=="ANKRD1"|Genes_2=="CALR3"|Genes_2=="KLF10"|Genes_2=="MYH6"|Genes_2=="MYLK2"|
	         Genes_2=="MYOZ2"|Genes_2=="MYPN"|Genes_2=="NEXN"|Genes_2=="PDLIM3"|Genes_2=="RYR2"|Genes_2=="TCAP"|Genes_2=="TRIM63"|Genes_2=="TTN"|Genes_2=="VCL"|Genes_3=="ANKRD1"|
	         Genes_3=="CALR3"|Genes_3=="KLF10"|Genes_3=="MYH6"|Genes_3=="MYLK2"|Genes_3=="MYOZ2"|Genes_3=="MYPN"|Genes_3=="NEXN"|Genes_3=="PDLIM3"|Genes_3=="RYR2"|Genes_3=="TCAP"|
	         Genes_3=="TRIM63"|Genes_3=="TTN"|Genes_3=="VCL")
	Pac6 <- Pac
	Pac6$Classificacao <- ("GENE SINDROMICO - Evidencia definitiva")
	Pac6 <- filter(Pac6, Genes_1=="ABCC9"|Genes_1=="BAG3"|Genes_1=="BRAF"|Genes_1=="CAV3"|Genes_1=="CRYAB"|Genes_1=="FXN"|Genes_1=="GAA"|Genes_1=="HRAS"|Genes_1=="KRAS"|
	         Genes_1=="MAP2K1"|Genes_1=="MAP2K2"|Genes_1=="MYO6"|Genes_1=="NRAS"|Genes_1=="SHOC2"|Genes_1=="SLC25A4"|Genes_1=="SOS1"|Genes_1=="TAZ"|Genes_2=="ABCC9"|
	         Genes_2=="BAG3"|Genes_2=="BRAF"|Genes_2=="CAV3"|Genes_2=="CRYAB"|Genes_2=="FXN"|Genes_2=="GAA"|Genes_2=="HRAS"|Genes_2=="KRAS"|Genes_2=="MAP2K1"|
	         Genes_2=="MAP2K2"|Genes_2=="MYO6"|Genes_2=="NRAS"|Genes_2=="SHOC2"|Genes_2=="SLC25A4"|Genes_2=="SOS1"|Genes_2=="TAZ"|Genes_3=="ABCC9"|
	         Genes_3=="BAG3"|Genes_3=="BRAF"|Genes_3=="CAV3"|Genes_3=="CRYAB"|Genes_3=="FXN"|Genes_3=="GAA"|Genes_3=="HRAS"|Genes_3=="KRAS"|Genes_3=="MAP2K1"|
	         Genes_3=="MAP2K2"|Genes_3=="MYO6"|Genes_3=="NRAS"|Genes_3=="SHOC2"|Genes_3=="SLC25A4"|Genes_3=="SOS1"|Genes_3=="TAZ")
	Pac7 <-Pac
	Pac7$Classificacao <- ("GENE SINDROMICO - Evidencia forte")
	Pac7 <- filter(Pac7, Genes_1=="COX15"|Genes_2=="COX15"|Genes_3=="COX15")
	Pac8 <-Pac
	Pac8$Classificacao <- ("GENE SINDROMICO - Evidencia moderada")
	Pac8 <- filter(Pac8, Genes_1=="LDB3"|Genes_2=="LDB3"|Genes_3=="LDB3")
	Pac <- rbind.fill(Pac1, Pac2, Pac3, Pac4, Pac5, Pac6, Pac7, Pac8)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="PCCD"){
	Pac1 <-Pac
	Pac1$Classificacao <- ("Evidencia definitiva")
	Pac1 <- filter (Pac1, Genes_1=="DES"|Genes_1=="EMD"|Genes_1=="LMNA"|Genes_1=="NKX2-5"|Genes_1=="PRKAG2"|Genes_1=="SCN5A"|Genes_1=="TRPM4"|Genes_2=="DES"|
	         Genes_2=="EMD"|Genes_2=="LMNA"|Genes_2=="NKX2-5"|Genes_2=="PRKAG2"|Genes_2=="SCN5A"|Genes_2=="TRPM4"|Genes_3=="DES"|Genes_3=="EMD"|
	         Genes_3=="LMNA"|Genes_3=="NKX2-5"|Genes_3=="PRKAG2"|Genes_3=="SCN5A"|Genes_3=="TRPM4")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia limitada")
	Pac2 <- filter(Pac2, Genes_1=="SCN1B"|Genes_2=="SCN1B"|Genes_3=="SCN1B")
	Pac <- rbind.fill(Pac1, Pac2)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="Restritiva"){
	Pac1 <- Pac
	Pac1$Classificacao <- ("Evidencia forte")
	Pac1 <- filter (Pac1, Genes_1=="DES"|Genes_1=="HFE"|Genes_1=="MYH7"|Genes_1=="TNNI3"|Genes_1=="TTR"|Genes_2=="DES"|Genes_2=="HFE"|Genes_2=="MYH7"|
	         Genes_2=="TNNI3"|Genes_2=="TTR"|Genes_3=="DES"|Genes_3=="HFE"|Genes_3=="MYH7"|Genes_3=="TNNI3"|Genes_3=="TTR")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia limitada")
	Pac2 <- filter(Pac2, Genes_1=="ACTC1"|Genes_1=="ACTN2"|Genes_1=="BAG3"|Genes_1=="JUP"|Genes_1=="LAMP2"|Genes_1=="LMNA"|Genes_1=="MYBPC3"|Genes_1=="MYPN"|
	         Genes_1=="TCAP"|Genes_1=="TNNT2"|Genes_1=="TPM1"|Genes_2=="ACTC1"|Genes_2=="ACTN2"|Genes_2=="BAG3"|Genes_2=="JUP"|Genes_2=="LAMP2"|
	         Genes_2=="LMNA"|Genes_2=="MYBPC3"|Genes_2=="MYPN"|Genes_2=="TCAP"|Genes_2=="TNNT2"|Genes_2=="TPM1"|Genes_3=="ACTC1"|Genes_3=="ACTN2"|
	         Genes_3=="BAG3"|Genes_3=="JUP"|Genes_3=="LAMP2"|Genes_3=="LMNA"|Genes_3=="MYBPC3"|Genes_3=="MYPN"|Genes_3=="TCAP"|Genes_3=="TNNT2"|Genes_3=="TPM1")
	Pac <- rbind.fill(Pac1, Pac2)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="SQTL"){
	Pac1 <-Pac
	Pac1$Classificacao <- ("Evidencia definitiva/forte")
	Pac1 <- filter (Pac1, Genes_1=="KCNH2"|Genes_1=="KCNQ1"|Genes_1=="SCN5A"|Genes_2=="KCNH2"|Genes_2=="KCNQ1"|Genes_2=="SCN5A"|Genes_3=="KCNH2"|Genes_3=="KCNQ1"|Genes_3=="SCN5A")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia moderada")
	Pac2 <- filter(Pac2, Genes_1=="AKAP9"|Genes_1=="ANK2"|Genes_1=="CACNA1C"|Genes_1=="CALM1"|Genes_1=="CAV3"|Genes_1=="KCNE1"|Genes_1=="KCNE2"|Genes_1=="KCNJ2"|Genes_1=="KCNJ5"|
	         Genes_1=="SCN4B"|Genes_1=="SNTA1"|Genes_2=="AKAP9"|Genes_2=="ANK2"|Genes_2=="CACNA1C"|Genes_2=="CALM1"|Genes_2=="CAV3"|Genes_2=="KCNE1"|Genes_2=="KCNE2"|
	         Genes_2=="KCNJ2"|Genes_2=="KCNJ5"|Genes_2=="SCN4B"|Genes_2=="SNTA1"|Genes_3=="AKAP9"|Genes_3=="ANK2"|Genes_3=="CACNA1C"|Genes_3=="CALM1"|Genes_3=="CAV3"|
	         Genes_3=="KCNE1"|Genes_3=="KCNE2"|Genes_3=="KCNJ2"|Genes_3=="KCNJ5"|Genes_3=="SCN4B"|Genes_3=="SNTA1")
	Pac3 <-Pac
	Pac3$Classificacao <- ("Evidencia limitada")
	Pac3 <- filter (Pac3, Genes_1=="RYR2"|Genes_1=="SCN1B"|Genes_1=="TRDN"|Genes_1=="TRPM4"|Genes_2=="RYR2"|Genes_2=="SCN1B"|Genes_2=="TRDN"|Genes_2=="TRPM4"|Genes_3=="RYR2"|Genes_3=="SCN1B"|Genes_3=="TRDN"|Genes_3=="TRPM4")
	Pac <- rbind.fill(Pac1, Pac2, Pac3)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}
if (NomeBD=="SQTS"){
	Pac1 <-Pac
	Pac1$Classificacao <- ("Evidencia definitiva/forte")
	Pac1 <- filter (Pac1, Genes_1=="KCNH2"|Genes_1=="KCNJ2"|Genes_1=="KCNQ1"|Genes_2=="KCNH2"|Genes_2=="KCNJ2"|Genes_2=="KCNQ1"|Genes_3=="KCNH2"|Genes_3=="KCNJ2"|Genes_3=="KCNQ1")
	Pac2 <-Pac
	Pac2$Classificacao <- ("Evidencia moderada")
	Pac2 <- filter(Pac2, Genes_1=="CACNA1C"|Genes_1=="CACNA2D1"|Genes_1=="CACNB2"|Genes_2=="CACNA1C"|Genes_2=="CACNA2D1"|Genes_2=="CACNB2"|Genes_3=="CACNA1C"|Genes_3=="CACNA2D1"|Genes_3=="CACNB2")
	Pac <- rbind.fill(Pac1, Pac2)
	Num_linhas_Pac <- nrow(Pac)
	if (Num_linhas_Pac==0){
	  print("Nenhuma variante nao benigna!")
	}
}

if (Num_linhas_Pac!=0) {
Pac <- Pac[, c(1:6,44,7:43)] #reordenando as colunas da tabela

BD <-rename.vars(BD, c("Filters...exomes","Filters...genomes","Protein.Consequence","Transcript.Consequence","Allele.Count", "Allele.Number", "Allele.Frequency","Homozygote.Count","Hemizygote.Count","Allele.Count.African",
"Allele.Number.African","Homozygote.Count.African","Hemizygote.Count.African","Allele.Count.Latino","Allele.Number.Latino","Homozygote.Count.Latino","Hemizygote.Count.Latino","Allele.Count.Ashkenazi.Jewish",
"Allele.Number.Ashkenazi.Jewish","Homozygote.Count.Ashkenazi.Jewish","Hemizygote.Count.Ashkenazi.Jewish","Allele.Count.East.Asian","Allele.Number.East.Asian","Homozygote.Count.East.Asian","Hemizygote.Count.East.Asian",
"Allele.Count.European..Finnish.","Allele.Number.European..Finnish.","Homozygote.Count.European..Finnish.","Hemizygote.Count.European..Finnish.","Allele.Count.European..non.Finnish.","Allele.Number.European..non.Finnish.",
"Homozygote.Count.European..non.Finnish.","Hemizygote.Count.European..non.Finnish.","Allele.Count.Other","Allele.Number.Other","Homozygote.Count.Other","Hemizygote.Count.Other","Allele.Count.South.Asian",
"Allele.Number.South.Asian","Homozygote.Count.South.Asian","Hemizygote.Count.South.Asian"), c("Filters_exomes","Filters_genomes","Protein_Consequence","Transcript_Consequence","Allele_Count", "Allele_Number",
"Allele_Frequency","Homozygote_Count","Hemizygote_Count","Allele_Count_African","Allele_Number_African","Homozygote_Count_African","Hemizygote_Count_African","Allele_Count_Latino","Allele_Number_Latino",
"Homozygote_Count_Latino","Hemizygote_Count_Latino","Allele_Count_Ashkenazi_Jewish","Allele_Number_Ashkenazi_Jewish","Homozygote_Count_Ashkenazi_Jewish","Hemizygote_Count_Ashkenazi_Jewish","Allele_Count_East_Asian",
"Allele_Number_East_Asian","Homozygote_Count_East_Asian","Hemizygote_Count_East_Asian","Allele_Count_European_Finnish","Allele_Number_European_Finnish","Homozygote_Count_European_Finnish","Hemizygote_Count_European_Finnish",
"Allele_Count_European_non_Finnish","Allele_Number_European_non_Finnish","Homozygote_Count_European_non_Finnish","Hemizygote_Count_European_non_Finnish","Allele_Count_Other","Allele_Number_Other","Homozygote_Count_Other",
"Hemizygote_Count_Other","Allele_Count_South_Asian","Allele_Number_South_Asian","Homozygote_Count_South_Asian","Hemizygote_Count_South_Asian"),info=FALSE) #Renomeando os nomes de algumas colunas

BD["Allele_Frequency_African"]<- (BD$Allele_Count_African / BD$Allele_Number_African) #Adicionando e preenchendo a coluna Allele_Frequency_African
BD["Allele_Frequency_Latino"]<- (BD$Allele_Count_Latino / BD$Allele_Number_Latino)#Adicionando e preenchendo a coluna Allele_Frequency_Latino
BD["Allele_Frequency_East_Asian"]<- (BD$Allele_Count_East_Asian / BD$Allele_Number_East_Asian)#Adicionando e preenchendo a coluna Allele_Frequency_East_Asian
BD["Allele_Frequency_European_non_Finnish"]<- (BD$Allele_Count_European_non_Finnish / BD$Allele_Number_European_non_Finnish)#Adicionando e preenchendo a coluna Allele_Frequency_European_non_Finnish
BD["Allele_Frequency_South_Asian"]<- (BD$Allele_Count_South_Asian / BD$Allele_Number_South_Asian)#Adicionando e preenchendo a coluna Allele_Frequency_South_Asian

BD["VID"]<- paste0(BD$Chromosome,":",BD$Position,":",BD$Reference,":",BD$Alternate) #Adicionando e preenchendo a coluna VID
BD <- BD[, c(56,1:55)]#reordenando as colunas

Result <- left_join(Pac,BD,by="VID",info=FALSE)#Variavel Result recebe apenas as variantes do Paciente que estao presentes no Banco de Dados, de acordo com o numero da posicao. Retornando as colunas da tabela do Paciente e as colunas do Banco de Dados
OnlyPac <- anti_join(Pac,BD,by="VID",info=FALSE)#Variavel OnlyPac recebe apenas as variantes do Paciente que nao estao presentes no Banco de Dados, de acordo com o numero da posicao. Retornando apenas as colunas da tabela do Paciente.
OnlyPacNA <- left_join(OnlyPac,BD,by="VID",info=FALSE) #Variavel OnlyPacNA recebe apenas as variantes do Paciente que nao estao presentes no Banco de Dados, de acordo com o numero da posicao. Retornando as colunas da tabela do Paciente e as colunas do BD preenchidas com NA

expr <- data.table(Result) #variavel expr recebe o conteudo da tabela Result em forma de data frame.

#Variavel BA1 recebe as variantes de acordo com os novos criterios BA1
Filtro_BA1<-expr[(((Allele_Frequency_African < 0.05 & Allele_Count_African >2000)| (Allele_Frequency_Latino < 0.05 & Allele_Count_Latino>2000)| (Allele_Frequency_East_Asian < 0.05 & Allele_Count_East_Asian>2000)|
(Allele_Frequency_European_non_Finnish < 0.05 & Allele_Count_European_non_Finnish>2000)| (Allele_Frequency_South_Asian < 0.05 & Allele_Count_South_Asian>2000))|
((Allele_Frequency_African > 0.05 & Allele_Count_African <2000)| (Allele_Frequency_Latino > 0.05 & Allele_Count_Latino<2000)| (Allele_Frequency_East_Asian > 0.05 & Allele_Count_East_Asian<2000)|
(Allele_Frequency_European_non_Finnish > 0.05 & Allele_Count_European_non_Finnish<2000)| (Allele_Frequency_South_Asian > 0.05 & Allele_Count_South_Asian<2000)))]

Total <- rbind.fill(OnlyPacNA, Filtro_BA1)#variavel Total recebe o dataframe OnlyPacNA junto com Filtro_BA1
Total$Type <- NULL #deletando a coluna Type
Total$Subtype <- NULL #deletando a coluna Subtype
Total$No.Call.Reason <- NULL #deletando a coluna No.Call.Reason

Num_linhas_Total <- nrow (Total) #contando linhas
now<-format(Sys.time(), "%Y_%m_%d_%X")#Pegando a data e a hora
now <- str_replace_all(now, ":", "_")#trocando : por _
NameFile<-paste0(NomePac,"/",NomePac,"_",NomeBD,"_", now,".csv")#Montando o nome do arquivo
NameFile_VCF<-paste0(NomePac,"/",NomePac,"_",NomeBD,"_", now,".vcf")#Construindo o nome do arquivo vcf

#criando uma pasta com o mesmo nome do arquivo do Paciente
if (Num_linhas_Total!=0){
  if (dir.exists(NomePac)==FALSE){
    dir.create(NomePac)
  }
  write.table(Total, file = NameFile,row.names=FALSE, sep="\t")#salvando a variavel Total em um arquivo)
  
Nome_VCF<-paste0(NomePac,".vcf") #acrescentando a extensao .vcf no nome do arquivo
Arquivo_vcf <- file(Nome_VCF, open = 'r') #abrindo o arquivo .vcf
while(TRUE) { #enquanto o arquivo tiver linhas
     line <- readLines(Arquivo_vcf, n = 1) # lendo as linhas do arquivo
     if(length(line) == 0){
       close(Arquivo_vcf)
       break # se nao tiver mais linhas, conclui essa etapa
     }
     else if(startsWith(line, "##")){ # se a linha comeca com ##
         write(line, file = NameFile_VCF, append = TRUE) #salva as linhas no arquivo
     } 
}

Arquivo_vcf <- file(Nome_VCF, open = 'r') #abrindo o arquivo .vcf
while(TRUE){
     line <- readLines(Arquivo_vcf, n = 1)
     if(length(line) == 0) {
       close(Arquivo_vcf)
       break # se nao tiver mais linhas, conclui essa etapa
     }
     else if(startsWith(line, "#C")){ # se a linha comeca com #C
         write(line, file = NameFile_VCF, append = TRUE) #salva a linha no arquivo
     } 
}

Total <-cSplit(Total, "Locus", ":") #dividindo a coluna Locus em duas colunas
Total$Locus_2<-as.character(Total$Locus_2) #covertendo a coluna Locus_2 para o tipo caracter
Total$Ref<-as.character(Total$Ref) #covertendo a coluna Ref para o tipo caracter
Total$Observed.Allele<-as.character(Total$Observed.Allele) #covertendo a coluna Observed.Allele para o tipo caracter
Total$Locus_1 <- paste0("chr",Total$Locus_1) #adicionando chr ao campo Locus_1

Arquivo_vcf <- file(Nome_VCF, open = 'r') #abrindo o arquivo .vcf
while(TRUE){
  line <- readLines(Arquivo_vcf, n = 1)
  if(length(line) == 0) {
    close(Arquivo_vcf)
    break # se nao tiver mais linhas, conclui essa etapa
  }
  for(i in 1:Num_linhas_Total){  #salva apenas as linhas que se encaixam nos requisitos, que possui o numero da posicao da variante na linha
    if((!startsWith(line, "#"))&(str_detect(line, pattern = Total$Locus_1[i]))&(str_detect(line, pattern = Total$Locus_2[i]))&(str_detect(line, pattern = Total$Ref[i]))&(str_detect(line,pattern = Total$Observed.Allele[i]))){
      write(line, file = NameFile_VCF, append = TRUE)
    } 
  }
}

}

else {
  print("Nenhuma variante nao benigna de acordo com o filtro!")
}
} else {
  print("Nenhuma variante nao benigna!")
}
options(warn=-1) # omitindo as mensagens de alertas (Warning messages)
}