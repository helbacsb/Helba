# -*- coding: utf-8 -*-
"""Script_Trinity_Result.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1sLnQihUodZhGA_QnnsVaiXFxLaFhc9w0
"""

#!pip3 install biopython

from statistics import mean
import statistics

cabecalho=[]
tamanhos=[]

for line in open("/content/drive/MyDrive/Helba_Cirino_Marie_FAPESP/Resultado_Trinity/Resultado_Trinity_por_Condicao/46_47_48_Trinity.fasta"):
  if (">" in line):
    line=line.replace(" ", "_")
    cabecalho.append(line)

for line in cabecalho:
  line = line.split('_')
  tamanho = line[6]
  tamanho = tamanho[4:]
  tamanhos.append(tamanho)

cont_menor_500=0
cont_menor_1000=0
cont_maior_1000=0
cont_menor_1500=0
cont_menor_2000=0
cont_menor_2500=0
cont_menor_3000=0
cont_menor_3500=0
cont_menor_4000=0
cont_menor_4500=0
cont_menor_5000=0
cont_menor_5500=0
cont_menor_6000=0
cont_maior_6000=0
media=0
minimo=0
maximo=0

print(tamanhos)

for index in range(len(tamanhos)):
    tamanhos[index] = tamanhos[index].rstrip('\n')
    tamanhos[index] = int(tamanhos[index])
    if (tamanhos[index]<=500):
      cont_menor_500=cont_menor_500 + 1
    elif (tamanhos[index]<=1000):
      cont_menor_1000=cont_menor_1000+1
    elif (tamanhos[index]<=1500):
      cont_menor_1500=cont_menor_1500+1
    elif (tamanhos[index]<=2000):
      cont_menor_2000=cont_menor_2000+1
    elif (tamanhos[index]<=2500):
      cont_menor_2500=cont_menor_2500+1
    elif (tamanhos[index]<=3000):
      cont_menor_3000=cont_menor_3000+1
    elif (tamanhos[index]<=3500):
      cont_menor_3500=cont_menor_3500+1
    elif (tamanhos[index]<=4000):
      cont_menor_4000=cont_menor_4000+1
    elif (tamanhos[index]<=4500):
      cont_menor_4500=cont_menor_4500+1
    elif (tamanhos[index]<=5000):
      cont_menor_5000=cont_menor_5000+1
    elif (tamanhos[index]<=5500):
      cont_menor_5500=cont_menor_5500+1
    elif (tamanhos[index]<=6000):
      cont_menor_6000=cont_menor_6000+1
    else:
      cont_maior_6000=cont_maior_6000+1


cont_maior_1000=cont_menor_1500+cont_menor_2000+cont_menor_2500+cont_menor_3000+cont_menor_3500+cont_menor_4000+cont_menor_4500+cont_menor_5000+cont_menor_5500+cont_menor_6000+cont_maior_6000

print(cont_menor_500)
print(cont_menor_1000)
print(cont_menor_1500)
print(cont_menor_2000)
print(cont_menor_2500)
print(cont_menor_3000)
print(cont_menor_3500)
print(cont_menor_4000)
print(cont_menor_4500)
print(cont_menor_5000)
print(cont_menor_5500)
print(cont_menor_6000)
print(cont_maior_6000)

print("\n")

print(cont_menor_500)
print(cont_menor_1000)
print(cont_maior_1000)

#print(tamanhos)
print("\n")
print(mean(tamanhos))
print(min(tamanhos))
print(max(tamanhos))
print("\n")

print("Desvio Padrão:")
print(statistics.pstdev(tamanhos))