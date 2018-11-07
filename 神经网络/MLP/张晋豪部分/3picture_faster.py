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
    # ax = fig.add_subplot(111, projection='3d')

    ax = Axes3D(fig)
    X = np.arange(a[0])
    Y = np.arange(a[1])

    X, Y = np.meshgrid(X, Y)
    Z = np.matrix(matrix)
    Z = np.transpose(Z)

    # 曲面图
    # ax.plot_surface(X, Y, Z, rstride=1, cstride=1, cmap=plt.get_cmap('rainbow'))
    # ax.contourf(X, Y, Z, zdir='z', offset=-2, cmap=plt.get_cmap('rainbow'))  # 投影
    # plt.savefig('surface_picture_name.png', bbox_inches='tight')

    # 散点图
    # y3 = np.arctan2(X, Y)
    # y3 = y3.reshape(1, -1)
    # y3 = y3[0][:]
    # y3 = y3[::-1]
    # ax.scatter(X, Y, Z, marker='.', c=y3)
    # plt.savefig('scatter_picture_name.png', bbox_inches='tight')

    plt.show()
