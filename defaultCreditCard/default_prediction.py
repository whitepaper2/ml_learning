# data:https://archive.ics.uci.edu/ml/machine-learning-databases/00350/default of credit card clients.xls
import os
import re

import matplotlib.pyplot as plt
import pandas as pd

# defaults
plt.rcParams['figure.figsize'] = (20.0, 8.0)
plt.rcParams.update({'font.size': 10})
plt.rcParams['xtick.major.pad'] = '5'
plt.rcParams['ytick.major.pad'] = '5'

plt.style.use('ggplot')
# 检查目录、文件是否存在
data_dir = './dataset'
if not os.path.exists(data_dir):
    os.makedirs(data_dir)
filename = os.path.join(data_dir, 'default of credit card clients.xls')
if not os.path.isfile(filename):
    # wget.download(url,filename)
    pass
df = pd.read_excel(filename, header=1)  # skip the first line
#################### 01.explore data
# print(dir(df))
# print(df.columns)
df.columns = [x.lower() for x in df.columns]  # convert to lower
df = df.rename(index=str, columns={'pay_0': 'pay_1'})  # column's name occur error
# print(df.head()) # scan the top 5 lines
# print(df.dtypes)  # scan data type
df = df.drop('id', axis=1)
df['target'] = df['default payment next month'].astype('category')
# writer = pd.ExcelWriter('./output/summary.xlsx')
# df.describe().to_excel(writer,'summary') # scan data distribution,missing\std\mean\min\max
################### 011.discrete data
fig = plt.figure()
fig.set_size_inches(5, 5)
d = df.groupby(['target']).size()
print("default accounts {}% of {} observations".format(100 * d[1] / (d[1] + d[0]), d[1] + d[0]))
d.plot(kind='bar', color='orange')
# print(df['education'].value_counts())  # scan data range, rename
df['sex'] = df['sex'].astype('category').cat.rename_categories(['M', 'F'])
df['marriage'] = df['marriage'].astype('category').cat.rename_categories(['na', 'married', 'single', 'other'])
df['age_cnt'] = pd.cut(df['age'], range(0, 100, 10), right=False)
fig, ax = plt.subplots(1, 3)
fig.set_size_inches(20, 5)
fig.suptitle('target VS variable')
d = df.groupby(['target', 'sex']).size()
p = d.unstack(level=1).plot(kind='bar', ax=ax[0])
d = df.groupby(['target', 'marriage']).size()
p = d.unstack(level=1).plot(kind='bar', ax=ax[1])
d = df.groupby(['target', 'age_cnt']).size()
p = d.unstack(level=1).plot(kind='bar', ax=ax[2])
# frequency distribution
pattern = re.compile("^pay_[0-9]+$")
pay_status_columns = [x for x in df.columns if pattern.match(x)]
fig, ax = plt.subplots(2, 3)
fig.set_size_inches(15, 5)
fig.suptitle("discrete frequency-pay")
for i in range(len(pay_status_columns)):
    row, col = int(i / 3), i % 3
    d = df[pay_status_columns[i]].value_counts()
    ax[row, col].bar(d.index, d, align="center", color='g')
    ax[row, col].set_title(pay_status_columns[i])
plt.show()
