clc,clear
%生命游戏
%原则：
% 如果一个细胞周围有3个细胞为生（一个细胞周围共有8个细胞），则该细胞为生（即该细胞若原先为死，则转为生，若原先为生，则保持不变） 。
% 如果一个细胞周围有2个细胞为生，则该细胞的生死状态保持不变；
% 在其它情况下，该细胞为死（即该细胞若原先为生，则转为死，若原先为死，则保持不变）。

m=30;
n=30;
p=0.7;
h=100;
life=2;
for x=1:m
    for y=1:n
        r=rand(1);
        if r>p
            a(x,y)=1;
        else
            a(x,y)=0;
        end
    end
end
for x=1:m
    for y=1:m
        if a(x,y)==1
            fx=[x-1,x-1,x,x];
            fy=[y-1,y,y,y-1];
            fill(fx,fy,'g'),hold on
        end
    end
end
for k=1:h
    fx=[0,m,m,0];
    fy=[0,0,n,n];
    fill(fx,fy,'k'),hold on
    for x=2:m-1
        for y=2:n-1
            b(x,y)=a(x-1,y-1)+a(x-1,y)+a(x-1,y+1)+a(x,y-1)+a(x+1,y-1)+a(x+1,y)+a(x+1,y+1);
            if b(x,y)==life
                c(x,y)=a(x,y);
            elseif b(x,y)==life+1
                c(x,y)=1;
            else
                c(x,y)=0;
            end
        end
    end
    c(1:m,1)=a(1:m,1);
    c(1:m,n)=a(1:m,n);
    for x=1:m
        for y=1:n
            if c(x,y)==1
                fx=[x-1,x-1,x,x];
                fy=[y-1,y,y,y-1];
                fill(fx,fy,'g'),hold on
            else
            end
        end
    end
    pause(0.01)
    a=c;
end

            