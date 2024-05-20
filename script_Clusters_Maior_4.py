# Nome do arquivo de entrada
nome_arquivo_entrada = '4_Cultivares.Trinity_maiores_isoformas_Resultado_CD-HIT.fasta.clstr'

# Nome do arquivo de saída
nome_arquivo_saida = 'clusters_Maiores_4.txt'

# Abrir o arquivo de entrada para leitura
with open(nome_arquivo_entrada, 'r') as arquivo_entrada:
    # Inicializar uma variável para armazenar os clusters com 4 ou mais linhas
    clusters_selecionados = []
    # Inicializar uma variável para armazenar as linhas do cluster atual
    linhas_cluster_atual = []

    # Iterar sobre cada linha do arquivo de entrada
    for linha in arquivo_entrada:
        # Verificar se a linha indica um novo cluster
        if linha.startswith(">Cluster"):
            # Verificar se o cluster atual tem 4 ou mais linhas
            if len(linhas_cluster_atual) >= 4:
                # Adicionar o cluster atual à lista de clusters selecionados
                clusters_selecionados.append(''.join(linhas_cluster_atual))
            # Limpar as linhas do cluster atual para começar um novo cluster
            linhas_cluster_atual = []
        # Adicionar a linha atual às linhas do cluster atual
        linhas_cluster_atual.append(linha)

    # Verificar o último cluster após o término do arquivo
    if len(linhas_cluster_atual) >= 4:
        clusters_selecionados.append(''.join(linhas_cluster_atual))

# Abrir o arquivo de saída para escrita
with open(nome_arquivo_saida, 'w') as arquivo_saida:
    # Escrever os clusters selecionados no arquivo de saída
    for cluster in clusters_selecionados:
        arquivo_saida.write(cluster)

print(f"Clusters com 4 ou mais linhas foram salvos em '{nome_arquivo_saida}'.")
