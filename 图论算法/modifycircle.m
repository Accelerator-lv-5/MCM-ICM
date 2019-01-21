%*******************************************
%修改圈的子函数
%*******************************************
function [circle,long]=modifycircle(c1,L)
global a
flag=1;
while flag>0
    flag=0;
    for m=1:L-3
        for n=m+2:L-1
            if a(c1(m),c1(n))+a(c1(m+1),c1(n+1))<...
                    a(c1(m),c1(m+1))+a(c1(n),c1(n+1))
                flag=1;
                c1(m+1:n)=c1(n:-1:m+1);
            end
        end
    end
end
long=a(c1(1),c1(L));
for i=1:L-1
    long=long+a(c1(i),c1(i+1));
end
circle=c1;