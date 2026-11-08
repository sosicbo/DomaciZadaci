#19. Написати функцију get_header(path: str) -> list која враћа заглавље CSV фајла
#Користити csv.reader и next()
#Input: 'data/raw/teams.csv'
#Output: ['team', 'city', 'points']

def get_header(path):
    with open(path , 'r') as f:
        reader=csv.reader(f)
        return next(reader)
print(get_header('data/raw/teams.csv')) 

#20. Написати функцију read_rows(path: str) -> list која враћа све редове CSV фајла без заглавља, као листу листи
#Користити csv.reader
#Input: 'data/raw/teams.csv'
#Output: [['FK Jedinstvo', 'Bela Palanka', '34'], ['FK Radnički', 'Niš', '41'],
#['FK Rakovica', 'Beograd, Rakovica', '28'], ['FK Sloga', 'Kraljevo', '19']]

def read_rows(path):
    with open(path, 'r') as f:
        reader=csv.reader(f)
        header=next(reader)
        lista=[]
        for row in reader:
            lista.append(row)
        return lista
print(read_rows('data/raw/teams.csv')) 

#21. Написати функцију total_points(path: str) -> int која враћа збир бодова свих тимова
#Користити csv.DictReader
#Input: 'data/raw/teams.csv'
#Output: 122
def total_points(path):
    with open(path,'r') as f:
        teams=list(csv.DictReader(f))
        total=0
        for t in teams:
            total+=int(t['points'])
        return total    
print(total_points('data/raw/teams.csv'))   

#22. Написати функцију write_rows(path: str, rows: list) -> None која листу листи уписује у CSV фајл
#Input: 'data/processed/people.csv', [['name', 'age'], ['Ana', 20], ['Marko', 22]]
#Садржај фајла након позива:
#name,age
#Ana,20
#Marko,22
def write_rows(path, rows):
    with open(path, 'w') as f:
        writer=csv.writer(f)
        writer.writerows(rows)
print(write_rows('data/processed/people.csv', [['name', 'age'], ['Ana', 20], ['Marko', 22]]))    

#23. Написати функцију write_dicts(path: str, rows: list) -> None која листу речника уписује у CSV фајл
#Користити csv.DictWriter; заглавља су кључеви првог речника
#Input: 'data/processed/people.csv', [{'name': 'Ana', 'age': 20}, {'name':
#'Marko', 'age': 22}]
import csv
def write_dicts(path: str, rows: list):
    with open(path, 'w') as f:
        writer=csv.DictWriter(f, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)
    
write_dicts('data/processed/people.csv', [{'name': 'Ana', 'age': 20}, {'name':'Marko', 'age': 22}])   