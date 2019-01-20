clc,clear
a=[390.6,412,320,559.2,380.8,542.4,553,310,561,300,632,540,406.2,313.8,576,587.6,318.5]';
t0=find(a<=320);
t1=cumsum(t0);n=length(t1);
B=[-0.5*(t1(1:end-1)+t1(2:end)),ones(n-1,1)];Y=t0(2:end);
r=B\Y;
y=dsolve('Dy+a*y=b','y(0)=y0');
y=subs(y,{'a','b','y0'},{r(1),r(2),t1(1)});
digits(6),y=vpa(y); %为提高预测精度，先计算预测值，再显示微分方程的解
fy=inline(y,'t');
yuce1=[0,fy(0:10)];
yuce=diff(yuce1)%预测结果