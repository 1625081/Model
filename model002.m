clear all;
n=0;%time/5
%i,j languages
maxtime=
%%%%%%%%%%%%%%%%%�ⲿ����û��
alpha=ones(10,10);
GDP=xlsread();
pop=xlsread('C:\Users\DRH\Desktop\����(2)(1).xls',2,'');
for n=0;maxtime
%һ�����Ե�����cell��(ȡ�˿����ֵ)
i=
cellno=0;
for n=
    if(pop(n,i)>cellno)
        cellno=pop(n,i)
    end
end
%ȷ��һ��cell����ܶ�den�����ѹ������
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
%�ر�ĵ�ȡӡ������ϼ���ʱ
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
    w(i)=sum(N,S) % ������
end
% w(t,i)��ʾtʱ��i���Ե�Ȩ�أ���Ӧ�����˿ڼ��㣬Ӧ�ö�N��S������������㡣

%education
aledu=xlsread; %��һ���������ǳ���

%immigrant
Cimm=xlsread;
% ������ҲӦ����ʱ��n�й�
popim(i)=(pop(i)-pop'(i))*Cimm(n,i);
popim(j,i)=popimm(i)*w(j);

%travel&tech
altrv(i)=GDP(i)*.0001;
altech(i)=exp(n)/100; %Ϲд�ģ�%
%altech�Ҿ�����ָ����������



%����һ��(x,y)���ӵ��ھ�
Neighbour{x,y}=[N(x,y+1),N(x+1,y),N(x,y-1),N(x-1,y),S(x,y+1),S(x+1,y),S(x,y-1),S(x-1,y)];
data = Neighbour{x,y}(:);% data:8*1 double
uniquedata=unique(data);
out=zeros(length(uniquedata),3); % ���� ��Χ����  Judge���
for ni=1:length(uniquedata)
out(ni,1)=uniquedata(ni); %���Ա��
out(ni,2)=sum(data==uniquedata(ni)); % ˵�������Ե�����
LANG = out(ni,1); 
out(ni,3)=out(ni,2)*(1-alcul(N(i,j)))*aledu(AREA)*alpha_pressure(LANG,N(i,j)); % Judge
end % out: ������(<=8)*3 double
[max_LANG_value,position] = max(out(:,3));
max_LANG = out(position,1);
%judge
%judge(i)=N(i)*(1-alcul(i))*aledu*alpha(i,j)
%alcul�������Ա��Ϊ�±�����飬�洢��ֵ���Ļ����Ŷ�
%N(i)�Ǹ�����Χ˵i���Ե�����
%AREA����һ��������Ҳ������һ��������AREA�ǳ���

if(max_LANG_value>=T0 && Age(i,j)<=60 && Age(i,j)>=18 && max_LANG ~= N(i,j) )
   S(i,j) = max_LANG;
end
n++;
end



