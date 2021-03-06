function nextstate = bees(state,date)% bee model in the field season 

%%%% Empty Cell+Pollen Cells + Honey Cells+Brood Cells =Hive Space
%%%%%%%%%%%%%%%%%%%%%Abnormal developmental cycle.(precocious+delayed development in bees)
% u=0.0;%precocious prob
% v=0.0;% reversed prob. between foragers and house bees;


agemax=60; % indexing in matlab starts at 1, so add an extra day

global qh st1 st2 st3 st4 st5 st6; % st1,2,3,5,6: survival rate for each stage of bees; mt4-the mortality rate of nurse bee stage; 
global tel tlp tpn tnh thf;
global  FactorBroodNurse; % The brood rearing efficiency: the constant ratio of egg to nurse bees as signal for queen to decide the egg laying rate. 
global u v rt; % The probability of precocious foraging (u), reversed behavior of foragers to in-hive behaviors(v), the delayed development of adult bees at each age(rt); 
global a1 a2 a4 a5 h1 h2 h4 h5 h6; %%%cosumption rate of honey and pollen  for each stage of bees 
global hsurfX hsurfY hsurf; % the interpolated surface of NectarODE and honeycollection 

 %% Stage Structure for field season bees-normal cycle: nonlinearities.1=egg,2=larvae,3=pupae,4=nurse,5=house,6=forager
s = zeros(6,agemax);
s(1,1:3)=1;% 
s(2,4:11)=1;
s(3,12:26)=1;
s(4,27:42)=1;
s(5,43:48)=1;
s(6,49:agemax)=1;

%% Current conditions in bee hive %%%%%%%%
Vt = state(1); % vacant cells 
Pt = state(2); %  pollen stores at time t. 
Ht=state(3);%  honey stores at time t. 
Nt = state(5:end);% bee number at time t 
stage = s*Nt;
%% Queen reproduction potential (McLellan et al., 1978)
relativedate = mod(date,360);
maxProduction= (0.0000434)*(relativedate)^4.98293*exp(-0.05287*relativedate);

%% Index for the quality of pollen status and nursing quality in the colony
% Negative feedback loops of pollen stores and nursing quality in affecting
% the bee dynamics (Larva, Nurse) in turn affecting food collection and
% storage. 
Factorstore=6;% (Blaschon et al.,1999) The modeled colony regulates the pollen stores around a level that represents a reserve for approximately 6 days, based on the current level of demand.
PollenDemand= a1*stage(1)+a2*stage(2)+a4*stage(4)+a5*stage(5); % The colony pollen demand includes the need of egg, larval, nurse and house bee stage. We assume the daily demand of pollen of bees is constant stage-specific parametes.
Indexpollen=max(0,min(1,Pt/(PollenDemand*Factorstore+1)));% the level of the pollen stores in relation to the demand situation of the colony.
%FactorBroodNurse=4; % This model assume all nursing bees are equally effective
IndexNursing=max(0,min(1,stage(4)/((stage(2)+stage(1))*FactorBroodNurse+1))); %the level of the active nurse bees population in relation to the total nursing demand of all brood stages.
IndexNurseload=max(0,(stage(2)+stage(1))*FactorBroodNurse/(stage(4)+1)); % the nursing load for the active nurse bees population 
%% Bee Dynamics 
survivorship = zeros(agemax,1);
survivorship(1:3)= st1^(1/3); % the daily survival rate of egg stage at age(i=1-3) 
survivorship(3:4)=tel*survivorship(2);% stage transitional rate 
survivorship(4:11) = (st2*min(1,max(0,1-0.15*(1-Indexpollen*IndexNursing))))^(1/8);% the daily survival rate of larval stage at age(i=1-3)  
% Larvae are frequently cannibalized in a honeybee colony.The rate of cannibalism depends on the age of the larvae (Schmickl and Crailsheim, 2001),
% the pollen status of the colony (Schmickl and Crailsheim, 2001)and the nursing quality (Eischen et al., 1982).
% Therefore, larval mortality includes a time-independent base mortality
% rate and the cannibalism factor. 0.15--the time-independent base
% cannibalism mortality rate for larval stage. st2-the time independent
% base mortality rate of larval stage at any age (4-11 days old)
survivorship(11:12)=tlp*survivorship(10);
survivorship(12:26)= st3^(1/15); % the pupal stage is more static. The daily survival rate of pupal stage at any age of 12 to 26. 
survivorship(26:27)=tpn*survivorship(25);
%survivorship(27:42)= (1-u)*max(0,(1-(1-st4)*IndexNurseload))^(1/16);% mt4 is the time-independent base mortality of nurse bee stage. 
survivorship(27:42)= (1-u)*st4^(1/16);
survivorship(42:43)=tnh*survivorship(41);
%It will be varied by the nursing efforts. The higher the nursing load will
%cause a higher mortality of the nurse bee stage.
% u is the probability for the accelerated behavior--precocious foraging--the nurse bee stage have a certain probability to jump directly into the forager stage. 
survivorship(43:48)= st5^(1/6);
survivorship(48:49)=thf*survivorship(47);
survivorship(49:agemax,1)= (1-v)*st6^(1/12); % v is reversed probability of the forager bee stage to revert back to in-hive nurse bees. 
theta = rt*ones(agemax-1,1); % theta = probabilities of retarded development at each stage
A = (diag(1-theta,-1)+diag([0;theta]))*diag(survivorship);% The matrix for storing all the survial rate of bees at each age. 
B=zeros(agemax);% the precocious development of nurse bees 
B(49,27:42)=u*ones(1,16);
C=zeros(agemax);
C(27,49:agemax)= v*ones(1,12); % the retarded development of forager bees 
transit=A+B+C; 
%%%Model pesticide intervention 

