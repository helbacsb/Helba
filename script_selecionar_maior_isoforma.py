from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

# Substitua 'input.fasta' pelo caminho do seu arquivo FASTA de entrada
arquivo_entrada = "/home/helbacsb/Documents/Contigs_Trinity/Resultado_Trinity/Biblioteca_02/trinity_saida_02.Trinity.fasta"
# Substitua 'output.fasta' pelo nome desejado do arquivo de saída
arquivo_saida = "/home/helbacsb/Documents/Contigs_Trinity/Resultado_Trinity/Biblioteca_02/02.Trinity_maiores_isoformas.fasta"

# Dicionário para armazenar as sequências por conjunto (sem o sufixo "_iX")
sequencias_por_conjunto = {}

# Lê o arquivo FASTA e armazena as sequências no dicionário
with open(arquivo_entrada, 'r') as fasta_file:
    for record in SeqIO.parse(fasta_file, 'fasta'):
        seq_id = record.id
        conjunto_id = seq_id.rsplit('_', 1)[0]  # Remove o sufixo "_iX" do identificador

# Verifica se o conjunto já está no dicionário
        if conjunto_id in sequencias_por_conjunto:
# Atualiza a sequência se o comprimento for maior
            if len(record.seq) > len(sequencias_por_conjunto[conjunto_id].seq):
                sequencias_por_conjunto[conjunto_id] = record
        else:
            sequencias_por_conjunto[conjunto_id] = record

# Escreve as maiores isoformas no arquivo de 
with open(arquivo_saida, 'w') as output_file:
    SeqIO.write(sequencias_por_conjunto.values(), output_file, 'fasta')






