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
% stdr=std(data);%������з���
% sddata=data./stdr(ones(row,1),:);%��׼���任
% [p,princ,egenvalue]=princomp(sddata);%�������ɷ�
% p=p(:,1:3);%���ǰ�����ɷ�ϵ��
% sc=princ(:,1:3);%ǰ�����ɷ���
% egenvalue%���ϵ�����������ֵ���������ɷ���ռ����
% per=100*egenvalue/sum(egenvalue)%�������ɷ���ռ�ٷֱȣ�
X=[4.0 3.1 1.5 6.0
    5 -2 3.2 -6 
    1.0 0.5 0.1 9
    10 2 1.0 3
    1,4,-1.2,0.8];
x=zscore(X);
[coef,score,eig,t]=princomp(x);   %����princomp�������

t;                                 %ÿһ���������������µ�ԭ��ľ���
s=0;
i=1;
while s/sum(eig)<0.85
    s=s+eig(i);
    i=i+1;
end                              %����ۼƹ����ʴ���85%��������
NEW=x*coef(:,1:i-1);              %����µ�����
figure
pareto(eig/sum(eig));          %���������ֱ��ͼ
coef(:,1:i-1)