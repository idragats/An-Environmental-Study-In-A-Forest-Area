MyData=importdata("forestfires.dat.txt");

xpark_M=     MyData(:,1);
ypark_M=     MyData(:,2);



months=      MyData(:,3);
days=        MyData(:,4);

FFMC_FWI=    MyData(:,5);
DMC_FWI=     MyData(:,6);
DC_FWI=      MyData(:,7);
ISI_FWI=     MyData(:,8);

TC=          MyData(:,9);
RH=          MyData(:,10); %relative humidity percentage
cW=          MyData(:,11); %wind speed (Km/h)
Rain=        MyData(:,12); %rain (mm/m^2)
Burn_Earth = MyData(:,13); %burnt region earth (ha) 


%group A -> burn_area = 0 and group B -> burn_area ~=0
k=0;
l=0;
A=zeros(247,13);
B=zeros(270,13);
for i=1:length(Burn_Earth)
    
    if Burn_Earth(i)==0
        k=k+1;
        A(k,:)=MyData(i,:);
        
    else 
        l=l+1;
        B(l,:)=MyData(i,:);
    end    
end

n=40;
m=6; %samples number
CR=zeros(length(cW),m+1);
k=0;

Index_Correlation_withFFMC={'FFMC-DMC';'FFMC-DC';'FFMC-ISI';'FFMC-T';'FFMC-RH';'FFMC-WIND'}; 

Index_Correlation_withDMC={'DMC-FFMC';'DMC-DC';'DMC-ISI';'DMC-T';'DMC-RH';'DMC-WIND'};

Index_Correlation_withDC={'DC-FFMC';'DC-DMC';'DC-ISI';'DC-T';'DC-RH';'DC-WIND'};

Index_Correlation_withISI={'ISI-FFMC';'ISI-DMC';'ISI-DC';'ISI-T';'ISI-RH';'ISI-WIND'};

Index_Correlation_withT={'T-FFMC';'T-DMC';'T-DC';'T-ISI';'T-RH';'T-WIND'};

Index_Correlation_withRH={'RH-FFMC';'RH-DMC';'RH-DC';'RH-ISI';'RH-T';'RH-WIND'};

Index_Correlation_withWIND={'WIND-FFMC';'WIND-DMC';'WIND-DC';'WIND-ISI';'WIND-T';'WIND-RH'};




for i=5:11
    k=k+1;
CR(:,k)=MyData(:,i);
end

RP=zeros([n,7]);
for i=1:m+1
   RP(:,i)=dragatsikawExe4Fun1(CR(:,i),n);
   
end

[t,p,r,ra,rb]=dragatsikawExe4Fun2(RP,n,m);
P1=table(Index_Correlation_withFFMC,t,p,r,ra,rb);
disp(P1);

R1=dragatsikawExe4Fun5(RP);
[t,p,r,ra,rb]=dragatsikawExe4Fun2(R1,n,m);
P2=table(Index_Correlation_withDMC,t,p,r,ra,rb);
disp(P2);

R2=dragatsikawExe4Fun5(R1);
[t,p,r,ra,rb]=dragatsikawExe4Fun2(R2,n,m);
P3=table(Index_Correlation_withDC,t,p,r,ra,rb);
disp(P3);

R3=dragatsikawExe4Fun5(R2);
[t,p,r,ra,rb]=dragatsikawExe4Fun2(R3,n,m);
P4=table(Index_Correlation_withISI,t,p,r,ra,rb);
disp(P4);

R4=dragatsikawExe4Fun5(R3);
[t,p,r,ra,rb]=dragatsikawExe4Fun2(R4,n,m);
P5=table(Index_Correlation_withT,t,p,r,ra,rb);
disp(P5);

R5=dragatsikawExe4Fun5(R4);
[t,p,r,ra,rb]=dragatsikawExe4Fun2(R5,n,m);
P6=table(Index_Correlation_withRH,t,p,r,ra,rb);
disp(P6);


R6=dragatsikawExe4Fun5(R5);
[t,p,r,ra,rb]=dragatsikawExe4Fun2(R6,n,m);
P7=table(Index_Correlation_withWIND,t,p,r,ra,rb);
disp(P7);

% sampling test 

fprintf("the result of the sampling of the t-student test \n\n");
L=1000;
alpha = 0.05;
tcrit = tinv(1-alpha/2,n-2);


tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(CR,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);
if (i==2)
end

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
end   
 
T1=table(Index_Correlation_withFFMC,tlower,tupper);
disp(T1);

Q1=dragatsikawExe4Fun5(CR);
tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(Q1,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
 end   
T2=table(Index_Correlation_withDMC,tlower,tupper);
disp(T2);

Q2=dragatsikawExe4Fun5(Q1);
tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(Q2,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
 end   
T3=table(Index_Correlation_withDC,tlower,tupper);
disp(T3);

Q3=dragatsikawExe4Fun5(Q2);
tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(Q3,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
 end   
T4=table(Index_Correlation_withISI,tlower,tupper);
disp(T4);


Q4=dragatsikawExe4Fun5(Q3);
tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(Q4,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
 end   
T5=table(Index_Correlation_withT,tlower,tupper);
disp(T5);


Q5=dragatsikawExe4Fun5(Q4);
tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(Q5,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
 end   
T6=table(Index_Correlation_withRH,tlower,tupper);
disp(T6);



Q6=dragatsikawExe4Fun5(Q5);
tlower=zeros(m,1);
tupper=zeros(m,1);
for i=2:m+1
    
[RP2a,RP2b]=dragatsikawExe4Fun3(Q6,1,i,n,L);
[Tlower,Tupper]=dragatsikawExe4Fun4(RP2a,RP2b,alpha,L,n);

tlower(i-1)=Tlower;
tupper(i-1)=Tupper;
 end   
 
T7=table(Index_Correlation_withWIND,tlower,tupper);
disp(T7);
  


fprintf("\n\n After first test, we could see that the indexes which correlated are : ");
fprintf("\n  FFMC and ISI, DC and DMC,  ISI and T, T and RH ");

fprintf("\n\n To control if the indexex correlated after sampling test, we used  ");
fprintf("\n tcrit =%d if it could find between tlower and tupper",tcrit);
 
fprintf("\n\n After sampling test, we could see that the indexes which correlated are");
fprintf("\n  FFMC with DC and T. DMC with DC,ISI,T,RH.  DC with ISI,RH,WIND ");
fprintf("\n  ISI with DMC.  T with ISI,RH,WIIND.  RH with DC,T. ");
fprintf("\n  and finally   WIND with DMC,ISI,T\n  ");
    
    
    
