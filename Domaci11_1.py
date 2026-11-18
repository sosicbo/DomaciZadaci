#Domaci11_1
# 1. Informacije o svemirskoj stanici

import requests
def get_space_station():
    response=requests.get('http://api.open-notify.org/iss-now.json')
    response.raise_for_status()
    data=response.json()
    #print(response.status_code)
    #print(response.json())
    return {
        'latitude': data['iss_position']['latitude'],
        'longitude': data['iss_position']['longitude']
    }
print (get_space_station())    

# 2. Pretraga univerziteta

def get_universities(country):
    response=requests.get('http://universities.hipolabs.com/search', params={'country':country})
    response.raise_for_status()
    data=response.json()
    return [d['name'] for d in data]
print(get_universities('Serbia'))  

#3. Informacije o kursu valuta

def get_exchange_rate(base, target):
     response=requests.get('https://api.frankfurter.dev/v1/latest', params={'base':base, 'symbols':target})
     response.raise_for_status()
     data=response.json()
     return data['rates'][target]
     
print(get_exchange_rate("EUR", "USD"))   