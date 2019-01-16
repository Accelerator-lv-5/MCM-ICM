clc,clear
% % data=unifrnd(0,1,11,9);
% fid=fopen('sj.txt','r');
% % [row,col]=size(data);
% row=25;
% col=8;
% data=[];
% for i=1:row
%     tmp=str2num(fgetl(fid));
%     data=[data;tmp];
% end
% stdr=std(data);%计算各列方差
% sddata=data./stdr(ones(row,1),:);%标准化变换
% [p,princ,egenvalue]=princomp(sddata);%调出主成分
% p=p(:,1:3);%输出前三主成分系数
% sc=princ(:,1:3);%前三主成分量
% egenvalue%相关系数矩阵的特征值，即各主成分所占比例
% per=100*egenvalue/sum(egenvalue)%各个主成分所占百分比；
X=[4.0 3.1 1.5 6.0
    5 -2 3.2 -6 
    1.0 0.5 0.1 9
    10 2 1.0 3
    1,4,-1.2,0.8];
x=zscore(X);
[coef,score,eig,t]=princomp(x);   %利用princomp处理矩阵

t;                                 %每一组数据在新坐标下到原点的距离
s=0;
i=1;
while s/sum(eig)<0.85
    s=s+eig(i);
    i=i+1;
end                              %获得累计贡献率大于85%几组数据
NEW=x*coef(:,1:i-1);              %输出新的数据
figure
pareto(eig/sum(eig));          %输出贡献率直方图
coef(:,1:i-1)