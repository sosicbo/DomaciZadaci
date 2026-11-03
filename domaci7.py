#0.1. Napisati program kojim se prevodi temperatura iz Celzijusove skale u Farenhajtovu skalu,ako je odgovaraju´ca formula oblika T [◦F] = T [◦C] · 1.80 + 32. Na ulazu se unosi vrednost temperature u stepenima Celzijusa (realan broj) a #ispisuje se vrednost temperature u stepenima Farenhajta.
def temp_c_to_f(temperature):
    return temperature*1.8+32
print(temp_c_to_f(7))  

#0.2. Napisati program koji za uneti redni broj dana u nedelji (od 1 do 7) ispisuje naziv tog dana (ponedeljak - nedelja). Ukoliko je unet broj koji nije izmed¯u 1 i 7, ispisati Pogresan unos.

def dan_u_nedelji(dan):
    if dan is None:
        return 'Nepoznato'
    elif dan==1:
        return 'Ponedeljak'
    elif dan==2:
        return 'Utorak'
    elif dan==3:
        return 'Sreda'
    elif dan==4:
        return 'Cetvrtak'
    elif dan==5:
        return 'Petak'
    elif dan==6:
        return 'Subota'
    elif dan==7:
        return 'Nedelja'
    else:
        return 'Pogresan unos'
print(dan_u_nedelji(8))    

#0.3. Napisati program koji raˇcuna najve´ci negativni element u listi
def negat_max(lista):
    max=None
    for x in lista:
        if x<0 and (max is None or x>max):
            max=x
    return max
    
lista=[-3,-1,-7, 5]       
print(negat_max(lista)) 

#0.5. Napisati program koji raˇcuna broj parnih elemenata date liste.
def br_parnih(lista):
    count=0
    for l in lista:
        if l%2==0:
            count=count+1
    return count
lista=[2,5,8,9,3,7]
print(br_parnih(lista))   

#0.6. Napisati program koji raˇcuna sume elemenata liste celih brojeva koji su deljivi sa 2 odnosno sa 3
def deljivi_sa_2_ili_3(lista):
    suma2=0
    suma3=0
    for l in lista:
        if l%2==0:
            suma2+=l
        if l%3==0:
            suma3+=l
    return suma2,suma3

lista=[2,5,8,9,3,7] 
s2,s3=deljivi_sa_2_ili_3(lista)
print('Suma deljivih sa 2:', s2)
print('Suma deljivih sa 3:', s3)   
