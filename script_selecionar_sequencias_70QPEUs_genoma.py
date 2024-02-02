from Bio import SeqIO
import csv

# Caminho para o arquivo FASTA de contigs mapeados - no caso os contigs do genoma GIGA
fasta_file = "/home/helbacsb/Documents/genoma/cana_de_acucar.fasta"

# Lista de cabeçalhos de contigs que desejo verificar
with open('/home/helbacsb/Documents/genoma/QPEUs_70cabecalhos.csv', 'r') as arquivo_csv:
    leitor_csv = csv.reader(arquivo_csv)
    lista_cabecalhos = []
    for linha in leitor_csv:
        lista_cabecalhos.append(linha)

print(lista_cabecalhos[0:5])
# Caminho para o arquivo FASTA de saída
saida_fasta = "/home/helbacsb/Documents/genoma/70_QPEUs_seq.fasta"

# Inicializando uma lista para armazenar as sequências encontradas
sequencias_encontradas = []
# Abrindo o arquivo FASTA e lendo as sequências
with open(fasta_file, "r") as arquivo_entrada:
    for record in SeqIO.parse(arquivo_entrada, "fasta"):
        descricao = record.description
        descricao = descricao[0:14]
        #print(descricao)
        if [descricao] in lista_cabecalhos:
            sequencias_encontradas.append(record)
print(descricao)
#print(record.description)
print(f"Número de sequências encontradas: {len(sequencias_encontradas)}")
#print(sequencias_encontradas)

# Escrevendo as sequências encontradas em um novo arquivo FASTA
with open(saida_fasta, "w") as arquivo_saida:
       SeqIO.write(sequencias_encontradas, arquivo_saida, "fasta")

print(f"As sequências encontradas foram salvas em {saida_fasta}.")
