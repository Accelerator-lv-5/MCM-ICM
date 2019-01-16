clc,clear
fid=fopen('txt3.txt','r');
n1=6;n2=3;
a=[];
for i=1:n1
    tmp=str2num(fgetl(fid));
    a=[a;tmp];
end
for i=1:n1
    str1=char(['b',int2str(i),'=[];']);
    str2=char(['b',int2str(i),'=[b',int2str(i),';tmp];']);
    eval(str1);
    for j=1:n2
        tmp=str2num(fgetl(fid));
        eval(str2);
    end
end
ri=[0,0,0.58,0.90,1.12,1.24,1.32,1.41,1.45];
[x,y]=eig(a);
lamda=max(diag(y));
num=find(diag(y)==lamda);
w0=x(:,num)/sum(x(:,num));
cr0=(lamda-n1)/(n1-1)/ri(n1);
for i=1:n1
    [x,y]=eig(eval(char(['b',int2str(i)])));
    lamda=max(diag(y));
    num=find(diag(y)==lamda);
    w1(:,1)=x(:,num)/sum(x(:,num));
    cr1(i)=(lamda-n2)/(n2-1)/ri(n2);
end
cr1%每个属性的检验值，小于0.1均可接受
w0%每个属性的权重矩阵
cr=cr1*w0%模型整体的检验值，小于0.1均可接受
a=[0.1365 0.0974 0.2426 0.2790 0.4667 0.7986;0.6250 0.3331 0.0879 0.6491 0.4667 0.1049;0.2385 0.5695 0.6694 0.0719 0.0667 0.0965];
a*w0

