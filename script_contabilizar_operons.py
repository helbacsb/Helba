from collections import defaultdict

def count_string_occurrences(file_path):
    # Dicionário para rastrear a contagem de ocorrências de cada string
    string_count = defaultdict(int)

    # Ler o arquivo e contar as ocorrências de cada string
    with open(file_path, 'r') as file:
        for line in file:
            # Remover caracteres de quebra de linha
            line = line.strip()
            # Incrementar a contagem da string atual
            string_count[line] += 1

    # Dicionário para rastrear a contagem de contagens de ocorrências
    count_occurrences = defaultdict(int)

    # Iterar sobre as ocorrências de cada string e contar quantas vezes ocorrem
    for string, count in string_count.items():
        count_occurrences[count] += 1

    return count_occurrences

# Caminho do arquivo de entrada
file_path = '/content/operonsSP80.txt'

# Chamar a função para contar as ocorrências de cada string
result = count_string_occurrences(file_path)

# Imprimir o resultado
for occurrences, count in sorted(result.items()):
    print(f"{count} strings ocorrem {occurrences} vezes")