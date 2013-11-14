%nrm = [1/3,1/8,1/15,1/16,1/6,1/12]'; % normalize frequencies for each
%stage

% First Season Summer Dynamics 
%function  H3 = testNOP(surX) 
agemax = 60; % +1 because of matlab indexing
global qh st1 st2 st3 st4 st5 st6;
global FactorBroodNurse u v rt foragingsuccess Q nt; 
 global hsurfX hsurfY hsurf;
 global a1 a2 a3 a4 a5 a6 h1 h2 h3 h4 h5 h6; %%%cosumption rate of honey and pollen  for each stage of bees 
 global tel tlp tpn tnh thf;

 u=0.0;
 v=0.000;% reversed prob. between foragers and house bees;
 FactorBroodNurse=2; % One nurse bee can heat 2.65 brood cells 
 rt=0;
 
 %qh=1500/2250;
 %qh=1;
 qh=1;

h1=0;
h2=0;
h4=0.1;
h5=0.1;
h6=0.136;

a1=0;
a2=0.0047;
a4=0.0283;
a5=0;



st1=0.86; % 0.86--survivorship for egg stage 
st2= 0.85; %---survivorship for larval stage 
st3= 0.86;
st4= 0.88; % 0.99-85%--survivorship for nurse bee stage 
st5=0.88; % 0.96-88.6%--survivorship for house bee stage 
st6=0.78; % 78.5%--survivorship for forager bee stage


% %%Max
% st1=1; % 0.86--survivorship for egg stage 
% st2= 1; %---survivorship for larval stage 
% st3= 1;
% st4= 1; % 0.99-85%--survivorship for nurse bee stage 
% st5=1; % 0.96-88.6%--survivorship for house bee stage 
% st6=1; % 78.5%--survivorship for forager bee stage

% Min
% st1=0.79; % 0.86--survivorship for egg stage 
% st2= 0.8; %---survivorship for larval stage 
% st3= 0.8;
% st4= 0.88; % 0.99-85%--survivorship for nurse bee stage 
% st5=0.88; % 0.96-88.6%--survivorship for house bee stage 
% st6=0.75; % 78.5%--survivorship for forager bee stage


% st1=0.6; % 0.86--survivorship for egg stage 
% st2= 0.8; %---survivorship for larval stage 
% st3= 0.8;
% st4= 0.8; % 0.99-85%--survivorship for nurse bee stage 
% st5=0.8; % 0.96-88.6%--survivorship for house bee stage 
% st6=0.75; % 78.5%--survivorship for forager bee stage

% theta = rt*ones(agemax-1,1); % theta = probabilities of development retardation
%rt=0.0000000;

%st4= 0.97; % 0.86--survivorship for egg stage 
% st1=1;
% st2=1;st3=1;st4=1;st5=1;st6=1;
% st1= 0.97; % 0.86--survivorship for egg stage 
% st2= 0.99; %---survivorship for larval stage 
% st3= 0.999;
% st4= 0.995; % 0.99-85%--survivorship for nurse bee stage 0.97-nurse bee threshold 
% st5=0.995; % 0.96-88.6%--survivorship for house bee stage 
% st6=0.965; % 78.5%--survivorship for forager bee stage

%%Control survival
% st1=(0.86)^(1/3); % 0.86--survivorship for egg stage 
% st2= (0.85)^(1/7); %---survivorship for larval stage 
% st3= (0.86)^(1/14);
% st4= (0.85)^(1/16); % 0.99-85%--survivorship for nurse bee stage 
% st5=(0.85)^(1/6); % 0.96-88.6%--survivorship for house bee stage 
% st6=(0.78)^(1/12); % 78.5%--survivorship for forager bee stage
% % % global tel tlp tpn tnh thf;

%%max surivival
% st1=(1)^(1/3); % 0.86--survivorship for egg stage 
% st2= (1)^(1/7); %---survivorship for larval stage 
% st3= (1)^(1/14);
% st4= (1)^(1/16); % 0.99-85%--survivorship for nurse bee stage 
% st5=(1)^(1/6); % 0.96-88.6%--survivorship for house bee stage 
% st6=(1)^(1/12); % 78.5%--survivorship for forager bee stage

%%%%Min survival
% st1=(0.5)^(1/3); % 0.86--survivorship for egg stage 
% st2= (0.5)^(1/7); %---survivorship for larval stage 
% st3= (0.5)^(1/14);
% st4= (0.5)^(1/16); % 0.99-85%--survivorship for nurse bee stage 
% st5=(0.5)^(1/6); % 0.96-88.6%--survivorship for house bee stage 
% st6=(0.5)^(1/12); % 78.5%--survivorship for forager bee stage

tel=1;
tlp=1;
tpn=1;
tnh=1;
thf=1;

