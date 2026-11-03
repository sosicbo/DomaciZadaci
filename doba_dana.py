#Domaci 7.1
#Odredjivanje doba dana
for trenutni_sat in range(0,24):
    if trenutni_sat>=6 and trenutni_sat<12:
        doba='jutro'
    elif trenutni_sat>=12 and trenutni_sat<18:
        doba='popodne'
    elif trenutni_sat>=18 and trenutni_sat<22:
        doba='vece'  
    else:
        doba='noc'   
    print(f"{trenutni_sat}h-{doba}")  