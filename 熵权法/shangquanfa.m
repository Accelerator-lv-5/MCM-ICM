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
%��һ��
for i=1:row
    data_norm(i,:)=data(i,:)/sum(data(i,:));
end
data_norm_entropy=zeros(col,1);
%���ָ�����Ϣ��
for i=1:col
    data_norm_entropy(i)=-1/log(row)*sum(data_norm(i,:).*log(data_norm(i,:)));
end
%�����ָ���Ȩ��
W=(1-data_norm_entropy)./(col-data_norm_entropy);
%��������
result=data*W;
[sort_result,index]=sort(result,'DESCEND');
sort_result;
index;
