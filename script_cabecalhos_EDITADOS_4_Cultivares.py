import csv

# Função para extrair o texto entre o primeiro underline e o primeiro espaço
def extrair_texto(linha):
    partes = linha.split('_', 1)
    return partes[1].split(' ', 1)[0]

# Lista para armazenar os textos extraídos
textos = []

# Abre o arquivo CSV e extrai o texto desejado de cada linha
with open('cabecalhos_4_Cultivares.Trinity_maiores_isoformas_Resultado_CD-HIT.csv', 'r') as arquivo_csv:
    leitor_csv = csv.reader(arquivo_csv)
    for linha in leitor_csv:
        texto_extraido = extrair_texto(linha[0])
        textos.append(texto_extraido)

# Salva os textos extraídos em um novo arquivo
with open('cabecalhos_EDITADOS_4_Cultivares.Trinity_maiores_isoformas_Resultado_CD-HIT.csv', 'w') as arquivo_saida:
    for texto in textos:
        arquivo_saida.write(texto + '\n')
