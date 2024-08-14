# Instalar e carregar o pacote pheatmap se ainda não estiver instalado
# install.packages("pheatmap")
library(pheatmap)
library(data.table)


setwd("D:/Helba/Salmon/SP78/para_heatmap")

# Supondo que você já tenha os arquivos carregados em uma lista
arquivos <- list.files(path = "caminho_pasta", pattern = "*.csv", full.names = TRUE)

# Inicializar uma lista para armazenar os dados filtrados de cada arquivo
dados_lista <- list()

for (arquivo in arquivos) {
  # Ler o arquivo
  dados <- read.csv(arquivo, header = TRUE)
  
  # Substituir NA por 0
  dados[is.na(dados)] <- 0
  
  # Filtrar os contigs com pvalue < 0.05 e log2FoldChange >= 1 ou <= -1
  dados_filtrados <- subset(dados, pvalue < 0.05 & (log2FoldChange >= 1 | log2FoldChange <= -1))
  
  # Armazenar o resultado em uma lista
  dados_lista[[arquivo]] <- dados_filtrados[, c("contig", "log2FoldChange")]
}

# Combinar os dados de diferentes arquivos em um único dataframe
dados_combined <- Reduce(function(x, y) merge(x, y, by = "contig", all = TRUE), dados_lista)

# Substituir NA por 0 no dataframe combinado
dados_combined[is.na(dados_combined)] <- 0

# Renomear as colunas para refletir as condições/arquivos originais
colnames(dados_combined) <- c("contig", paste0("log2FoldChange_", seq_along(arquivos)))

# Salvar o resultado em um arquivo CSV
write.csv(dados_combined, "combined_log2FoldChange.csv", row.names = FALSE)

dados <- read.csv("combined_log2FoldChange_pvalue.csv", row.names = 1)
top_genes <- head(order(apply(dados, 1, var, na.rm = TRUE), decreasing = TRUE), 10000)
dados_reduzidos <- dados[top_genes, ]


# Criar uma paleta de cores personalizada
my_palette <- colorRampPalette(c("red", "white", "darkgreen"))(50)

# Plotar o heatmap

pheatmap(dados_reduzidos,
         cluster_rows = TRUE,
         cluster_cols = TRUE,
         show_colnames = TRUE,
         show_rownames = FALSE,
         color = my_palette,
         main = "Heatmap log2FoldChange - Treatments of the Susceptible Cultivar 03")
