
n;%time/5
%i,j languages
maxtime=15;
%%%%%%%%%%%%%%%%%这部分我没看
alpha=ones(10,10);
GDP=xlsread();
pop=xlsread('C:\Users\DRH\Desktop\数据(2)(1).xls',2,'');
for n=1:maxtime
%一个语言地区的cell数(取人口最大值)
for dtr=1:9%地区数
for n=1:15;
    if(pop(n,dtr)>cellno(dtr))
        cellno(dtr)=pop(n,dtr);
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
alcul=xlsread;
cul=ones(10,10);
for i=1:10
    for j=1:10
        cul(j.i)=alcul(i)/alcul(j);
    end
end
%%%%%%%%%%%%%%%%%

%Native speaker
for dtr=1:9
k(dtr)=round(sqrt(cellno(dtr)));
if k(dtr)<sqrt(cellno(dtr))
    k(dtr)=k(dtr)+1;
end
end
N=cell(9,1);
%i和dtr应有关系
for i=1:12
    for dtr=1:9
        if(i==1&&dtr==1)|(i==2&dtr==2)|(i==3&&dtr==3)|(i==5&&dtr==5)|(i==6&&dtr==6)|(i==9&&dtr==7)|(i==10&&dtr==8)|(i==4&&dtr==4)|(i==12&&dtr==9)
           N{dtr}=i*ones(k(dtr),k(dtr));
        end
    end
end
%特别的当取印度地区
Plang7=0.01%瞎写
Plang8=0.01
if dtr==5
    if rand(k(dtr),k(dtr))<Plang7
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=7;
    end
    if rand(k(dtr),k(dtr))<Plang8
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=8;
    end
end
%欧洲、
Plang9=0.01%瞎写
Plang11=0.01
Plang2=0.01
if dtr==4
    if rand(k(dtr),k(dtr))<Plang9
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=9;
    end
    if rand(k(dtr),k(dtr))<Plang11
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=11;
    end
    if rand(k(dtr),k(dtr))<Plang2
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=2;
    end
end
%马来西亚、
Plang1=0.01
if dtr==9
    if rand(k(dtr),k(dtr))<Plang1
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=1;
    end
end
%南美类似
Plang4=0.01
if dtr==7
    if rand(k(dtr),k(dtr))<Plang4
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=4;
    end
end
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
    w(i)=cel(i)\cellsum;
end
% w(t,i)表示t时刻i语言的权重，不应该由人口计算，应该对N，S矩阵求和来计算。

%education
aledu=xlsread; %在一个地区内是常数

%immigrant
Imm=xlsread;
% 移民率也应该与时间n有关
popim(dtr)= %(pop(n,dtr)-pop(n-1,dtr))*Cimm(n,i);
popimlan(j,dtr)=popimm(dtr)*w(j);%移入i语言区的j语言使用者

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
for dtr=1:9

%考虑一个(x,y)格子的邻居
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
        out(ni,3)=out(ni,2)*(1-cul(j,1))*aledu(dtr)*alpha(j,i); % Judge
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

end
end
end



