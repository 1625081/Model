
n;%time/5
%i,j languages
maxtime=15;
%%%%%%%%%%%%%%%%%�ⲿ����û��
alpha=ones(10,10);
GDP=xlsread();
pop=xlsread('C:\Users\DRH\Desktop\����(2)(1).xls',2,'');
for n=1:maxtime
%һ�����Ե�����cell��(ȡ�˿����ֵ)
for dtr=1:9%������
for n=1:15;
    if(pop(n,dtr)>cellno(dtr))
        cellno(dtr)=pop(n,dtr);
    end
end
%ȷ��һ��cell����ܶ�den�����ѹ������
for i=1:10  %iָ���� 
  for j=1:10
    if i<=5 && j<=5 % ǰ5λΪͳ�Ƴ�GDP������
      alpha(j,i)=GDP(n,j)/(GDP(n,i)+GDP(n,j));
    elseif (i<=5 && j>5) % ǿ��ѧ��������
      alpha(j,i)=.0001;
    elseif (i>5 && j>5) %����ѧ��������
      alpha(j,i)=.0001; %
    elseif (i>5 && j<=5)% ��ѧǿ
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
%i��dtrӦ�й�ϵ
for i=1:12
    for dtr=1:9
        if(i==1&&dtr==1)|(i==2&dtr==2)|(i==3&&dtr==3)|(i==5&&dtr==5)|(i==6&&dtr==6)|(i==9&&dtr==7)|(i==10&&dtr==8)|(i==4&&dtr==4)|(i==12&&dtr==9)
           N{dtr}=i*ones(k(dtr),k(dtr));
        end
    end
end
%�ر�ĵ�ȡӡ�ȵ���
Plang7=0.01%Ϲд
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
%ŷ�ޡ�
Plang9=0.01%Ϲд
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
%�������ǡ�
Plang1=0.01
if dtr==9
    if rand(k(dtr),k(dtr))<Plang1
        x=randperm(k(dtr),1);
        y=randperm(k(dtr),1);
        N{dtr}(x,y)=1;
    end
end
%��������
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
    cellsum=cellno(dtr)+cellsum; % ������
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
% w(t,i)��ʾtʱ��i���Ե�Ȩ�أ���Ӧ�����˿ڼ��㣬Ӧ�ö�N��S������������㡣

%education
aledu=xlsread; %��һ���������ǳ���

%immigrant
Imm=xlsread;
% ������ҲӦ����ʱ��n�й�
popim(dtr)= %(pop(n,dtr)-pop(n-1,dtr))*Cimm(n,i);
popimlan(j,dtr)=popimm(dtr)*w(j);%����i��������j����ʹ����

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
%altech�Ҿ�����ָ����������
Ptech=0.00001*exp(n);
if rand(300,300)<Pnet
    dtr=randperm(9,1);
    i=randomperm(12,1);
    x=randperm(k(dtr),1);
    y=randperm(k(dtr),1);
    N{dtr}(x,y)=i;
end


%��dtr=ĳ��ֵʱ
for dtr=1:9

%����һ��(x,y)���ӵ��ھ�
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
    out=zeros(length(uniquedata),3); % ���� ��Χ����  Judge���
    for ni=1:length(uniquedata)
        out(ni,1)=uniquedata(ni); %���Ա��
        out(ni,2)=sum(data==uniquedata(ni)); % ˵�������Ե�����
        LANG = out(ni,1); 
        out(ni,3)=out(ni,2)*(1-cul(j,1))*aledu(dtr)*alpha(j,i); % Judge
    end % out: ������(<=8)*3 double
end

if learn_second  %û��ѧ�����������ѧϰ��
    [max_LANG_value,position] = max(out(:,3)); %ȡjudge���
    max_LANG = out(position,1);
    %judge
    %judge(i)=N(i)*(1-alcul(i))*aledu*alpha(x,y)
    %alcul�������Ա��Ϊ�±�����飬�洢��ֵ���Ļ����Ŷ�
    %N(i)�Ǹ�����Χ˵i���Ե�����
    %AREA����һ��������Ҳ������һ��������AREA�ǳ���
    if(max_LANG_value>=T0 && max_LANG ~= N(x,y) )
        S{dtr}(x,y) = max_LANG;
    end
elseif learn_native  %ûѧ��ĸ����׶�
    [max_LANG_value,position] = max(out(:,2)); %ȡNx�����Ǹ�����
    max_LANG = out(position,1);
    N{dtr}(x,y) = max_LANG;
elseif Age(x,y)>=80 %��������
    % N(x,y)=0; ����ע����Ϊ�˿����ӳи�ҵN(x,y)���ı�
    Age(x,y)=1;
    S(x,y)=0;
end

end
end
end



