#9.1.
#1. Napisati funkciju safe_divide(a: float, b: float) -> float | None koja vraća rezultat deljenja dva broja.
def safe_divide(a, b):
    try:
        return a/b
    except ZeroDivisionError:
        return None
    
print(safe_divide(10, 2))
print(safe_divide(10, 0))

# 2. Napisati funkciju safe_int(value: str) -> int | None koja pokušava da prosleđeni string pretvori u ceo broj.
def safe_int(value):
    try:
        return int(value)
    except ValueError:
        return None
    
print(safe_int('25')) # 25
print(safe_int('-10')) # -10
print(safe_int('abc')) # None

# 3. Napisati funkciju get_grade(grades: dict, student: str) ->int | None koja vraća ocenu studenta iz rečnika.
def get_grade(grades, student):
    try:
        return grades[student]            
    except KeyError:
        return None
print(get_grade({'Ana': 5, 'Marko': 4, 'Jovana': 5}, 'Marko'))    
print(get_grade({'Ana': 5, 'Marko': 4, 'Jovana': 5}, 'Petar'))    

# 4. Napisati funkciju read_file(path: str) -> str koja čita i vraća kompletan sadržaj tekstualnog fajla.
def read_file(path):
    try:
        with open(path) as f:
            return f.read()
    except FileNotFoundError:
        return 'File not found.'
               
print(read_file('primer.txt'))  

# 5.Napisati funkciju sum_numbers(values: list) -> float koja vraća zbir svih elemenata liste koji mogu da se pretvore u brojeve.
def sum_numbers(values):
    total=0.0
    for v in values:
        try:
            total+=float(v)
        except ValueError:
            continue
    return total     
print(sum_numbers(['10', '5.5', 'abc', '3', 'hello']))

# 6.Napisati funkciju get_age(csv_line: str) -> int | None koja iz CSV reda izdvaja i vraća godine osobe.

def get_age(csv_line):
    try:
        ime, godine=csv_line.split(',')
        return int(godine)
    except ValueError:
        return None
    
print(get_age('Ana,22')) # 22
print(get_age('Marko,abc')) # None
print (get_age('Jovana')) # None