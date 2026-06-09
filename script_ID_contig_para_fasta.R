library(dplyr)
library(seqinr)

#########################################
# Arquivos de entrada
#########################################

arquivo_taxonomia <- "taxonomy_sample4_com_contigs.tsv"
arquivo_fasta <- "final.contigs_sample4.fa"

#########################################
# Ler tabela
#########################################

tax <- read.delim(
  arquivo_taxonomia,
  sep = "\t",
  header = TRUE,
  stringsAsFactors = FALSE
)

#########################################
# Verificar nomes das colunas
#########################################

print(colnames(tax))

#########################################
# Filtrar apenas Fungi
#########################################

fungi <- tax %>%
  filter(grepl(";Fungi;", Taxonomy))

cat(
  nrow(fungi),
  "linhas contendo Fungi\n"
)

#########################################
# Extrair contigs
#########################################

contigs <- unique(
  unlist(
    strsplit(
      paste(
        fungi$Contigs[
          !is.na(fungi$Contigs) &
            fungi$Contigs != "NA"
        ],
        collapse = ";"
      ),
      ";"
    )
  )
)

contigs <- trimws(contigs)

cat(
  length(contigs),
  "contigs únicos encontrados\n"
)

#########################################
# Salvar tabela filtrada
#########################################

write.table(
  fungi,
  "fungi_contigs_sample4.tsv",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

#########################################
# Ler FASTA
#########################################

fasta <- read.fasta(
  arquivo_fasta,
  seqtype = "DNA",
  as.string = TRUE,
  forceDNAtolower = FALSE
)

#########################################
# Extrair IDs dos cabeçalhos
#########################################

ids_fasta <- sub(
  " .*",
  "",
  names(fasta)
)

#########################################
# Selecionar contigs de fungos
#########################################

idx <- ids_fasta %in% contigs

fasta_fungi <- fasta[idx]

#########################################
# Salvar FASTA filtrado
#########################################

write.fasta(
  sequences = fasta_fungi,
  names = names(fasta_fungi),
  file.out = "fungi_contigs.fa"
)

#########################################
# Resumo
#########################################

cat(
  length(fasta_fungi),
  "sequências salvas em fungi_contigs.fa\n"
)