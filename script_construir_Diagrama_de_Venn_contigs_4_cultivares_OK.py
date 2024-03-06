from collections import defaultdict
from venny4py.venny4py import *
import matplotlib.pyplot as plt

# Função para extrair as informações do arquivo e contabilizar as interseções
def processar_arquivo(arquivo):
    conjuntos = {
        'CB49-260': set(),
        'IAC66-6': set(),
        'SP78-4467': set(),
        'SP80-3280': set()
    }
    
    with open(arquivo, 'r') as f:
        cluster_atual = None
        for linha in f:
            if linha.startswith('>Cluster'):
                cluster_atual = linha.strip().split()[1]
            else:
                if cluster_atual:
                    info = linha.strip().split(',')
                    sequencia = info[0].split()[1]
                    gene = info[1].split('>')[1].split('_')[0]
                    conjuntos[gene].add(cluster_atual)
    
    return conjuntos

# Processar o arquivo e obter os conjuntos
conjuntos = processar_arquivo('4_Cultivares.Trinity_maiores_isoformas_Resultado_CD-HIT.fasta.clstr')

#print(conjuntos)

# Criar o diagrama de Venn
venny4py(sets=conjuntos, size=4)

plt.show()
