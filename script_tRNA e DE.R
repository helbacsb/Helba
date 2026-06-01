# =========================================================
# Script completo:
#   CSV + OUT coding + OUT non-coding + FASTA
#
# Objetivos:
#   - Ler arquivo .csv
#   - Ler dois arquivos .out do tRNAscan
#   - Relacionar contigs
#   - Adicionar:
#         tRNA_number
#         Begin
#         End
#         Type
#         Codon
#         origem
#         contig_length
#   - Manter TODAS as colunas do .csv
#   - Repetir linhas quando houver múltiplos tRNAs
# =========================================================

# ---------------- PACOTES ----------------

suppressWarnings({
  library(dplyr)
  library(stringr)
})

# =========================================================
# ARQUIVOS
# =========================================================

csv_file <- "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/CB49_All_tRNAs_DESEq2.csv"

out_coding <- "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/CB49-COG-EggNOG_corrigidosta.out"

out_noncoding <- "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/CB49-non-coding-contigssta.out"

fasta_file <- "C:/Users/Helba Cirino/Desktop/contigs_DE_tRNA/CB49-260_Trinity_maiores_isoformas_CD-HIT_90_90.fasta"

# =========================================================
# LER CSV
# =========================================================

csv_df <- read.csv(
  csv_file,
  header = TRUE,
  stringsAsFactors = FALSE
)

# garantir nome correto da primeira coluna
colnames(csv_df)[1] <- "contig"

# =========================================================
# FUNÇÃO PARA LER OUT
# =========================================================

ler_out <- function(arquivo_out, origem_nome){
  
  df <- read.delim(
    arquivo_out,
    header = TRUE,
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  
  # selecionar colunas desejadas
  df <- df %>%
    select(
      Name,
      `tRNA`,
      Begin,
      End,
      Type,
      Codon
    )
  
  # renomear coluna tRNA
  colnames(df)[2] <- "tRNA_number"
  
  # renomear Name -> contig
  df <- df %>%
    rename(contig = Name)
  
  # adicionar origem
  df$origem <- origem_nome
  
  return(df)
}

# =========================================================
# LER ARQUIVOS OUT
# =========================================================

coding_df <- ler_out(
  out_coding,
  "COG-EggNOG"
)

noncoding_df <- ler_out(
  out_noncoding,
  "non-coding"
)

# unir os dois dataframes
out_df <- bind_rows(
  coding_df,
  noncoding_df
)

# remover duplicatas
out_df <- distinct(out_df)

# =========================================================
# LER FASTA
# =========================================================

linhas_fasta <- readLines(fasta_file)

# pegar apenas cabeçalhos
headers <- linhas_fasta[
  grepl("^>", linhas_fasta)
]

# extrair contig
contigs <- str_extract(
  headers,
  "^>\\S+"
)

# remover ">"
contigs <- sub("^>", "", contigs)

# extrair tamanho do contig
tamanhos <- str_extract(
  headers,
  "len=[0-9]+"
)

# remover "len="
tamanhos <- sub(
  "len=",
  "",
  tamanhos
)

# converter para número
tamanhos <- as.numeric(tamanhos)

# criar dataframe FASTA
fasta_df <- data.frame(
  contig = contigs,
  contig_length = tamanhos,
  stringsAsFactors = FALSE
)

# =========================================================
# MERGE FINAL
# =========================================================

merged_df <- csv_df %>%
  left_join(out_df, by = "contig") %>%
  left_join(fasta_df, by = "contig")

# =========================================================
# SALVAR RESULTADO
# =========================================================

arquivo_saida <- paste0(
  dirname(csv_file),
  "/resultado_final.csv"
)

write.csv(
  merged_df,
  arquivo_saida,
  row.names = FALSE
)

# =========================================================
# INFORMAÇÕES FINAIS
# =========================================================

cat("\n====================================\n")
cat("Processamento concluído!\n")
cat("Arquivo salvo em:\n")
cat(arquivo_saida, "\n")
cat("====================================\n\n")

# =========================================================
# RESUMO
# =========================================================

cat("Número de contigs no CSV:",
    nrow(csv_df), "\n")

cat("Número de registros tRNA:",
    nrow(out_df), "\n")

cat("Número de linhas finais:",
    nrow(merged_df), "\n")

cat("\nDistribuição por origem:\n")

print(
  table(merged_df$origem,
        useNA = "ifany")
)