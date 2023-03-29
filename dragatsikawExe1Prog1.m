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
RH=          MyData(:,10); % relative humidity percentage
cW=          MyData(:,11); % Wind Speed  (Km/h)
Rain=        MyData(:,12); % rain (mm/m^2)
Burn_Earth = MyData(:,13); % burnt region earth (ha) 


%group A -> burn_area = 0 , group B -> burn_area ~=0
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


%histograms for the 3 indicators: temperature , RH, SpeedWind, in both areas: burn (A) and no burn (B)

for i=9:11

figure(i-8)

clf; cla;
hist1=histogram(A(:,i),'FaceColor','#0072BD','facealpha',.3,'edgecolor','w');
hold on 
hist2=histogram(B(:,i),'FaceColor','#D95319','facealpha',0.8,'edgecolor','w');

title("Temperature Histogram ");
xlabel('T(°C)','FontWeight','Bold');
ylabel('FREQUENCY','FontWeight','Bold');
legend("BurnArea - 0","BurnArea - 1")
hold off

 if (i==10)
title("RH Histogram ");
xlabel('RH','FontWeight','Bold');
ylabel('FREQUENCY','FontWeight','Bold');
legend("BurnArea - 0","BurnArea - 1")
hold off
 end
 if (i==11)
    
title("Wind Speed Histogram ");
xlabel('WIND (Km/h)','FontWeight','Bold');
ylabel('FREQUENCY','FontWeight','Bold');
legend("BurnArea - 0","BurnArea - 1")
hold off
  end
end

% histogram of probability density function (pdf)


for i=9:11

figure(i-5)

clf; cla;
hs1=histfit(A(:,i));
hs1(2).Color = [.3 .3 .3];
hs1(1).FaceColor = [.3 .3 1];
hold on
hs2=histfit(B(:,i));
hs2(2).Color = [.6 .6 .6];
hs2(1).FaceColor = [.6 .6 1];

title("Temperature Histogram ");
xlabel('T(°C)','FontWeight','Bold');
ylabel('FREQUENCY','FontWeight','Bold');
legend("BurnArea - 0","BurnArea - 0","BurnArea - 1","BurnArea - 1")
hold off

 if (i==10)
title("RH Histogram ");
xlabel('RH','FontWeight','Bold');
ylabel('FREQUENCY','FontWeight','Bold');
legend("BurnArea - 0","BurnArea - 0","BurnArea - 1","BurnArea - 1")
hold off
 end
 if (i==11)
    
title("Wind Speed Histogram ");
xlabel('WIND (Km/h)','FontWeight','Bold');
ylabel('FREQUENCY','FontWeight','Bold');
legend("BurnArea - 0","BurnArea - 0","BurnArea - 1","BurnArea - 1")
hold off
  end
end


%  X2 - normal distribution and Poisson distribution - temperature
    
Distribution_Parameters = {'NORMAL-h';'P-VALUE_NORMAL';'POISON-h';'P-VALUE_POISSON'};

  [h1,p1] = chi2gof(A(:,9));
  [h2,p2] = chi2gof(B(:,9));
   pd=fitdist(A(:,9),'Poisson');
  [h3,p3]=  chi2gof(A(:,9),'CDF',pd);

   pd1=fitdist(B(:,9),'Poisson');
  [h4,p4]=  chi2gof(B(:,9),'CDF',pd1);
    
  
  T_A=[h1;p1;h3;p3];
  T_B=[h2;p2;h4;p4];

% X2 - normal distribution and Poisson distribution - RH

  [h1,p1] = chi2gof(A(:,10));
  [h2,p2] = chi2gof(B(:,10));
   pd=fitdist(A(:,10),'Poisson');
  [h3,p3]=  chi2gof(A(:,10),'CDF',pd);

   pd1=fitdist(B(:,10),'Poisson');
  [h4,p4]=  chi2gof(B(:,10),'CDF',pd1);
    
  
  RH_A=[h1;p1;h3;p3];
  RH_B=[h2;p2;h4;p4];
  
% X2 - normal distribution and Poisson distribution - Speed Wind

  [h1,p1] = chi2gof(A(:,11));
  [h2,p2] = chi2gof(B(:,11));
   pd=fitdist(A(:,11),'Poisson');
  [h3,p3]=  kstest(A(:,11),'CDF',pd);

   pd1=fitdist(B(:,11),'Poisson');
  [h4,p4]=  kstest(B(:,11),'CDF',pd1);
    
  
  WIND_A=[h1;p1;h3;p3];
  WIND_B=[h2;p2;h4;p4];

T = table(Distribution_Parameters , T_A, T_B,RH_A,RH_B,WIND_A,WIND_B);

fprintf("\n In this table we can see the results of chi-square goodness-of-fit test");
fprintf("\n for both distributions, normal and Poisson.");
fprintf("\n the values of variable h show us if it approaches (h=0)");
fprintf("\n or it doesn' t approach (h=1), each of distributions \n\n");


disp(T);

%the only index that approaches normal distribution, 
%is the index of the temperature on group A with no burn areas. 
%The other indexes at the both of areas, burned or not, reject both of distributions, normal and Poisson    