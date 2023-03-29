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

alpha = 0.05;
ax = axis;
zcrit = norminv(1-alpha/2);

%for RH to Temp
[T1,RH1]=dragatsikawExe5Fun1(TC,RH);

[R2_1,adjR2_1,est1,xgrd1,ygrd1]=dragatsikawExe5Fun2(RH1,T1);

figure(1);
clf;
plot(RH1,T1,'.');
hold on
plot(xgrd1,ygrd1,'-'); 
legend('data','linear fit') ;
title('Linear Fit of Data RH To Temp, n=40 ')
xlabel('RH');
ylabel('Temp');




fprintf("\n\n The coefficient of determination for the index RH of the linear regression model to the index T");
fprintf("\n is %f",R2_1);
fprintf("\n The adjusted coefficient of determination for the linear model from index RH to the index T ");
fprintf("\n is  %f",adjR2_1);


figure(2)
clf;
plot(T1,est1,'.')
hold on
plot([ax(1) ax(2)],zcrit*[1 1],'c--')
plot([ax(1) ax(2)],-zcrit*[1 1],'c--')
title('graph standard - erros RH, n=40 ')
xlabel('Temp');
ylabel('errors');

%for WIND ws pros Temp


[T2,WIND1]=dragatsikawExe5Fun1(TC,cW);

[R2_2,adjR2_2,est2,xgrd2,ygrd2]=dragatsikawExe5Fun2(WIND1,T2);

figure(3);
clf;
plot(WIND1,T2,'.');
hold on
plot(xgrd2,ygrd2,'-'); 
legend('data','linear fit') ;
title('Linear Fit of Data WIND To Temp, n=40 ')
xlabel('WIND');
ylabel('Temp');




fprintf("\n\n The coefficient of determination for the index WIND of the linear regression model to the index T");
fprintf("\n is %f",R2_2);
fprintf("\n The adjusted coefficient of determination for the linear model from index WIND to the index T ");
fprintf("\n is  %f",adjR2_2);


figure(4)
plot(T2,est2,'.')
hold on
plot([ax(1) ax(2)],zcrit*[1 1],'c--')
plot([ax(1) ax(2)],-zcrit*[1 1],'c--')
title('graph standard - errors, n=40 ')
xlabel('Temp');
ylabel('errors');

fprintf("\n\n Both of models, RH to T and WIND to T, are similar about the correlation indexes and the estimates errors, which means   ");
fprintf("\n that both of cases, the indexes are not uncorrelated. ");
fprintf("\n finally, the extra application of the polynomial model doesn' t make sence, because the effort to find a polynomial model until 4th degree \n");
fprintf("\n has as a result the adjusted coefficient of determination to be stable around zero value\n");






% Until 4th degree polynomial model, the estimates errors related to each other with a linear regression model at the both of cases 




