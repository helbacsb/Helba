# ==================================================
# Relação entre:
# origem x tamanho do contig x número de tRNAs
# ==================================================

library(dplyr)
library(ggplot2)
library(svglite)

# ==================================================
# Ler arquivo
# ==================================================

dados <- read.csv(
  "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/SP80-X+G_resultado_final_OK_31maio.csv",
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
    n_tRNAs = max(tRNA_number, na.rm = TRUE),
    .groups = "drop"
  )

# ==================================================
# Deslocamento vertical por origem
# ==================================================

contigs <- contigs %>%
  mutate(
    n_tRNAs_plot = case_when(
      origem == "COG-EggNOG" ~ n_tRNAs + 0.15,
      origem == "non-coding" ~ n_tRNAs - 0.15,
      TRUE ~ n_tRNAs
    )
  )

# ==================================================
# Salvar SVG
# ==================================================

svglite(
  "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/SP80-X+G_all_contigs.svg",
  width = 12,
  height = 8
)

max_trna <- max(contigs$n_tRNAs, na.rm = TRUE)

max_x <- ceiling(
  max(contigs$contig_length, na.rm = TRUE) / 5000
) * 5000

faixas <- data.frame(
  ymin = seq(0.5, max_trna - 0.5, by = 1),
  ymax = seq(1.5, max_trna + 0.5, by = 1),
  fill = rep(
    c("grey97", "grey92"),
    length.out = max_trna
  )
)
# ==================================================
# Gráfico
# ==================================================

ggplot(
  contigs,
  aes(
    x = contig_length,
    y = n_tRNAs_plot,
    color = origem
  )
) +
  
# ------------------------------------------
# Faixas horizontais
# ------------------------------------------

geom_rect(
  data = faixas,
  aes(
    xmin = -Inf,
    xmax = Inf,
    ymin = ymin,
    ymax = ymax
  ),
  inherit.aes = FALSE,
  fill = faixas$fill
) +
# ------------------------------------------
# Pontos
# ------------------------------------------

geom_jitter(
  width = 0,
  height = 0.05,
  alpha = 0.75,
  size = 3
) +
  
# ------------------------------------------
# Cores
# ------------------------------------------

scale_color_manual(
  values = c(
    "COG-EggNOG" = "#1F77B4",
    "non-coding" = "#D62728"
  )
) +
  
# ------------------------------------------
# Eixo Y
# ------------------------------------------

scale_y_continuous(
  breaks = 1:max_trna,
  limits = c(0.5, max_trna + 0.5)
) +
  
  scale_x_continuous(
    limits = c(0, max_x),
    breaks = seq(0, max_x, by = 5000)
  ) +
  
# ------------------------------------------
# Layout
# ------------------------------------------

theme_bw(base_size = 16) +
  
  labs(
    x = "Contig size (bp)",
    y = "Number of tRNAs",
    color = "Source",
    title = "All tRNA contigs - SP80-X+G"
  ) +
  
  theme(
    
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    
    plot.title = element_text(
      hjust = 0.5,
      face = "bold",
      size = 18
    ),
    
    axis.title = element_text(
      size = 15
    ),
    
    axis.text = element_text(
      size = 13
    ),
    
    legend.title = element_text(
      size = 14
    ),
    
    legend.text = element_text(
      size = 13
    ),
    
    plot.margin = margin(
      15,
      20,
      15,
      15
    )
  )

dev.off()

############################################################################

# ==================================================
# Relação entre:
# origem x tamanho do contig x número de tRNAs
# Apenas contigs diferencialmente expressos
# ==================================================
# Classificar expressão diferencial
# ==================================================

dados <- dados %>%
  mutate(
    expressao = case_when(
      
      !is.na(pvalue) &
        pvalue < 0.05 &
        log2FoldChange >= 2 ~ "Upregulated",
      
      !is.na(pvalue) &
        pvalue < 0.05 &
        log2FoldChange <= -2 ~ "Downregulated",
      
      TRUE ~ "Not significant"
    )
  )

# ==================================================
# Resumir por contig
# ==================================================

contigs <- dados %>%
  group_by(contig) %>%
  summarise(
    origem = first(origem),
    
    contig_length = first(contig_length),
    
    n_tRNAs = max(
      tRNA_number,
      na.rm = TRUE
    ),
    
    expressao = first(expressao),
    
    .groups = "drop"
  )

# ==================================================
# Filtrar apenas regulados
# ==================================================

contigs_regulados <- contigs %>%
  filter(
    expressao %in% c(
      "Upregulated",
      "Downregulated"
    )
  )

# ==================================================
# Deslocamento vertical
# ==================================================

contigs_regulados <- contigs_regulados %>%
  mutate(
    n_tRNAs_plot = case_when(
      origem == "COG-EggNOG" ~ n_tRNAs + 0.15,
      origem == "non-coding" ~ n_tRNAs - 0.15,
      TRUE ~ n_tRNAs
    )
  )

# ==================================================
# Verificar quantidade de contigs
# ==================================================

table(contigs_regulados$expressao)

table(contigs_regulados$origem)

# ==================================================
# Salvar SVG
# ==================================================

svglite(
  "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/SP80-X+G_regulated_contigs.svg",
  width = 12,
  height = 8
)

# ==================================================
# Gráfico
# ==================================================

ggplot(
  contigs_regulados,
  aes(
    x = contig_length,
    y = n_tRNAs_plot,
    color = origem,
    shape = expressao
  )
) +
  
# ------------------------------------------
# Faixas horizontais
# ------------------------------------------

geom_rect(
  data = faixas,
  aes(
    xmin = -Inf,
    xmax = Inf,
    ymin = ymin,
    ymax = ymax
  ),
  inherit.aes = FALSE,
  fill = faixas$fill
) +
# ------------------------------------------
# Pontos
# ------------------------------------------

geom_jitter(
  width = 0,
  height = 0.05,
  alpha = 0.80,
  size = 3
) +
  
# ------------------------------------------
# Cores
# ------------------------------------------

scale_color_manual(
  values = c(
    "COG-EggNOG" = "#1F77B4",
    "non-coding" = "#D62728"
  )
) +
  
  # ------------------------------------------
# Formas
# ------------------------------------------

scale_shape_manual(
  values = c(
    "Upregulated" = 16,
    "Downregulated" = 17
  )
) +
  
  # ------------------------------------------
# Eixo Y
# ------------------------------------------

scale_y_continuous(
  breaks = 1:max_trna,
  limits = c(0.5, max_trna + 0.5)
) +
  
  scale_x_continuous(
    limits = c(0, max_x),
    breaks = seq(0, max_x, by = 5000)
  ) +
  
  # ------------------------------------------
# Layout
# ------------------------------------------

theme_bw(base_size = 16) +
  
  labs(
    x = "Contig size (bp)",
    y = "Number of tRNAs",
    color = "Source",
    shape = "Expression",
    title = "Differentially Expressed tRNA Contigs - SP80-X+G"
  ) +
  
  theme(
    
    panel.grid.major.x = element_blank(),
    panel.grid.minor = element_blank(),
    
    plot.title = element_text(
      hjust = 0.5,
      face = "bold",
      size = 18
    ),
    
    axis.title = element_text(
      size = 15
    ),
    
    axis.text = element_text(
      size = 13
    ),
    
    legend.title = element_text(
      size = 14
    ),
    
    legend.text = element_text(
      size = 13
    ),
    
    plot.margin = margin(
      15,
      20,
      15,
      15
    )
  )

dev.off()