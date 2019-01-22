# encoding=utf-8
import numpy as np
import pandas as pd
file_name = 'testdata.csv'
data = pd.read_csv(file_name, header=None)
rows, cols = data.shape
# array = np.zeros((rows, cols))
nparray = np.array(data).T
array = pd.DataFrame(nparray)
array = array.values.tolist()

cols -= 2  # 结尾两列是空的
array_temp = [['' for i in range(rows)] for i in range(rows)]


def printf(row, id):
    for i in range(rows):
        array_temp[i][i] = '1'
    for i in range(rows):
        for j in range(i, rows):
            result = row[j]-row[i]
            if result == 1:
                array_temp[i][j] = '2'
                array_temp[j][i] = '1/2'
            elif result == -1:
                array_temp[i][j] = '1/2'
                array_temp[j][i] = '2'
            elif result > 0:
                a = '1/'+str(result)
                array_temp[i][j] = str(result)
                array_temp[j][i] = a
            elif result < 0:
                result = -result
                a = '1/'+str(result)
                array_temp[i][j] = ''
                array_temp[i][j] = a
                array_temp[j][i] = str(result)
    for i in array_temp:
        for j in i:
            print('%s' % j, end=' ')
        print()
    # xx=np.array(array_temp)
    # print(xx.shape)

for id in range(len(array)):
    printf(array[id], id)
