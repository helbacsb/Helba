from Bio import SeqIO
import os

def split_fasta(input_file, output_dir, max_size):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    current_size = 0
    file_index = 1
    output_file = os.path.join(output_dir, f'output_{file_index}.fasta')
    out_handle = open(output_file, 'w')
    
    for record in SeqIO.parse(input_file, "fasta"):
        seq_size = len(record.format("fasta").encode('utf-8'))
        
        if current_size + seq_size > max_size:
            out_handle.close()
            file_index += 1
            output_file = os.path.join(output_dir, f'output_{file_index}.fasta')
            out_handle = open(output_file, 'w')
            current_size = 0
        
        SeqIO.write(record, out_handle, "fasta")
        current_size += seq_size

    out_handle.close()

# Parâmetros de entrada
input_file = 'TODOS_contigs_tRNAs.fasta'  # Arquivo FASTA de entrada
output_dir = 'output_files'  # Diretório onde os arquivos divididos serão armazenados
max_size = 2 * 1024 * 1024  # Tamanho máximo de 2MB para cada arquivo

split_fasta(input_file, output_dir, max_size)
