# coding:utf-8
from __future__ import print_function
import pandas as pd

xls_path = 'test.xlsx'
save_path = 'test.pkl'

def xls2pkl():
    global xls_path, save_path
    print('beging function: xls2pkl().')
    print('converting file: ', xls_path, ' to ', save_path)
    xls_file = pd.ExcelFile(xls_path)
    xls_df = pd.read_excel(xls_file)
    xls_df.to_pickle(save_path)
    print('convert finish.')

def test_xls2pkl():
    import pickle
    xls2pkl()
    with open(save_path, 'rb') as f:
        data = pickle.load(f)
        print(type(data))
        print(len(data))
        print(data)

if __name__ == '__main__':
    test_xls2pkl()