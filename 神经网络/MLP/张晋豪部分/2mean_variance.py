import pandas as pd
import pickle

if __name__ == '__main__':
    f = open('test.pkl', 'rb')
    df = pickle.load(f)
    # 迭代器
    # 行方差均值
    for index, row in df.iterrows():
        std = row.std()
        mean = row.mean()
        df.loc[index, "std"] = std
        df.loc[index, "mean"] = mean
    print(df)

    # 列方差均值
    std_dict = dict()  # 方差字典
    mean_dict = dict()  # 均值字典
    for column in df.columns:
        std_dict[column] = df[column].std()
        mean_dict[column] = df[column].mean()
    print('方差数组 ', std_dict)
    print('均值数组 ', mean_dict)
