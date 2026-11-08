#1
def get_even_postions(data):
    new=[]
    index=0
    for d in data:
        if index%2==0:
            new.append(d)
        index+=1

    return tuple(new)
print(get_even_postions((10,20,30,40,50,60)))  
#2
def find_exclusive_students(group1, group2):
    return group1-group2
print(find_exclusive_students({'Ana', 'Marko', 'Milica', 'Jovan'}, { 'Marko', 'Milica', 'Petar'}))   
#3
def clean_tags(text):
    new=text.split('|')
    output=[]
    for n in new:
        output.append(n.strip().lower())
    return '-'.join(output)
print(clean_tags('Python| DATA| SQL'))   
#4
def count_products(csv_lines):
    new=csv_lines[1:]
    dic={}
    for csv in new:
        deo=csv.split(',')
        proizvod=deo[1]
        kolicina=int(deo[2])
        dic[proizvod]=dic.get(proizvod,0)+kolicina
        
    return dic    

csv_lines=[
    'customer,product,quantity',
    'Alice,laptop,2',
    'Bob,mouse,3',
    'Alice,laptop,1',
    'Charlie,keyboard,2',
    'Bob,mouse,1'
]
print(count_products(csv_lines))
