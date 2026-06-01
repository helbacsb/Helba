# ==================================================
# Relação entre:
# origem x tamanho do contig x número de tRNAs
# ==================================================

library(dplyr)
library(ggplot2)

# ==================================================
# Ler arquivo
# ==================================================

dados <- read.csv(
  "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/CB49_resultado_final_OK_28maio.csv",
  stringsAsFactors = FALSE
)

# ==================================================
# Resumir por contig
# ==================================================

contigs <- dados %>%
  group_by(contig) %>%
  summarise(
    origem = first(origem),
    contig_length = first(contig_length),
    
    # número de tRNAs no contig
    n_tRNAs = max(tRNA_number, na.rm = TRUE),
    
    .groups = "drop"
  )

# ==================================================
# Ver resumo
# ==================================================

summary(contigs)

# ==================================================
# Correlação por origem
# ==================================================

contigs %>%
  group_by(origem) %>%
  summarise(
    correlacao = cor(
      contig_length,
      n_tRNAs,
      method = "spearman",
      use = "complete.obs"
    )
  )

# ==================================================
# Gráfico principal
# ==================================================

ggplot(
  contigs,
  aes(
    x = contig_length,
    y = n_tRNAs,
    color = origem
  )
) +
  geom_point(
    alpha = 0.7,
    size = 3
  ) +
#  geom_smooth(
#    method = "lm",
#    se = TRUE
#  ) +
  theme_bw(base_size = 14) +
  labs(
    x = "Contig size (bp)",
    y = "Number of tRNAs",
    color = "Classification",
    title = "Relationship between contig size and number of tRNAs"
  )