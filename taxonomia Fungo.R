# Instalando pacotes

#install.packages(c(
#  "tidyverse",
#  "plotly",
#  "networkD3"
#))

##############################
#     Carregando arquivo     #
##############################
library(tidyverse)

df <- read.delim(
  "C:/Users/helba.barbosa/Desktop/Taxonomia.tsv",
  sep = "\t",
  header = TRUE,
  stringsAsFactors = FALSE
)

df$Count <- as.numeric(df$Count)

##############################
#     Gráfico de barras      #
##############################
Domain_counts <- df %>%
  group_by(Domain) %>%
  summarise(
    Count = sum(Count),
    .groups = "drop"
  ) %>%
  arrange(desc(Count))

ggplot(
  Domain_counts,
  aes(
    x = reorder(Domain, Count),
    y = Count
  )
) +
  geom_col() +
  geom_text(
    aes(label = Count),
    hjust = -0.2,
    size = 4
  ) +
  coord_flip() +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.1))
  ) +
  theme_bw() +
  labs(
    x = "Domain",
    y = "Abundance",
    title = "Abundance by Domain"
  )

ggsave(
  "Domain_barplot.png",
  width = 8,
  height = 5,
  dpi = 300
)

##############################
#       Top 20 Phylum        #
##############################
phylum_counts <- df %>%
  group_by(Phylum) %>%
  summarise(
    Count = sum(Count),
    .groups = "drop"
  ) %>%
  arrange(desc(Count)) %>%
  slice_head(n = 20)

ggplot(
  phylum_counts,
  aes(
    x = reorder(Phylum, Count),
    y = Count
  )
) +
  geom_col() +
  geom_text(
    aes(label = Count),
    hjust = -0.2,
    size = 4
  ) +
  coord_flip() +
  theme_bw() +
  labs(
    x = "Phylum",
    y = "Abundance",
    title = "Top 20 Phylum"
  )

ggsave(
  "Top20_Phylum.png",
  width = 10,
  height = 6,
  dpi = 300
)

##############################
#        Top 20 Genus        #
##############################
genus_counts <- df %>%
  filter(
    Genus != "",
    !is.na(Genus)
  ) %>%
  group_by(Genus) %>%
  summarise(
    Count = sum(Count),
    .groups = "drop"
  ) %>%
  arrange(desc(Count)) %>%
  slice_head(n = 20)

ggplot(
  genus_counts,
  aes(
    x = reorder(Genus, Count),
    y = Count
  )
) +
  geom_col() +
  geom_text(
    aes(label = Count),
    hjust = -0.2,
    size = 4
  ) +
  coord_flip() +
  theme_bw() +
  labs(
    x = "Genus",
    y = "Abundance",
    title = "Top 20 Genus"
  )

ggsave(
  "Top20_Genus.png",
  width = 10,
  height = 6,
  dpi = 300
)


##############################
#     Gerar o Sunburst       #
##############################

#install.packages("sunburstR")
library(sunburstR)
library(dplyr)
library(htmlwidgets)

sunburst_df <- df %>%
  mutate(
    path = paste(
      Domain,
      SuperGroup,
      Phylum,
      Class,
      Order,
      Family,
      Genus,
      Species,
      sep = "-"
    )
  ) %>%
  select(path, Count)

sunburst(
  sunburst_df,
  count = TRUE
)

# gerar o gráfico em si
p <- sunburst(
  sunburst_df,
  count = TRUE
)

#Salvar
saveWidget(
  p,
  "Sunburst_taxonomy.html",
  selfcontained = TRUE
)
