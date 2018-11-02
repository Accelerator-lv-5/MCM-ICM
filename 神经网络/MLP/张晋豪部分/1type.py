import pandas as pd
import pickle

if __name__ == '__main__':
    f = open('test.pkl', 'rb')
    df = pickle.load(f)
    # pandas获取某一列
    # print(text['Amount'])

    # 类别统计
    # 按照'V28'进行分类统计
    group = df.groupby(by=['V28'])

    # 打印类别结果
    # print(group.size())

    # 转化为DataFrame结构
    newGroup = pd.DataFrame(group.size())
    # 更新最后新增加的列名为times次数
    newGroup.rename(columns={0: 'times'}, inplace=True)
    # 打印分类结果
    print(newGroup)
