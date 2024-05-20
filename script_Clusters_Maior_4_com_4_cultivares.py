# Nome do arquivo de entrada
nome_arquivo_entrada = 'clusters_Maiores_5.txt'

# Nome do arquivo de saída
nome_arquivo_saida = 'clusters_Maiores_5_com_4_cultivares.txt'

# Lista de cultivares
cultivares = ['CB49-260', 'IAC66-6', 'SP78-4467', 'SP80-3280']

# Abrir o arquivo de entrada para leitura
with open(nome_arquivo_entrada, 'r') as arquivo_entrada:
    # Inicializar uma variável para armazenar os clusters completos
    clusters_completos = []
    # Inicializar uma variável para armazenar as linhas do cluster atual
    linhas_cluster_atual = []

    # Função para verificar se todas as cultivares estão presentes no cluster
    def todas_cultivares_presentes(cluster):
        return all(cultivar in cluster for cultivar in cultivares)

    # Iterar sobre cada linha do arquivo de entrada
    for linha in arquivo_entrada:
        # Verificar se a linha indica um novo cluster
        if linha.startswith(">Cluster"):
            # Verificar se o cluster anterior era completo (com as 4 cultivares)
            if todas_cultivares_presentes(''.join(linhas_cluster_atual)):
                # Adicionar o cluster anterior à lista de clusters completos
                clusters_completos.append(''.join(linhas_cluster_atual))
            # Limpar as linhas do cluster atual para começar um novo cluster
            linhas_cluster_atual = []
        # Adicionar a linha atual às linhas do cluster atual
        linhas_cluster_atual.append(linha)

    # Verificar o último cluster após o término do arquivo
    if todas_cultivares_presentes(''.join(linhas_cluster_atual)):
        clusters_completos.append(''.join(linhas_cluster_atual))

# Abrir o arquivo de saída para escrita
with open(nome_arquivo_saida, 'w') as arquivo_saida:
    # Escrever os clusters completos no arquivo de saída
    for cluster in clusters_completos:
        arquivo_saida.write(cluster)

print(f"Clusters completos foram salvos em '{nome_arquivo_saida}'.")
