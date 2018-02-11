clear all;
n=0;%time/5
%i,j languages
maxtime=
%%%%%%%%%%%%%%%%%这部分我没看
alpha=ones(10,10);
GDP=xlsread();
pop=xlsread('C:\Users\DRH\Desktop\数据(2)(1).xls',2,'');
for n=0;maxtime
%一个语言地区的cell数(取人口最大值)
i=
cellno=0;
for n=
    if(pop(n,i)>cellno)
        cellno=pop(n,i)
    end
end
%确定一个cell里的密度den和社会压力矩阵
for i=0:9
 den(i)=pop(n,i)/cellno;
  for j=0:9
    if i<5
      alpha(j,i)=den(i)*GDP(n,j)/GDP(n,i);
    else
      alpha(j,i)=den(i);
      alpha(i,j)=.1*den(j);
    end
  end
end

%culture
alcul=xlsread;
cul=ones(10,10);
for i=0:9
    for j=0:9
        cul(j.i)=alcul(i)/alcul(j);
    end
end
%%%%%%%%%%%%%%%%%

%Native speaker
int k;
k=round(sqrt(cellno));
if k<sqrt(cellno)
    k=k+1;
end
N=i*ones(k,k);
%特别的当取印地语和孟加拉时
Plang=
if i==
    if rand(k,k)<Plang
        x=rand()
        y=rand()
        N(x,y)=
    end
end

%Second speaker language j
S=j*ones(k,k);

%gdp and population
for i=0:9
 SUMpop+=pop(n,i);
end
for i=0:9
    w(i)=sum(N,S) % 有问题
end
% w(t,i)表示t时刻i语言的权重，不应该由人口计算，应该对N，S矩阵求和来计算。

%education
aledu=xlsread; %在一个地区内是常数

%immigrant
Cimm=xlsread;
% 移民率也应该与时间n有关
popim(i)=(pop(i)-pop'(i))*Cimm(n,i);
popim(j,i)=popimm(i)*w(j);

%travel&tech
altrv(i)=GDP(i)*.0001;
altech(i)=exp(n)/100; %瞎写的；%
%altech我觉得用指数衡量更好



%考虑一个(x,y)格子的邻居
Neighbour{x,y}=[N(x,y+1),N(x+1,y),N(x,y-1),N(x-1,y),S(x,y+1),S(x+1,y),S(x,y-1),S(x-1,y)];
data = Neighbour{x,y}(:);% data:8*1 double
uniquedata=unique(data);
out=zeros(length(uniquedata),3); % 语言 周围人数  Judge结果
for ni=1:length(uniquedata)
out(ni,1)=uniquedata(ni); %语言编号
out(ni,2)=sum(data==uniquedata(ni)); % 说这门语言的人数
LANG = out(ni,1); 
out(ni,3)=out(ni,2)*(1-alcul(N(i,j)))*aledu(AREA)*alpha_pressure(LANG,N(i,j)); % Judge
end % out: 语言数(<=8)*3 double
[max_LANG_value,position] = max(out(:,3));
max_LANG = out(position,1);
%judge
%judge(i)=N(i)*(1-alcul(i))*aledu*alpha(i,j)
%alcul是以语言编号为下标的数组，存储的值是文化自信度
%N(i)是格子周围说i语言的人数
%AREA代表一个地区，也就是在一个地区内AREA是常数

if(max_LANG_value>=T0 && Age(i,j)<=60 && Age(i,j)>=18 && max_LANG ~= N(i,j) )
   S(i,j) = max_LANG;
end
n++;
end



