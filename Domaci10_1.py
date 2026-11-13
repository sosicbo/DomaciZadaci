# 1. Analiza rezultata utakmica
# 1.Pronaći sve utakmice u kojima su oba tima postigla bar po jedan gol.
import pandas as pd
R = '/Volumes/bootcamp/nothern_star/raw_2025_26/'
m=pd.read_parquet(R+'matches_2025_26.parquet')

len(m.loc[(m['home_goals']>0) & (m['away_goals']>0)]) #178
m.loc[(m['home_goals']>0) & (m['away_goals']>0)]

# 2.Pronaći sve utakmice u kojima je domaćin pobedio sa tačno jednim golom razlike.
len(m.loc[(m['home_goals']>m['away_goals']) & ((m['home_goals']-m['away_goals'])==1)]) #105
#ili jednostavnije
len(m.loc[(m['home_goals']-m['away_goals'])==1])

# 3.Koliko utakmica je završeno rezultatom 0:0?
len(m.loc[(m['home_goals']==0) & (m['away_goals']==0)]) #26

# 4.Prikazati 10 utakmica sa najviše ukupno postignutih golova
m['total']=m['home_goals']+m['away_goals']
m.sort_values('total', ascending=False).head(10)

# 2. Analiza jednog tima
# Za tim po izboru:
# 1.Prikazati sve utakmice u kojima je učestvovao.
len(m.loc[(m['home_team']=='IVU') | (m['away_team']=='IVU')]) #38

# 2.Koliko je puta pobedio, izgubio i odigrao nerešeno?
team_ivu=m.loc[(m['home_team']=='IVU') | (m['away_team']=='IVU')]
domacin=team_ivu['home_team']=='IVU'
gost=team_ivu['away_team']=='IVU'

pobeda=((domacin & (team_ivu['home_goals']>team_ivu['away_goals'])) |(gost & (team_ivu['home_goals']<team_ivu['away_goals']))).sum() 
nereseno=(team_ivu['home_goals']==team_ivu['away_goals']).sum()
porazi=len(team_ivu)-pobeda-nereseno

print('Pobeda:', pobeda) #19
print('Nereseno:', nereseno) #6
print('Porazi:', porazi) #13

# 3.Koliko je golova postigao kao domaćin, a koliko kao gost?
gol_domacin=team_ivu.loc[domacin, 'home_goals'].sum()
gol_gost=team_ivu.loc[gost, 'away_goals'].sum()

print('Gol kao domacin:', gol_domacin) #44
print('Gol kao gost:', gol_gost) #21

# 4.Pronaći utakmicu u kojoj je postigao najviše golova.
team_ivu=team_ivu.copy()

team_ivu['ivu_goals']=team_ivu['home_goals']
team_ivu.loc[gost, 'ivu_goals']= team_ivu['away_goals']

najvise=team_ivu.sort_values('ivu_goals', ascending=False).head(1)
najvise[['home_team', 'away_team', 'home_goals', 'away_goals', 'ivu_goals']]

# 3. Analiza stadiona
# 1.Prikazati sve različite stadione na kojima su odigrane utakmice.
stadioni=m['stadium'].unique()
len(stadioni)
print(stadioni)

# 2.Pronaći stadion na kojem je odigrano najviše utakmica.
broj_meceva=m['stadium'].value_counts()
print(broj_meceva.head(1))

#3.Za svaki stadion izračunati prosečnu posećenost.
prosek_posecenost=m.groupby('stadium')['attendance'].mean()
print(prosek_posecenost)

# 4.Prikazati pet stadiona sa najvećom prosečnom posećenošću.
prosek_posecenost.sort_values(ascending=False).head(5)
