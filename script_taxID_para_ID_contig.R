library(dplyr)
library(tidyr)

# Taxonomia
taxonomy <- read.delim(
  "taxonomy_sample4_TESTE.tsv",
  header = FALSE,
  sep = "\t",
  stringsAsFactors = FALSE
)

colnames(taxonomy) <- c(
  "TaxID",
  "Count",
  "Taxonomy"
)

# Resultado filtrado
resultado <- read.delim(
  "resultado_filtrado_sample4_TESTE.tsv",
  header = FALSE,
  sep = "\t",
  stringsAsFactors = FALSE
)

colnames(resultado)[1:3] <- c(
  "Contig",
  "TaxID",
  "Descricao"
)

# Separar TaxIDs múltiplos
resultado_expandido <- resultado %>%
  separate_rows(TaxID, sep = ";")

# Converter para caractere para evitar problemas
taxonomy$TaxID <- as.character(taxonomy$TaxID)
resultado_expandido$TaxID <- as.character(resultado_expandido$TaxID)

# Agrupar contigs por TaxID
contigs_por_taxid <- resultado_expandido %>%
  group_by(TaxID) %>%
  summarise(
    Contigs = paste(unique(Contig), collapse = ";"),
    n_contigs = n_distinct(Contig),
    .groups = "drop"
  )

# Juntar com a taxonomia
resultado_final <- taxonomy %>%
  left_join(
    contigs_por_taxid,
    by = "TaxID"
  )

# Substituir ausentes
resultado_final$Contigs[is.na(resultado_final$Contigs)] <- "NA"
resultado_final$n_contigs[is.na(resultado_final$n_contigs)] <- 0

# Salvar
write.table(
  resultado_final,
  "taxonomy_sample4_com_contigs.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)