% st1= 0.85^(1/3); % 0.86--survivorship for egg stage 
% st2= 0.904^(1/8); %---survivorship for larval stage 
% st3= 0.988^(1/15);
% mt4= 1-0.976^(1/16); % 0.99-85%--survivorship for nurse bee stage 
% st5=0.86^(1/6); % 0.96-88.6%--survivorship for house bee stage 
% st6=0.78^(1/12); % 78.5%--survivorship for forager bee stage
% 
% %%%%Dimethoate Control 
% st1=(0.85)^(1/3); % 0.86--survivorship for egg stage 
% st2= (0.85)^(1/7); %---survivorship for larval stage 
% st3= (0.86)^(1/14);
% st4= (0.6)^(1/16); % 0.99-85%--survivorship for nurse bee stage 
% st5=(0.85)^(1/6); % 0.96-88.6%--survivorship for house bee stage 
% st6=(0.78)^(1/12); % 78.5%--survivorship for forager bee stage


%%%%Fungicide Wax%%%%%%%%% the emergence levels of 1st instar larvae was
%%%%reduced significantly. 
% st1=(0.08)^(1/3); % 0.86--survivorship for egg stage 
% st2= (0.85)^(1/7); %---survivorship for larval stage 
% st3= (0.86)^(1/14);
% st4= (0.85)^(1/16); % 0.99-85%--survivorship for nurse bee stage 
% st5=(0.85)^(1/6); % 0.96-88.6%--survivorship for house bee stage 
% st6=(0.78)^(1/12); % 78.5%--survivorship for forager bee stage

%nt=0.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
G = zeros(6,agemax);
tx=240;
G(1,1:3)=1; G(2,4:11)=1; G(3,12:26)=1; G(4,27:42)=1;G(5,43:48)=1;G(6,49:agemax)=1;

P0 = 1000;

V0 = 500000 - P0;% each medium frame have 4620 cells, usually a colony start with 3 boxes of frames, 30 frames. 

H0=0;

R0=0;

N = zeros(agemax,1);

N(1:3)=100;

N(4:11)=100;

N(12:26)=300;

N(27:42)=300;

N(43:48)=300;

N(49:agemax)=300;

X = [ V0; P0; H0;R0; N ];

res=zeros(6,tx);

V=zeros(1,tx);

P=zeros(1,tx);

H=zeros(1,tx);

R=zeros(1,tx);


numyears =1;
summerdays = 240;
yeardays = 360;

pop=zeros(6,yeardays*numyears);
Vpop=zeros(1,yeardays*numyears);
Ppop=zeros(1,yeardays*numyears);
Hpop=zeros(1,yeardays*numyears);
Rpop=zeros(1,yeardays*numyears);


%%pesticide application time for FPE study 
startdate=0;
enddate=0;

for T = 0:(numyears-1)

          for t=(yeardays*T+1):(yeardays*T+summerdays)
           
 StartD = mod(startdate,360);
EndD=mod(enddate,360);
if  t > startdate && t < enddate
    
    %theta = rt*ones(agemax-1,1); % theta = probabilities of development retardation
   st1=(0.5)^(1/3); % 0.86--survivorship for egg stage
    st2= (0.85)^(1/7); %---survivorship for larval stage
    st3= (0.86)^(1/14);
    st4= (0.85)^(1/16); % 0.99-85%--survivorship for nurse bee stage
    st5=(0.85)^(1/6); % 0.96-88.6%--survivorship for house bee stage
    st6=(0.78)^(1/12); % 78.5%--survivorship for forager bee stage
    qh=0.06;

else
    
    st1=(0.85)^(1/3); % 0.86--survivorship for egg stage
    st2= (0.85)^(1/7); %---survivorship for larval stage
    st3= (0.86)^(1/14);
    st4= (0.85)^(1/16); % 0.99-85%--survivorship for nurse bee stage
    st5=(0.85)^(1/6); % 0.96-88.6%--survivorship for house bee stage
    st6=(0.78)^(1/12); % 78.5%--survivorship for forager bee stage
    qh=1;
end

              
		     X = bees(X,t);

		     res(1:6,t-yeardays*T)=G*X(5:end);
 
		     V(1,t-yeardays*T)= X(1);

		     P(1,t-yeardays*T)= X(2);
        
             H(1,t-yeardays*T)= X(3);

		     R(1,t-yeardays*T)= X(4);
 
          end
     
%     pollen=P(1,yeardays*T+summerdays);
%     
%     Honey= H(1,yeardays*T+summerdays);
    
	pop(:,(yeardays*T+1):(yeardays*T+summerdays))=res;
    Vpop(:,(yeardays*T+1):(yeardays*T+summerdays))=V;
    Ppop(:,(yeardays*T+1):(yeardays*T+summerdays))=P;
    Hpop(:,(yeardays*T+1):(yeardays*T+summerdays))=H;
    Rpop(:,(yeardays*T+1):(yeardays*T+summerdays))=R;
