clc,clear;

a=zeros(7);
nodes_name={'A','B1','B2','C1','C2','C3','D'};
start=1
termination=7;

a(1,2)=2;
a(1,3)=4;
a(2,4)=3;
a(2,5)=3;
a(2,6)=1;
a(3,4)=2;
a(3,5)=3;
a(3,6)=1;
a(4,7)=1;
a(5,7)=3;
a(6,7)=4;
a=a+a';
a(a==0)=inf;
pb(1:length(a))=0;
pb(1)=1;
index1=1;
index2=ones(1,length(a));
d(1:length(a))=inf;
d(1)=0;
temp=1;
while sum(pb)<length(a)
    tb=find(pb==0);
    d(tb)=min(d(tb),d(temp)+a(temp,tb));
    tmpb=find(d(tb)==min(d(tb)));
    temp=tb(tmpb(1));
    pb(temp)=1;
    index1=[index1,temp];
    temp2=find(d(index1)==d(temp)-a(temp,index1));
    index2(temp)=index1(temp2(1));
end
d; %最短通路的值
index1; %标号顶点顺序（依次加入的顺序）
index2; %存放始点到第i 点最短通路中第i 顶点前一顶点的序号；
path=[termination]
now=index2(termination)
path=[now path];
while now~=start
    now=index2(now)
    path=[now path];
end
path