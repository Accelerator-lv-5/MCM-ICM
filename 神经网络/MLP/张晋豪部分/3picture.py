import random
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import pandas as pd
import pickle

# 参考 https://www.cnblogs.com/xingshansi/p/6777945.html
if __name__ == '__main__':
    f = open('test.pkl', 'rb')
    df = pickle.load(f)

    # 转为二维矩阵
    matrix = df.values
    # 获取矩阵维度
    a = matrix.shape


    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    # 散点图
    for i in range(a[0]):
        for j in range(a[1]):
            ax.scatter(i, j, matrix[i][j])

    # 柱状图
    #a[0]行
    #a[1]列
    # for z in range(a[0]):
    #     xs = np.arange(a[1])#一行内的下标
    #     ys = matrix[z]#取一行数据
    #     ax.bar(xs, ys, z, zdir='x', alpha=0.8)
    # #此时X代表每一行 Y代表每个属性 Z代表表格数据向上
    # ax.set_xlabel('X')
    # ax.set_ylabel('Y')
    # ax.set_zlabel('Z')

    plt.show()