% 	
%     if pop(4,(yeardays*T+1):(yeardays*T+summerdays))+pop(5,(yeardays*T+1):(yeardays*T+summerdays))<1000
%         
%           
%          fprintf('colony collapse');
%         break 
%     else 
%  
    
    % First Season Winter Dynamics 

	agemaxwinter=150; 

	W = zeros(4,agemaxwinter);

	W(1,1:3)=1; W(2,4:11)=1; W(3,12:26)=1; W(4,27:agemaxwinter)=1;

	N = zeros(agemaxwinter,1);

	N(1:3)=res(1,summerdays)/3;

	N(4:11)=res(2,summerdays)/8;

	N(12:26)=res(3,summerdays)/15;

	N(27:agemaxwinter)=(res(4,summerdays)+res(5,summerdays)+res(6,summerdays))/100;

	P0 = P(1,summerdays);

    V0 = V(1,summerdays);

    H0 = H(1,summerdays);

    R0 = R(1,summerdays);
    

    Y = [ V0; P0; H0;R0; N ];

	clear res V P H R;

	res=zeros(6,yeardays-summerdays);
    
    V=zeros(1,yeardays-summerdays);

    P=zeros(1,yeardays-summerdays);

    H=zeros(1,yeardays-summerdays);

    R=zeros(1,yeardays-summerdays);
    	

	for t=(yeardays*T+summerdays+1):(yeardays*(T+1))

		Y = winterbeesR(Y,t);

		res(1:4,(t-(yeardays*T+summerdays)))=W*Y(5:end);
      
        V(1,(t-(yeardays*T+summerdays)))= Y(1);

        P(1,(t-(yeardays*T+summerdays)))= Y(2);
    
        H(1,(t-(yeardays*T+summerdays)))= Y(3);

        R(1,(t-(yeardays*T+summerdays)))= Y(4);
        
     
    end 
    
	pop(:, (yeardays*T+summerdays+1):(yeardays*(T+1))) =res;
    
    Vpop(1,(yeardays*T+summerdays+1):(yeardays*(T+1)))= V;
    
    Ppop(1,(yeardays*T+summerdays+1):(yeardays*(T+1)))= P;
    
    Hpop (1,(yeardays*T+summerdays+1):(yeardays*(T+1)))= H;
    
    Rpop (1,(yeardays*T+summerdays+1):(yeardays*(T+1)))= R;
    
        
%     disp(Ppop')
%     disp(Hpop')
    
%     
%      
           
	%Second Season Summer Dynamics 

	N = zeros(agemax,1);

	N(1:3)=pop(1,yeardays*(T+1))/3;

	N(4:11)=pop(2,yeardays*(T+1))/8;

	N(12:26)=pop(3,yeardays*(T+1))/15;

	N(27:42)= pop(4,yeardays*(T+1))/34;

	N(43:48)= pop(4,yeardays*(T+1))/34 ;

	N(49:agemax)=pop(4,yeardays*(T+1))/34;

	P0 = Ppop(1,yeardays*(T+1));

	V0 = Vpop(1,yeardays*(T+1));

	R0= Rpop(1,yeardays*(T+1));
    
    H0= Hpop(1,yeardays*(T+1)); 

	X = [ V0; P0; H0; R0; N];

	res=zeros(6,summerdays);

	R=zeros(1,summerdays);

	V=zeros(1,summerdays);

	P=zeros(1,summerdays);

    H= zeros(1,summerdays); 
%     else 
%          fprintf('colony collapse');
%         break 
%     end
end 

YMatrix1=pop';
% A=Ppop.*0.23/1000;
% B=Hpop*0.5/1000;
A=Ppop;
B=Hpop;
YMatrix2= [A;B]';
 Y3=Rpop;
%Y3=pop(3)*0.1552/1000+pop(4)*0.2189/1000+pop(5)*0.2189/1000+A+B;
createfigure1(YMatrix1, YMatrix2, Y3); 

% %hold off;
% figure;
% plot(Y3);
% foundationweight = 50.2 * 453.6 /1000;
% 
% Y1=(pop(2)+pop(3))*0.1552/1000+pop(4)*0.2189/1000+pop(5)*0.2189/1000+A+B+foundationweight;
% disp(Y1)
%  plot(Y1(1:360));
% t=[0:30:360];months=['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec';];
% set(gca,'xtick',t)
% set(gca,'xticklabel',months)
% xlabel('Date')
% ylabel('Colony Weight')

