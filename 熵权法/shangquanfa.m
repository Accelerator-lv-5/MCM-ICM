clc,clear
% data=unifrnd(0,1,11,9);
fid=fopen('sj.txt','r');
% [row,col]=size(data);
row=25;
col=8;
data=[];
for i=1:row
    tmp=str2num(fgetl(fid));
    data=[data;tmp];
end

data_norm=zeros(row,col);
%归一化
for i=1:row
    data_norm(i,:)=data(i,:)/sum(data(i,:));
end
data_norm_entropy=zeros(col,1);
%求各指标的信息熵
for i=1:col
    data_norm_entropy(i)=-1/log(row)*sum(data_norm(i,:).*log(data_norm(i,:)));
end
%计算各指标的权重
W=(1-data_norm_entropy)./(col-data_norm_entropy);
%进行评分
result=data*W;
[sort_result,index]=sort(result,'DESCEND');
sort_result;
index;
