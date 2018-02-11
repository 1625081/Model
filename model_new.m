
n;%time/5
%i,j languages
maxtime=15;
alpha=ones(10,10);
GDP=xlsread();
pop=xlsread('C:\Users\DRH\Desktop\数据(2)(1).xls',2,'');
alpha_cul = [0.9,0.6,0.7,0.5,0.8,0.5,0.2,0.8,0.7,0.5,0.8,0.1]; %文化自信参数已确定

%一个语言地区的cell数(取人口最大值)
for dtr=1:9%地区数
for n=1:15
    if(pop(n,dtr)>cellno(dtr))
        cellno(dtr)=pop(n,dtr);
    end
end
end
%确定一个cell里的密度den和社会压力矩阵
for i=1:10  %i指语言 
  for j=1:10
    if i<=5 && j<=5 % 前5位为统计出GDP的语言
      alpha(j,i)=GDP(n,j)/(GDP(n,i)+GDP(n,j));
    elseif (i<=5 && j>5) % 强国学弱国语言
      alpha(j,i)=.0001;
    elseif (i>5 && j>5) %弱国学弱国语言
      alpha(j,i)=.0001; %
    elseif (i>5 && j<=5)% 弱学强
      alpha(j,i)=1;
    end
  end
end

%culture
%这里多此一举了，直接把alpha_cul设置为一维数组就好，alpha_cul(中文)=0.90这样
%原CA模型中cul矩阵在此取消
%%%%%%%%%%%%%%%%%

% Native speaker
for dtr=1:9
k(dtr)=round(sqrt(cellno(dtr)));
if k(dtr)<sqrt(cellno(dtr))
    k(dtr)=k(dtr)+1;
end
end
N=cell(9,1);
Age=cell(9,1);
%i和dtr应有关系
%==初始化==%
%对地区重新编码：|| 语言编码不变
%1:东亚
%2:东南亚
%3 俄罗斯地区
%4 北非
%5 南亚
%6 欧洲
%7 北美
%8 南美
%9 澳洲
% 1955年各门语言在当地的权重，数据来自表格，用于初始化
W1 = [0.872820,0.127179];L1=[1,3];
W2 = [0.015186916,0.984813084];L2=[1,12];
W3 = [1]; L3=[10];
W4 = [1]; L4=[6];
W5 = [0.082163921,0.832214765,0.085621314]; L5=[8,5,7];
W6 = [0.386243386
0.219954649
0.328798186
0.065003779
].';L6=[2,4,11,9];
W7 = [1]; L7=[2];
W8 = [0.536693847,
0.463306153
].'; L8=[4,9];
W9 = [1];L9=[2];
cell_W = {W1,W2,W3,W4,W5,W6,W7,W8,W9};
cell_L = {L1,L2,L3,L4,L5,L6,L7,L8,L9};% Li为i地区语言集合
P = [ 7440
1860
1272
556
5377
3399
1875
1303
113
].';
for dtr=1:9
  N{dtr} = ones(k(dtr),k(dtr));
  Age{dtr} = zeros(k(dtr),k(dtr));
  count = 0;
  pop = P(dtr);
  for x0=1:k(dtr)
     for y0=1:k(dtr)
        N{dtr}(x0,y0) = randsrc(1,1,[cell_L{dtr}; cell_W{dtr}]);
        if count <= pop
            Age{dtr}(x0,y0) = randsrc(1,1,[ [0,10,20,30,40,50];[0.1,0.2,0.2,0.2,0.2,0.1] ]); %这个概率会让多余的人活下来
            if Age{dtr}(x0,y0) ~=0 % 然而初始化时总人口是有限制的
             count = count + 1; % 不能给多余的人活路
            end
        end
    end
  end
  %依据权重离散赋值
  %具体见 http://www.ilovematlab.cn/thread-234116-1-1.html
end

% ??? 88-90 意义不明 Second阵应该初始化为0
%Second speaker language j
S=cell(9,1);
S{dtr}=j*ones(k(dtr),k(dtr));

%gdp and population
for dtr=1:9
 SUMpop=pop(n,dtr)+SUMpop;
end
for dtr=1:9
    cellsum=cellno(dtr)+cellsum; % 有问题
