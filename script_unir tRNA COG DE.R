library(dplyr)
library(tidyr)

# ==================================================
# Ler arquivo final
# ==================================================

resultado <- read.csv(
  "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/SP80-G_resultado_final_OK_31maio.csv",
  stringsAsFactors = FALSE
)

# ==================================================
# Ler annotations
# ==================================================

annot <- read.delim(
  "C:/Users/Helba Cirino/Downloads/SP80_eggnogoutput.txt.emapper.annotations",
  sep = "\t",
  header = TRUE,
  comment.char = "#",
  quote = "",
  stringsAsFactors = FALSE
)

# ==================================================
# Remover sufixo _0, _1, _2...
# ==================================================

annot <- annot %>%
  mutate(
    contig = sub("_[0-9]+$", "", query)
  )

# ==================================================
# Numerar anotações repetidas
# ==================================================

annot_expandido <- annot %>%
  group_by(contig) %>%
  mutate(
    anotacao_id = row_number()
  ) %>%
  ungroup() %>%
  select(
    contig,
    anotacao_id,
    COG_category,
    Description
  )

# ==================================================
# Transformar em formato largo
# ==================================================

annot_wide <- annot_expandido %>%
  pivot_wider(
    names_from = anotacao_id,
    values_from = c(
      COG_category,
      Description
    ),
    names_sep = "_"
  )

# ==================================================
# Juntar ao resultado final
# ==================================================

resultado_final <- resultado %>%
  left_join(
    annot_wide,
    by = "contig"
  )

# ==================================================
# Conferir
# ==================================================

cat(
  "Linhas arquivo original:",
  nrow(resultado),
  "\n"
)

cat(
  "Linhas arquivo final:",
  nrow(resultado_final),
  "\n"
)

# ==================================================
# Salvar
# ==================================================

write.csv(
  resultado_final,
  "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/SP80-G_tRNA_COG_04jun.csv",
  row.names = FALSE
)