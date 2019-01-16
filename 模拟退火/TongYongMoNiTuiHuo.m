clc, clear

counts=80;
e=0.1^30;
L=20000;
at=0.999;
T=1;

%对应x y坐标
load sj.txt
x=sj(:,1:2:8);
x=x(:);
y=sj(:,2:2:8);
y=y(:);
sj=[x y];
d1=[70,40];
sj0=[d1;sj;d1];
%距离矩阵
sj=sj0;
d=zeros(counts+2);
for i=1:(counts+1)
    for j=i+1:(counts+2)
        temp=sqrt((sj(i,1)-sj(j,1))^2+(sj(i,2)-sj(j,2))^2);
        d(i,j)=temp;
    end
end
d=d+d';
S0=[];Sum=inf;
rand('state',sum(clock));
for j=1:1000
    S=[1 1+randperm(counts),counts+2];
    temp=0;
    for i=1:(counts+1)
        temp=temp+d(S(i),S(i+1));
    end
    if temp<Sum
        S0=S;
        Sum=temp;
    end
end
%退火过程
for k=1:L
    %产生新解
    c=2+floor(counts*rand(1,2));
    c=sort(c);
    c1=c(1);
    c2=c(2);
    %计算代价函数值
    df=d(S0(c1-1),S0(c2))+d(S0(c1),S0(c2+1))-d(S0(c1-1),S0(c1))-d(S0(c2),S0(c2+1));
    %接受准则
    if df<0
        S0=[S0(1:c1-1),S0(c2:-1:c1),S0(c2+1:(counts+2))];
        Sum=Sum+df;
    elseif exp(-df/T)>rand(1)
        S0=[S0(1:c1-1),S0(c2:-1:c1),S0(c2+1:(counts+2))];
        Sum=Sum+df;
    end
    T=T*at;
    if T<e
        break;
    end
end
%输出巡航路径及路径长度
xx=sj0(S0,1);
yy=sj0(S0,2);
plot(xx,yy,'-o');
S0
Sum
