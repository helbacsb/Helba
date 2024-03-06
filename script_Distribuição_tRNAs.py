from Bio import SeqIO
import matplotlib.pyplot as plt
import csv

def calcular_tamanhos_sequencias(arquivo_fasta):
    tamanhos = []
    with open(arquivo_fasta, "r") as fasta_file:
        for record in SeqIO.parse(fasta_file, "fasta"):
            tamanho = len(record.seq)
            tamanhos.append(tamanho)
    return tamanhos

def salvar_dados_csv(tamanhos, arquivo_csv):
    with open(arquivo_csv, "w", newline="") as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(["Tamanho da Sequência"])
        for tamanho in tamanhos:
            writer.writerow([tamanho])

def plotar_grafico_distribuicao(tamanhos):
    plt.hist(tamanhos, bins=50, color='blue', alpha=0.7)
    plt.xlabel('Tamanho da Sequência')
    plt.ylabel('Frequência')
    plt.title('Distribuição de Tamanhos de Sequências')
    plt.grid(True)
    plt.savefig('distribuicao_tamanhos_sequencias.png')
    plt.show()

# Arquivo FASTA de exemplo
arquivo_fasta = "CB49-260_Eucaryotic_tRNA.fasta"
# Arquivo CSV para salvar os dados
arquivo_csv = "CB49-260_Eucaryotic_tRNA_tamanhos_sequencias.csv"

# Calcular tamanhos das sequências
tamanhos = calcular_tamanhos_sequencias(arquivo_fasta)

# Salvar os dados em um arquivo CSV
salvar_dados_csv(tamanhos, arquivo_csv)

# Plotar o gráfico de distribuição
plotar_grafico_distribuicao(tamanhos)
