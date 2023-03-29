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
RH=          MyData(:,10); %relative humidity percentage %
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

fprintf("\n the average of the temperature in unburnt area is : mu=%f Celsius",mean(A(:,9)));
fprintf("\n the average of the temperature in burnt area is : mu=%f Celcius",mean(B(:,9)));

fprintf ("\n the difference of the average of the temperature between burnt area and unburnt area ");
fprintf(" is : dmu=%f Celsius ",mean(B(:,9))-mean(A(:,9)));

fprintf("\n we could see that the temperature of the burnt area is slightly higher value ");
fprintf("\n from unburnt area and specifically is : %f  Celcius",mean(B(:,9))-mean(A(:,9)));

fprintf("\n\n the average of the relative humidity in unburnt area is : mu=%f",mean(A(:,10)));
fprintf("\n the average of the relative humidity in burnt area is : mu=%f",mean(B(:,10)));

fprintf ("\n the difference of the average terms of the relative humidity between burnt area and unburnt area ");
fprintf("is dmu=%f percentage ",mean(A(:,10))-mean(B(:,10)));

fprintf("\n we could see also, that the relative humidity of the burnt area is slightly higher value ");
fprintf("\n from unburnt area and it's %f ha exactly ",mean(A(:,10))-mean(B(:,10)));


fprintf("\n\n  the average of the wind speed in unburnt area is : mu=%f Km/h",mean(A(:,11)));
fprintf("\n  the average of the wind speed in burnt area is : mu=%f Km/h",mean(B(:,11)));

fprintf ("\n the difference of the average terms of the wind speed  between burnt area and unburnt area  ");
fprintf("is dmu=%f Km/h ",mean(B(:,11))-mean(A(:,11)));

fprintf("\n fianlly we could see that the wind speed of the burnt area is also, slightly higher value ");
fprintf("\n from unburnt area  and it's %f Km/h exactly" ,mean(B(:,11))-mean(A(:,11)));



%from the indexes of temperature T,relative humidity RH and wind speed WIND
%we calculated  95% confidence interval for the differences means between burn areas and no-burn areas 

fprintf("\n\n In the table below we could see the 95% confidence interval for the average terms difference \n");
fprintf("between burnt and unburnt areas, h value and p value for every index \n");

n=3;
CIa=zeros([n,1]);
CIb=zeros([n,1]);
h=zeros([n,1]);
P_Value=zeros([n,1]);
alpha=0.05;
for k=9:11
   [h1,p1,ci1,stats] = ttest2(A(:,k),B(:,k),alpha,'both');
 if (k==9)
  CIa(1)=ci1(1,1);
  CIb(1)=ci1(2,1);
  h(1)=h1;
  P_Value(1)=p1;
 end
 
 if (k==10)
     CIa(2)=ci1(1,1);
     CIb(2)=ci1(2,1);
     h(2)=h1;
     P_Value(2)=p1;
 end 
     
 if (k==11)
     CIa(3)=ci1(1,1);
     CIb(3)=ci1(2,1);
     h(3)=h1;
     P_Value(3)=p1;
 end
 
end
   
Names={'T';'RH';'WIND'};   
   
T=table(Names,P_Value,h,CIa,CIb);   
disp(T);  

fprintf("\n\n we could see if the null hypothesis can be accetable or not.");
fprintf("\n for this reason we can apply the below test. ");
fprintf("\n for M=50 random samples from n=20 observation and we calculate the percentage that this reject the null hypothesis under of 95% level of significance ");
M=50;
n=20;


fprintf("\n\n 50 samples for the temperature index T\n\n");
[P1]=dragatsikawExe2Fun1(A(:,9),B(:,9),M,n,alpha);
p1=0;
for i=1:length(P1.P_Value)
  if (P1.P_Value(i)>alpha )
      p1=p1+1;
  end
end  
   
