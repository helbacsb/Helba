#install.packages("pheatmap")
library(pheatmap)

dados <- read.csv("C:/Users/CLQ/Desktop/Graficos ET DE/ET_DE_FC_zeros_FDR.csv", sep = "\t", header = TRUE, row.names = 1)# leitura dos dados pelo arquivo csv, sinalizando que há cabeçalhos, primeira coluna com nomes das linhas e o separador tab.
cores <- colorRampPalette(c("yellow","white","blue"))(21) #gerar 21 escalas de cores

pheatmap(dados, color = cores, display_numbers = matrix(ifelse(dados == 0, "*", ""), nrow(dados))) #imprimir "*" nos valores zeros
pheatmap(dados, color = cores, clustering_distance_rows = "correlation") # clusterizar pelas linhas também
pheatmap(dados, color = cores, display_numbers = matrix(ifelse(dados == 0, "*", ""), nrow(dados)), clustering_distance_rows = "correlation")#imprimir * nos valores zeros e clusterizar por linhas