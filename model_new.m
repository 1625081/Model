
n;%time/5
%i,j languages
maxtime=15;
alpha=ones(10,10);
GDP=xlsread();
pop=xlsread('C:\Users\DRH\Desktop\����(2)(1).xls',2,'');
alpha_cul = [0.9,0.6,0.7,0.5,0.8,0.5,0.2,0.8,0.7,0.5,0.8,0.1]; %�Ļ����Ų�����ȷ��

%һ�����Ե�����cell��(ȡ�˿����ֵ)
for dtr=1:9%������
for n=1:15
    if(pop(n,dtr)>cellno(dtr))
        cellno(dtr)=pop(n,dtr);
    end
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
%������һ���ˣ�ֱ�Ӱ�alpha_cul����Ϊһά����ͺã�alpha_cul(����)=0.90����
%ԭCAģ����cul�����ڴ�ȡ��
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
%i��dtrӦ�й�ϵ
%==��ʼ��==%
%�Ե������±��룺|| ���Ա��벻��
%1:����
%2:������
%3 ����˹����
%4 ����
%5 ����
%6 ŷ��
%7 ����
%8 ����
%9 ����
% 1955����������ڵ��ص�Ȩ�أ��������Ա�����ڳ�ʼ��
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
cell_L = {L1,L2,L3,L4,L5,L6,L7,L8,L9};% LiΪi�������Լ���
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
            Age{dtr}(x0,y0) = randsrc(1,1,[ [0,10,20,30,40,50];[0.1,0.2,0.2,0.2,0.2,0.1] ]); %������ʻ��ö�����˻�����
            if Age{dtr}(x0,y0) ~=0 % Ȼ����ʼ��ʱ���˿��������Ƶ�
             count = count + 1; % ���ܸ�������˻�·
            end
        end
    end
  end
  %����Ȩ����ɢ��ֵ
  %����� http://www.ilovematlab.cn/thread-234116-1-1.html
end

% ??? 88-90 ���岻�� Second��Ӧ�ó�ʼ��Ϊ0
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
    w(i)=cel(i)/cellsum;
end
% w(t,i)��ʾtʱ��i���Ե�Ȩ�أ���Ӧ�����˿ڼ��㣬Ӧ�ö�N��S������������㡣

%education
aledu=xlsread; %��һ���������ǳ���

%immigrant
Imm=xlsread; % ImmΪ ������*ʱ��������,������ʱ�����������������Ŀ
popim(dtr)= Imm(dtr,n);
popimlan(j,dtr)=popim(dtr)*w(j); %����dtr����j����ʹ����

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
for dtr=1:9 %����һ��������˵

for n=1:maxtime
    
%����һ��(x,y)���ӵ��ھ� <= δʵ��
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
        out(ni,3)=out(ni,2)*(1-alcul(j,1))*aledu(dtr)*alpha(j,i); % Judge
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

%����������
for x1=1:k(dtr)
    for y1=1:k(dtr)
        if (Age(x1,y1)~= 0)
            Age(x1,y1) = Age(x1,y1) + 1;
        end
    end
end

end

end



