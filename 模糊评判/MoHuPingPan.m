clc,clear
format short
load mohu2.txt
sj=[repmat(mohu2(:,1),1,3),mohu2(:,2:end)];
%首先进行归一化处理
n=size(sj,2)/3;m=size(sj,1);
w=[0.5*ones(1,3),0.125*ones(1,12)];
w=repmat(w,m,1);
y=[];
for i=1:n
    tm=sj(:,3*i-2:3*i);
    max_t=max(tm);
    max_t=repmat(max_t,m,1);
    max_t=max_t(:,3:-1:1);
    yt=tm./max_t;yt(:,3)=min([yt(:,3)';ones(1,m)]);
    y=[y,yt];
end
%下面求模糊决策矩阵
r=[];
for i=1:n
    tm1=y(:,3*i-2:3*i);tm2=w(:,3*i-2:3*i);
    r=[r,tm1.*tm2];
end
%求 M＋、 M－和距离
mplus=max(r);mminus=min(r);
dplus=dist(mplus,r');dminus=dist(mminus,r');
%求隶属度
mu=dminus./(dplus+dminus);
[mu_sort,ind]=sort(mu,'descend')