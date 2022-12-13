from statistics import median

arq1 = open('tamanho_26')
arq2 = open('intervalos_tamanhos_26','w')
l1 = []

cont_menor_250=0
cont_menor_300=0
cont_menor_400=0
cont_menor_500=0
cont_menor_600=0
cont_menor_700=0
cont_menor_800=0
cont_menor_900=0
cont_menor_1000=0
cont_menor_1100=0
cont_menor_1200=0
cont_menor_1300=0
cont_menor_1400=0
cont_menor_1500=0
cont_menor_2000=0
cont_menor_2500=0
cont_menor_3000=0
cont_menor_6000=0
cont_maior_6000=0
media=0
minimo=0
maximo=0

for line in arq1:
  l1.append(line)

for index in range(len(l1)):
    l1[index] = l1[index].rstrip('\n')
    l1[index] = int(l1[index])
    if (l1[index]<=250):
      cont_menor_250=cont_menor_250+1
    elif (l1[index]>250 and l1[index]<=300):
      cont_menor_300=cont_menor_300+1
    elif (l1[index]>300 and l1[index]<=400):
      cont_menor_400=cont_menor_400+1  
    elif (l1[index]>400 and l1[index]<=500):
      cont_menor_500=cont_menor_500+1 
    elif (l1[index]>500 and l1[index]<=600):
      cont_menor_600=cont_menor_600+1
    elif (l1[index]>600 and l1[index]<=700):
      cont_menor_700=cont_menor_700+1 
    elif (l1[index]>700 and l1[index]<=800):
      cont_menor_800=cont_menor_800+1 
    elif (l1[index]>800 and l1[index]<=900):
      cont_menor_900=cont_menor_900+1 
    elif (l1[index]>900 and l1[index]<=1000):
      cont_menor_1000=cont_menor_1000+1 
    elif (l1[index]>1000 and l1[index]<=1100):
      cont_menor_1100=cont_menor_1100+1 
    elif (l1[index]>1100 and l1[index]<=1200):
      cont_menor_1200=cont_menor_1200+1 
    elif (l1[index]>1200 and l1[index]<=1300):
      cont_menor_1300=cont_menor_1300+1 
    elif (l1[index]>1300 and l1[index]<=1400):
      cont_menor_1400=cont_menor_1400+1 
    elif (l1[index]>1400 and l1[index]<=1500):
      cont_menor_1500=cont_menor_1500+1 
    elif (l1[index]>1500 and l1[index]<=2000):
      cont_menor_2000=cont_menor_2000+1 
    elif (l1[index]>2000 and l1[index]<=2500):
      cont_menor_2500=cont_menor_2500+1 
    elif (l1[index]>2500 and l1[index]<=3000):
      cont_menor_3000=cont_menor_3000+1 
    elif (l1[index]>3000 and l1[index]<=6000):
      cont_menor_6000=cont_menor_6000+1 
    else:
      cont_maior_6000=cont_maior_6000+1 


print(cont_menor_250)
print(cont_menor_300)
print(cont_menor_400)
print(cont_menor_500)
print(cont_menor_600)
print(cont_menor_700)
print(cont_menor_800)
print(cont_menor_900)
print(cont_menor_1000)
print(cont_menor_1100)
print(cont_menor_1200)
print(cont_menor_1300)
print(cont_menor_1400)
print(cont_menor_1500)
print(cont_menor_2000)
print(cont_menor_2500)
print(cont_menor_3000)
print(cont_menor_6000)
print(cont_maior_6000)

print(median(l1))
print(max(l1))
print(min(l1))
 