fprintf("\n  the null hypothesis for temperature index can be accepted at the percentage");
fprintf("\n %f ",p1/M*100);

fprintf("\n\n 50 samples for the relative humidity index\n\n");
[P2]=dragatsikawExe2Fun1(A(:,10),B(:,10),M,n,alpha);
p2=0;
for i=1:length(P2.P_Value)
  if (P2.P_Value(i)>alpha )
      p2=p2+1;
  end
end  
   
fprintf("\n the null hypothesis for relative humidity index can be accepted at the percentage");
fprintf("\n %f ",p2/M*100);



fprintf("\n\n 50 samples for the wind speed \n\n");
[P3]=dragatsikawExe2Fun1(A(:,11),B(:,11),M,n,alpha);


p3=0;
for i=1:length(P3.P_Value)
  if (P3.P_Value(i)>alpha )
      p3=p3+1;
  end
end  
   
fprintf("\n  the null hypothesis for wind speed index can be accepted at the percentage");
fprintf("\n %f ",p3/M*100);

figure(1)
clf; cla;
y1=[T.CIa(1);T.CIa(1)];
y2=[T.CIb(1);T.CIb(1)];
x1=[0;49];
plot(x1,y1,'g--',x1,y2,'g--')

hold on 

mu_diff1=P1.CIa+P1.CIb;

x_axis =0:49;
x_plot =[x_axis, fliplr(x_axis)];
y_plot=[P1.CIa', flipud(P1.CIb)'];

plot(x_axis, mu_diff1, 'black', 'linewidth', 1)
fill(x_plot, y_plot, 1,'facecolor', 'red', 'edgecolor', 'none', 'facealpha', 0.4);


title("CI 95% for T");

legend("95% CIa group of big samples A B","95% CIb group of big samples A B",...
"95% CI M=50 group of small samples","95% CI M=50 group of small samples");

hold off




figure(2)
clf; cla;
y3=[T.CIa(1);T.CIa(1)];
y4=[T.CIb(1);T.CIb(1)];
x2=[0;49];
plot(x2,y3,'g--',x2,y4,'g--')

hold on 

mu_diff2=P2.CIa+P2.CIb;

x_axis1 =0:49;
x_plot1 =[x_axis1, fliplr(x_axis1)];
y_plot1=[P2.CIa', flipud(P2.CIb)'];

plot(x_axis1, mu_diff2, 'black', 'linewidth', 1)
fill(x_plot1, y_plot1, 1,'facecolor', 'red', 'edgecolor', 'none', 'facealpha', 0.4);


title("CI 95% for RH");

legend("95% CIa group of big samples A B","95% CIb group of big samples A B",...
"95% CI M=50 group of small samples","95% CI M=50 group of small samples");

hold off





figure(3)
clf; cla;
y5=[T.CIa(3);T.CIa(3)];
y6=[T.CIb(3);T.CIb(3)];
x3=[0;49];
plot(x3,y5,'g--',x3,y6,'g--')

hold on 

mu_diff3=P3.CIa+P3.CIb;

x_axis2 =0:49;
x_plot2 =[x_axis2, fliplr(x_axis2)];
y_plot2=[P3.CIa', flipud(P3.CIb)'];

plot(x_axis2, mu_diff3, 'black', 'linewidth', 1)
fill(x_plot2, y_plot2, 1,'facecolor', 'red', 'edgecolor', 'none', 'facealpha', 0.4);


title("CI 95% for WIND");

legend("95% CIa group of big samples A B","95% CIb group of big samples A B",...
"95% CI M=50 group of small samples","95% CI M=50 group of small samples");

hold off

fprintf("\n\n we could see that the null hypothesis can accepted for big sample groups. ");
fprintf("\n After the calculating test and sampling with  M=50, the null hypothesis can be accepted");
fprintf("\n under of 95% confidence interval for the equality between average values ");
fprintf("\n the probability that can be accepted the null hypothesis for every index is bigest from level of significance ");