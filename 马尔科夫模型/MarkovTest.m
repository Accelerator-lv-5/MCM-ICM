clc,clear
%P为状态转移矩阵
%五种状态——濒危 脆弱 中等 健壮 鲁棒

%可通过蒙特卡洛模拟的方式获取该矩阵
%初始状态转移矩阵
% P=[1   0   0   0   0
%    0.2 0.6 0.2 0   0
%    0   0.1 0.8 0.1 0
%    0   0   0.5 0   0.5
%    0   0   0   0   1];

%化为标准形式
P=[1   0   0   0   0
   0   1   0   0   0
   0.2 0   0.2 0   0.6
   0   0   0.8 0.1 0.1
   0   0.5 0.5 0   0
   ];
%标准形式P=[I O
%          R S]

[row,column]=size(P);
n=2;%单位阵的行列
I=eye(row-n);
R=P(n+1:row,1:n);
S=P(n+1:row,n+1:column);
%基矩阵F  
%F中的每个元素，表示从一个非吸收状态出发，过程到达每个非吸收状态的平均转移次数。
F=(I-S)^-1;

%初始状态（在S中某一行）
start_condition_nonterminal=2;
%结束（获胜或失败，也在S中某一行）
end_condition_nonterminal=2;
%结束（获胜或失败，在I即P-S中某一行）
end_condition_terminal=2;

for i=1:row-n
    line=sprintf('进入状态%d的平均次数为%f',i,F(start_condition_nonterminal,i));
    disp(line);
end
C=ones(1,row-n)';
%N的每个元素表示从非吸收状态出发，到达某个吸收状态被吸收之前的平均转移次数。
N=F*C;

line=sprintf('最终结束所需的平均变化次数为%f',N(end_condition_nonterminal));
disp(line);
%Bij 表示从非吸收状态i 出发，被吸收状态 j 吸收的概率。
B=F*R;
line=sprintf('最后获胜的概率为%f',B(start_condition_nonterminal,end_condition_terminal));
disp(line);