end
for i=1:10
   for dtr=1:9
    for x=1:k(dtr)
        for y=1:k(dtr)
           if N{dtr}(x,y)==i
               cel(i)=cel(i)+1;
           end
        end
    end
   end
end
for i=1:10
    w(i)=cel(i)/cellsum;
end
% w(t,i)表示t时刻i语言的权重，不应该由人口计算，应该对N，S矩阵求和来计算。

%education
aledu=xlsread; %在一个地区内是常数

%immigrant
Imm=xlsread; % Imm为 地区数*时间数矩阵,存放这个时刻这个地区移入者数目
popim(dtr)= Imm(dtr,n);
popimlan(j,dtr)=popim(dtr)*w(j); %移入dtr区的j语言使用者

%travel&tech
for i=1:12
altrv(i)=GDP(i)*.00000001;
if rand(300,300)<altrv(i)
    dtr=randperm(9,1);
    i=randomperm(12,1);
    x=randperm(k(dtr),1);
    y=randperm(k(dtr),1);
    N{dtr}(x,y)=i;
end
end
%altech我觉得用指数衡量更好
Ptech=0.00001*exp(n);
if rand(300,300)<Pnet
    dtr=randperm(9,1);
    i=randomperm(12,1);
    x=randperm(k(dtr),1);
    y=randperm(k(dtr),1);
    N{dtr}(x,y)=i;
end


%当dtr=某定值时
for dtr=1:9 %对于一个地区来说

for n=1:maxtime
    
%考虑一个(x,y)格子的邻居 <= 未实现
learn_second = Age(x,y)<=60 && Age(x,y)>=10 && S{dtr}(x,y)==0;
learn_native = Age(x,y)<10 && Age(x,y)>0 && N{dtr}(x,y)==0;
if learn_second
    Neighbour{x,y}=[N{dtr}(x,y+1),N{dtr}(x+1,y),N{dtr}(x,y-1),N{dtr}(x-1,y),S{dtr}(x,y+1),S{dtr}(x+1,y),S{dtr}(x,y-1),S{dtr}(x-1,y)];
elseif learn_native
    Neighbour{x,y}=[N{dtr}(x,y+1),N{dtr}(x+1,y),N{dtr}(x,y-1),N{dtr}(x-1,y)];
end
if learn_second || learn_native
    data = Neighbour{x,y}(:);% data:8*1 double
    uniquedata=unique(data);
    out=zeros(length(uniquedata),3); % 语言 周围人数  Judge结果
    for ni=1:length(uniquedata)
        out(ni,1)=uniquedata(ni); %语言编号
        out(ni,2)=sum(data==uniquedata(ni)); % 说这门语言的人数
        LANG = out(ni,1); 
        out(ni,3)=out(ni,2)*(1-alcul(j,1))*aledu(dtr)*alpha(j,i); % Judge
    end % out: 语言数(<=8)*3 double
end

if learn_second  %没有学过外语的适龄学习者
    [max_LANG_value,position] = max(out(:,3)); %取judge结果
    max_LANG = out(position,1);
    %judge
    %judge(i)=N(i)*(1-alcul(i))*aledu*alpha(x,y)
    %alcul是以语言编号为下标的数组，存储的值是文化自信度
    %N(i)是格子周围说i语言的人数
    %AREA代表一个地区，也就是在一个地区内AREA是常数
    if(max_LANG_value>=T0 && max_LANG ~= N(x,y) )
        S{dtr}(x,y) = max_LANG;
    end
elseif learn_native  %没学过母语的幼儿
    [max_LANG_value,position] = max(out(:,2)); %取Nx最多的那个即可
    max_LANG = out(position,1);
    N{dtr}(x,y) = max_LANG;
elseif Age(x,y)>=80 %死亡处理
    % N(x,y)=0; 这里注释是为了考虑子承父业N(x,y)不改变
    Age(x,y)=1;
    S(x,y)=0;
end

%年龄矩阵更新
for x1=1:k(dtr)
    for y1=1:k(dtr)
        if (Age(x1,y1)~= 0)
            Age(x1,y1) = Age(x1,y1) + 1;
        end
    end
end

end

end



