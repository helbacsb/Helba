library(tximport)# chamando a função tximport
library("DESeq2")# chamando a função DESeq2
library(ggplot2)# chamando a função ggplot2
library(readr)

setwd("D:/Helba/Salmon/SP78/SP78-X")
caminho_pasta <- "D:/Helba/Salmon/SP78/SP78-X"
arquivos <- list.files(path = caminho_pasta, pattern = "*.sf", full.names = TRUE)
tx2gene <- read.table("D:/Helba/Salmon/SP78/SP78-X/tx2gene.csv", header = TRUE)
txi <- tximport(arquivos, type = "salmon", tx2gene = tx2gene) #reading in files with read_tsv/1 2 3 4 5 6 /summarizing abundance/summarizing counts/summarizing length
sampleTable <- data.frame(condition = factor(rep(c("A", "B"), each = 3)))
rownames(sampleTable) <- colnames(txi$counts)
dds <- DESeqDataSetFromTximport(txi, sampleTable, ~condition)
dds <- DESeq(dds) #estimating size factors/using 'avgTxLength' from assays(dds), correcting for library size/estimating dispersions/gene-wise dispersion/estimates mean-dispersion relationship/final dispersion estimates/fitting model and testing
res <- results (dds)
write.csv(res, "D:/Helba/Salmon/SP80/SP78/SP78-X_DESeq.csv")


#calculando quantos contigs Diferencialmente Expressos e qual o maior e o menor valor de log2FoldChange
num_significativos <- sum(res$pvalue < 0.05, na.rm = TRUE)
cat("Número de genes com p-value < 0.05:", num_significativos, "\n")
maior_log2fc <- max(res$log2FoldChange, na.rm = TRUE)
menor_log2fc <- min(res$log2FoldChange, na.rm = TRUE)
cat("Maior valor de log2FoldChange:", maior_log2fc, "\n")
cat("Menor valor de log2FoldChange:", menor_log2fc, "\n")



resultado <- read_csv("D:/Helba/Salmon/SP78/SP78-X/SP78-X_DESeq.csv")
upregulated_genes <- resultado[which(resultado$pvalue < 0.05 & resultado$log2FoldChange >= 1), ]
downregulated_genes <- resultado[which(resultado$pvalue < 0.05 & resultado$log2FoldChange <= -1), ]
num_upregulated <- nrow(upregulated_genes)
num_downregulated <- nrow(downregulated_genes)
cat("Número de genes ativados:", num_upregulated, "\n")
cat("Número de genes reprimidos:", num_downregulated, "\n")


# Adicionar uma coluna para a direção da regulação
resultado$Regulation <- ifelse(resultado$pvalue < 0.05 & resultado$log2FoldChange >= 1, "Up", ifelse(resultado$pvalue < 0.05 & resultado$log2FoldChange <= -1, "Down", "Not Significant"))

# Criar o gráfico de vulcano
ggplot(resultado, aes(x = log2FoldChange, y = -log10(pvalue), color = Regulation)) + geom_point(alpha = 0.5) + 
  scale_color_manual(values = c("Up" = "darkgreen", "Down" = "red", "Not Significant" = "gray")) + theme_minimal() +
  labs(title = "Differentially Expressed contigs - MO3 inoculation in Susceptible Cultivar 03", x = "Log2 Fold Change", y = "-Log10 p-value")+
  theme(
    plot.title = element_text(size = 18, face = "bold"),    # Tamanho e estilo do título
    axis.title.x = element_text(size = 16),                 # Tamanho da fonte do título do eixo X
    axis.title.y = element_text(size = 16),                 # Tamanho da fonte do título do eixo Y
    axis.text.x = element_text(size = 14),                  # Tamanho da fonte dos labels do eixo X
    axis.text.y = element_text(size = 14),                  # Tamanho da fonte dos labels do eixo Y
    legend.title = element_text(size = 16),                 # Tamanho da fonte do título da legenda
    legend.text = element_text(size = 14)                   # Tamanho da fonte do texto da legenda
  )

