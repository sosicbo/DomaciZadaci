#Domaci10_2

import numpy as np

#1. Sistem beleži broj aktivnih korisnika tokom 12 uzastopnih sati.

korisnici=np.array([120, 135, 150, 170, 190, 210, 250, 240, 220, 200, 182, 160])
# Prikazati broj korisnika za peti sat. -> 190
print(korisnici[4]) 
# Prikazati broj korisnika za poslednja četiri sata. -> [220 200 182 160]
print(korisnici[-4:])
# Izračunati ukupan broj aktivnih korisnika kroz svih 12 sati. -> 2227
print(korisnici.sum())
# Izračunati prosečan broj korisnika po satu. -> 185.58333333333334
print(korisnici.mean())
# Pronaći sat sa najvećim brojem korisnika -> 7
print(np.argmax(korisnici)+1)

#2. Sistem beleži CPU, RAM i disk usage za pet različitih servera. Redovi predstavljaju servere, a kolone CPU, RAM i disk usage.

servers = np.array([
    [45, 60, 70],
    [55, 65, 80],
    [40, 50, 75],
    [60, 70, 85],
    [80, 90, 60]
])
# Prikazati dimenzije matrice. (5, 3)
print(servers.shape)
# Prikazati broj servera i broj metrika. -> 5 servera 3 metrike
print(servers.shape[0])
print(servers.shape[1])
# Izračunati prosečnu vrednost svake metrike. -> [56. 67. 74.]
print(servers.mean(axis=0))
# Izračunati prosečnu potrošnju resursa za svaki server. -> [58.33333333 66.66666667 55.         71.66666667 76.66666667]
print(servers.mean(axis=1))
# Pronaći server sa najvećom prosečnom potrošnjom resursa -> 5
print(np.argmax(servers.mean(axis=1))+1)

#3. Sistem beleži vreme izvršavanja 15 različitih procesa u sekundama. 

execution_times = np.array([
    12, 45, 67, 120, 34, 89, 150, 23, 56, 200, 101, 40, 99, 75, 30
])
# Pronaći sve procese koji su trajali duže od 100 sekundi. -> [120 150 200 101]
print(execution_times[execution_times>100])
# Pronaći procese koji su trajali između 40 i 100 sekundi. -> [45 67 89 56 40 99 75]
print(execution_times[(execution_times>=40)&(execution_times<=100)])
# Izbrojati procese koji su trajali kraće od 50 sekundi. -> 6
print(np.sum(execution_times<50))
# Pronaći indekse procesa koji su trajali duže od 100 sekundi. -> [ 3  6  9 10]
print(np.where(execution_times>100)[0])
# Izračunati prosečno vreme izvršavanja svih procesa. -> 76.06666666666666
print(execution_times.mean())

#4. Prodavnica beleži prihode od četiri različite kategorije proizvoda tokom šest meseci. Redovi predstavljaju kategorije proizvoda, akolone mesece. 

prihodi = np.array([
    [100, 120, 150, 130, 170, 160],
    [200, 180, 220, 210, 250, 240],
    [90, 110, 100, 130, 140, 120],
    [300, 280, 310, 320, 350, 330]
])
# Izračunati ukupan prihod svake kategorije proizvoda.  -> [ 830 1300  690 1890]
print(prihodi.sum(axis=1))
# Izračunati ukupan prihod za svaki mesec.  -> [690 690 780 790 910 850]
print(prihodi.sum(axis=0))
# Pronaći kategoriju proizvoda sa najvećim ukupnim prihodom.  -> 4
print(np.argmax(prihodi.sum(axis=1))+1)
# Pronaći mesec sa najvećim ukupnim prihodom.  -> 5
print(np.argmax(prihodi.sum(axis=0))+1)
# Izračunati prosečan prihod po kategoriji proizvoda.  -> [138.33333333 216.66666667 115.         315.        ]
print(prihodi.mean(axis=1))
# Izračunati prosečan mesečni prihod svih kategorija  -> 785.0
print(prihodi.sum(axis=0).mean())

# 5. Sistem beleži prosečne dnevne temperature tokom 15 dana. Neki podaci nedostaju ili nisu validni. Validna temperatura mora biti između -20 i 50 stepeni.
temperature = np.array([
    18.5, 21.0, np.nan, 23.4, 55.0,
    19.8, -25.0, 22.1, np.nan, 24.6,
    20.3, 60.2, 17.9, np.nan, 21.7
])
missing=np.isnan(temperature)
# Identifikovati nedostajuće vrednosti. -> [False False  True False False False False False  True False False False False  True False]
print(missing)
# Identifikovati nevalidne temperature (vrednosti manje od -20 ili veće od 50). -> [55.  60.2]
print(temperature[(temperature<-20) | (temperature>50)])
# Pronaći indekse nevalidnih vrednosti. -> [ 4 11]
print(np.where((temperature<-20) | (temperature>50))[0])
# Izračunati broj nedostajućih i nevalidnih vrednosti. -> 3 115.2
print(np.sum(missing)) 
print(np.sum(((temperature<-20) | (temperature>50))))
# Izračunati procenat nevalidnih i nedostajućih zapisa zajedno. -> 33.33333333333333
print(np.sum(missing| ((temperature<-20) | (temperature>50)))/temperature.size*100)
# Kreirati novi niz koji sadrži samo validne temperature. -> [ 18.5  21.   23.4  19.8 -25.   22.1  24.6  20.3  17.9  21.7]
print(temperature[~missing & ~((temperature<-20) | (temperature>50))])
# Izračunati prosečnu temperaturu bez nedostajućih i nevalidnih vrednosti. -> 16.43 2
print(temperature[~missing & ~((temperature<-20) | (temperature>50))].mean())