%startdate enddate exposuretime=enddate-startdate toxicity=0.5^(1/7);
%st1=survivalrateafterexposure=(0.85-toxicity*exposuretime)^(1/3); if
%t<startdate st1=0.85^(1/3); if startdate<t<enddate+1 st1=
%survivalrateafterexposure=(0.85-toxicity*exposuretime)^(1/3)
%else 





Nt1= transit*Nt; % structured dynamics for bees 

%% Pollen dynamics-field season 
foodeaten =  min([Pt,a1*stage(1)+a2*stage(2)+a4*stage(4)+a5*stage(5)]); % pollen consumption of egg, larval, nurse and house bee stage
scavangedcells = Nt(1:26)'*(1-survivorship(1:26));% The removal of dead brood, hygenic behavior 
honeyeaten= min([Ht,h1*stage(1)+h2*stage(2)+h4*stage(4)+h5*stage(5)+h6*stage(6)]); % honey consumption of larval, nurse, house and forager bee stage
vacated = Nt(26) + foodeaten+honeyeaten;% Empty Cells due to the cleaned food cells and adult emergence 

% if stage(4)+stage(5)+stage(6)<= 0 % the minimum requirement of number of bees needed to be around a queen bee 
%  R=0;
%  else 
% %R = max(0, min([qh*maxProduction,(stage(4)+stage(5))*FactorBroodNurse,Vt+vacated+scavangedcells]));% The actural egg production per day depends on the queen egg laying potential, the nursing workforce and the available hive space
%R = max(0, min([qh*maxProduction,(stage(4)+stage(5))*FactorBroodNurse]));
%R = max(0, min(Vt+vacated+scavangedcells,qh*maxProduction));
%R  =max(0, min(Vt+vacated+scavangedcells, qh*2000));
R= qh*maxProduction; 
% end 
%end 
%R = max(0, min([qh*maxProduction,Vt+vacated+scavangedcells]));
% Pollen foraging feedback mechanism: pollen foraging is regulated
% according to the current pollen demand, which is the amount of pollen
% need for each stage and reserve for next 6 days (Factorstore) need minus
% to current pollen storage.

PollenNeed=max(0,(a1*stage(1)+a2*stage(2)+a4*stage(4)+a5*stage(5))*Factorstore-Pt); % 
NeedPollenForager=PollenNeed/0.48;
%PollenForager=max(stage(6)*0.01, min(NeedPollenForager,stage(6)*0.33));
 PollenForager=min(stage(6),max(stage(6)*0.01, NeedPollenForager));
% Weidenmu� ller and Tautz (2002) showed that in times of different pollen need, the colony responds with a different number of pollen foragers but does not change the overall flight activity or the total number of all foragers (pollen and nectar). 
% 0.48 is the pollen collected each day each forager, based on the amount
% of pollen collected per foraging trip(0.06 cellful pollen,Camazine et
% al., 1990), the average foraging trips performed per forager per day(10 trips per day) and the stochastic factor for each pollen
% forager to make a successful foraging trip(80%). 
% In nature, there is always a certain minimum number of pollen foragers
% within the cohort of foragers (1% forager will have the preference to
% make pollen foraging), even when there is almost no pollen need (personal
% observation). The maximum number of pollen foragers is 33% of the current
% cohort of foragers. 
storedfood = max( 0, min([PollenForager*0.48,Vt+vacated+scavangedcells-R]));% pollen storage depends on the available cells in the hive, the foraging collection efficiency of the pollen forager---assumption for pollen foraging behavior

%% Honey dynamics-field season 
% Base on the nectar foraging mechanism proposed by Tom Seeley, nectar collection is based on the interaction of current nectar forager and the house bees(food storer bees)as modeled in the NectarODE model. 
% The daily processing of nectar into honey, a process that concentrates the nectar and thereby reduces the volume (as defined by the constant RATIOnectar to honey).
% if stage (5)<=1
%    storedhoney=0;
% else 
predictedhoney =0.4* interp2(hsurfX,hsurfY,hsurf,0.8*stage(5),stage(6)-PollenForager);% The processing factor of nectar into honey is 0.4.  
storedhoney= max( 0, min([predictedhoney, Vt+vacated+scavangedcells-R-storedfood])); % Nectar Input by the nectar foraging ODE model 
% end   
    
   
%% Pollen, Honey, Cells net input 
Pt1 = max(0, Pt- foodeaten + storedfood); % The net pollen storage at the end of the day 
Ht1= Ht-honeyeaten+storedhoney; % The net honey storage at the end of the day. 
Vt1 = max(0, Vt +vacated - R -storedfood-storedhoney+ scavangedcells); % The net vacant cells 
Nt1(1) = R; 

nextstate = [ Vt1; Pt1; Ht1; R; Nt1 ];  

return

% 

%figure(2);

%imagesc(A);

%figure(3);

%subplot(2,1,1)

%spy(transit)

%subplot(2,1,2)

%plot(sum(transit),'o-')

%break

%[date,R,storedfood,Vt1-Vt,sum(stage(1:3))+Vt+Pt]











