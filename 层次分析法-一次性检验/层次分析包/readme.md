# 层次分析包使用说明

## 流程
1. 将m个对象n个属性的矩阵数据放入 testdata.xlsx 文件中
2. 将 testdata.xlsx 文件转换为 testdata.csv 文件
3. 运行 AHP对冲参数.py 文件，标准输出中打印每个属性的层次分析相对重要性矩阵（n个m阶方阵之间不空行）
4. 复制输出的n个m阶方阵至 cuiruo.txt 文件的下半部分。cuiruo.txt 上半部分可借助excel导出csv，由主观输入属性间相对权值生成。
5. 用 MATLAB 执行 AHP_xiaosai.m 文件，输出各属性的权值