## 2018数学建模美赛 MCM

### 代码
1. 数据处理
  - 读取xls，保存为pkl(pandas.DataFrames) √
  - 预处理：去除异常点、标准化、PCA、白化、再保存为pkl
  - 数据增强

2. 可视化
   - 类别统计
   - 每个维度的数据的均值、方差
   - 整个数据做三维图（标准化前后、白化前后、数据增强前后）
   - 分类结果的ROC、混淆矩阵
   - loss下降的过程、acc上升的过程

3. MLP
   - BatchNormalization √
   - ReLU √
   - Dropout √
   - 任意深度、宽度 √

### 参考
[tensorflow/models](https://github.com/tensorflow/models/tree/master/samples/core/get_started)

### 论文支撑
《Batch Normalization: Accelerating Deep Network Training by Reducing Internal Covariate Shift》 https://arxiv.org/abs/1502.03167

《The loss surface of deep and wide neural networks》 https://arxiv.org/abs/1704.08045

《Deep Sparse Rectifier Neural Networks》 https://wenku.baidu.com/view/7822feb5770bf78a65295450.html

《Improving neural networks by preventing co-adaptation of feature detectors 》 https://arxiv.org/abs/1207.0580

《Dropout: A Simple Way to Prevent Neural Networks from Overfitting》 http://www.cs.toronto.edu/~rsalakhu/papers/srivastava14a.pdf

《Understanding the difficulty of training deep feedforward neural networks》 https://www.researchgate.net/publication/215616968_Understanding_the_difficulty_of_training_deep_feedforward_neural_networks