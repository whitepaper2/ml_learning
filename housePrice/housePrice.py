
# coding: utf-8 
## kaggle入门实例——房屋价格预测，回归问题
## 详细记录各种使用技巧
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt 
import seaborn as sns
import scipy.stats as stats
from scipy.stats import norm

frame = pd.DataFrame(np.random.randn(1000,5),columns=['a','b','c','d','e'])
#frame.iloc[::2] = np.nan
frame.plot.box()
plt.show()

df_train = pd.read_csv("./train.csv")
print(df_train.info())
 # summary,boxplot,hist
print(df_train["SalePrice"].describe())
plt.figure(1,)
df_train["SalePrice"].plot.box()
plt.figure(2)
plt.boxplot(df_train["SalePrice"])
plt.figure(3)
plt.hist(df_train["SalePrice"])
plt.show()
 # correlation matrix
corrmat = df_train.corr()
plt.figure()
f,ax = plt.subplots(figsize=(12,9))
sns.heatmap(corrmat, vmax=.8, square=True)
# top 10 largest variables
plt.figure()
k = 10
cols = corrmat.nlargest(k, "SalePrice")["SalePrice"].index
cm = np.corrcoef(df_train[cols].values.T)
sns.set(font_scale=1.25)
hm = sns.heatmap(cm, cbar=True, annot=True,square=True,fmt=".2f",annot_kws={"size":10},yticklabels=cols.values,xticklabels=cols.values)
plt.show()
 # misssing data
total = df_train.isnull().sum().sort_values(ascending=False)
percent = (df_train.isnull().sum()/df_train.isnull().count()).sort_values(ascending=False)
missing_data = pd.concat([total,percent],axis=1,keys=["Total","Percent"])
missing_data.head(20)
# deal with missing data
df_train = df_train.drop((missing_data[missing_data["Total"]>1]).index,1)
df_train = df_train.drop(df_train.loc[df_train["Electrical"].isnull()].index)
print(df_train.shape)
 # outlier
var = 'GrLivArea'
data = pd.concat([df_train["SalePrice"],df_train[var]],axis=1)
data.plot.scatter(x=var,y="SalePrice",ylim=(0,800000))
plt.show()
#deleting points
df_train.sort_values(by="GrLivArea", ascending=False)[:2]
df_train.drop(df_train[df_train["Id"]==1299].index)
df_train.drop(df_train[df_train["Id"]==524].index)
 #histogram and normal probability plot

#applying log transformation
# df_train['SalePrice'] = np.log(df_train['SalePrice'])
sns.distplot(df_train['SalePrice'], fit=norm)
fig = plt.figure()
stats.probplot(df_train['SalePrice'])
plt.figure()
#scatter plot
plt.scatter(df_train['GrLivArea'], df_train['SalePrice'])
#data transformation
df_train['GrLivArea'] = np.log(df_train['GrLivArea'])
plt.show()
df_train["enc_street"] = pd.get_dummies(df_train["Street"], drop_first = True)
print(df_train[df_train["enc_street"]==0])
column=np.array(["buying","maint","doors","persons","lug_boot","safety","label"])
car_data = pd.read_csv("./data.txt",names=column)

#class_mapping = {label:idx for idx,label in enumerate(set(df['class label']))}  

label_mapping = {
        'unacc':1, 
        'acc':2,
        'good':3, 
        'vgood':4
    }
persons_mapping = {
        '2':1,
        '4':2,
        'more':3
    }
car_data["persons"] = car_data["persons"].map(persons_mapping)
car_data["label"] = car_data["label"].map(label_mapping)
enc_car_data = pd.get_dummies(car_data)
print(enc_car_data) 
