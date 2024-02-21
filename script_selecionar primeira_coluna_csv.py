import re

# Nome do arquivo de entrada e saída
arquivo_entrada = 'SP80-3280_Eucaryotic_TODOS.csv'
arquivo_saida = 'SP80-3280_Eucaryotic_TODOS_Apenas_Cabecalho.csv'

# Abra o arquivo de entrada para leitura e o arquivo de saída para escrita
with open(arquivo_entrada, 'r') as entrada, open(arquivo_saida, 'w') as saida:
    # Itera sobre cada linha do arquivo de entrada
    for linha in entrada:
        # Aplica a expressão regular para obter os caracteres antes do primeiro tab
        match = re.match(r'^([^\t]+)', linha)
        if match:
            # Se houver uma correspondência, escreva os caracteres capturados no arquivo de saída
            saida.write(match.group(1) + '\n')
