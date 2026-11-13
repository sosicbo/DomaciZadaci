#1
class BankAccount:
    def __init__(self, owner, balance):
        self.owner=owner
        self.balance=balance

    def deposit(self, amount):
        if amount>0:
            self.balance += amount  
        return self    
      
    def withdraw(self,amount):
        if amount>0 and self.balance>=amount:
            self.balance-=amount
        return self
    def display_balance(self):
        print(self.balance)
    
account = BankAccount("Ana", 10000)
account.deposit(5000).withdraw(2000).deposit(1000)
account.display_balance()    

#2
class UserProfile:
    def __init__(self, username, email, city):
        self.username=username
        self.email=email
        self.city=city
        self.active=True

    def change_email(self, email):
        self.email=email
        return self
    def change_city(self, city):
        self.city=city
        return self
    def deactivate(self):
        self.active=False
        return self
    def activate(self):
        self.active=True
        return self   
    def display_info(self):
        print(self.username, self.email, self.city, self.active)
    
user = UserProfile("ana123", "ana@gmail.com", "Nis")
user.change_email("ana@yahoo.com").change_city("Beograd").deactivate()
user.display_info() 

#3
class Product:
    def __init__(self, name, price, quantity):
        self.name=name
        self.price=price
        self.quantity=quantity
    def change_price(self, new_price):
        if new_price>0:
            self.price=new_price
        return self    
    def add_stock(self, amount):
        if amount>0:
            self.quantity+=amount
        return self
    def sell(self, amount):
        if amount>0 and self.quantity>=amount:
            self.quantity-=amount
        return self
    def display_info(self):
        print (self.name, self.price, self.quantity)
product = Product("Laptop", 80000, 10)
product.change_price(75000).sell(2).add_stock(5).sell(3)
product.display_info()