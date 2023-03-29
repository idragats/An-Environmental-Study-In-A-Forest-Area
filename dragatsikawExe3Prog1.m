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
RH=          MyData(:,10); %relative humidity percentage%
cW=          MyData(:,11); %wind speed (Km/h)
Rain=        MyData(:,12); %rain (mm/m^2)
Burn_Earth = MyData(:,13); %region burnt earth(ha) 


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


alpha=0.05;
Q=1000;
for k=9:11
    
if (k==9)

 h_T=zeros([Q,1]);
 P_Value_T=zeros([Q,1]);   
    for i=1:Q
    
      [V1,V2]=dragatsikawExe3Fun1(A(:,k),B(:,k));
      [p1,h1] = ranksum(V1,V2,alpha);
      h_T(i)=h1;
      P_Value_T(i)=p1;
   
    end
end
 if (k==10)
    h_RH=zeros([Q,1]);
    P_Value_RH=zeros([Q,1]);   
  
     for i=1:Q
    
        [V1,V2]=dragatsikawExe3Fun1(A(:,k),B(:,k));
         [p1,h1] = ranksum(V1,V2,alpha);  
      
     h_RH(i)=h1;
     P_Value_RH(i)=p1;
     end 
  
 end
 if (k==11)
     h_WIND=zeros([Q,1]);
     P_Value_WIND=zeros([Q,1]);   
 
    for i=1:Q
    
        [V1,V2]=dragatsikawExe3Fun1(A(:,k),B(:,k));
         [p1,h1] = ranksum(V1,V2,alpha);  
   
     h_WIND(i)=h1;
     P_Value_WIND(i)=p1;

    end 
 end
end

  

k=0;
for i=1:length(P_Value_T)
if (P_Value_T(i)>alpha)
    k=k+1;
end
end
 fprintf("\n\n the 1000 samples for the temperature index T");
fprintf("\n\n the percentage that can be accepted null hypothesis of 1000 samples");
fprintf("\n\n for temperature index is %f\n\n",k/Q*100);
    

   
l=0;
for i=1:length(P_Value_RH)
if (P_Value_RH(i)>alpha)
    l=l+1;
end
end
 fprintf("\n\n the 1000 samples for the index RH"); 
fprintf("\n\n the percentage that can be accepted null hypothesis of 1000 samples");
fprintf("\n\n for relative humidity index is %f\n\n",l/Q*100);

 
   
m=0;
for i=1:length(P_Value_WIND)
if (P_Value_WIND(i)>alpha)
    m=m+1;
end
end
fprintf("\n\n the 1000 samples for the index WIND");  
fprintf("\n\n the percentage that can be accepted null hypothesis of 1000 samples");
fprintf("\n\n for wind speed index is %f\n\n",100*m/Q);


%gia ta M=50 mikra deigmata

M=50;
n=20;

P1=zeros(M,Q);



for i=1:Q
        

[V1,V2]=dragatsikawExe3Fun1(A(:,9),B(:,9));

[h1,p1] =dragatsikawExe3Fun2(V1,V2,M,n);


P1(:,i)=p1;
end

z=0;
for i=1:M
    for j=1:Q
        if (P1(i,j)>alpha)
            z=z+1;
        end
    end
end   
fprintf("\n\n the 50 samples for the temperature index T");
fprintf("\n\n the percentage that can be accepted null hypothesis of 50 samples");
fprintf("\n\n for temperature index is %f\n\n",(100*z)/(Q*M));




P2=zeros(M,Q);



for i=1:Q
[V1,V2]=dragatsikawExe3Fun1(A(:,10),B(:,10));

[h1,p1] =dragatsikawExe3Fun2(V1,V2,M,n);

P2(:,i)=p1;
end
w=0;
for i=1:M
    for j=1:Q
        if (P2(i,j)>alpha)
            w=w+1;
        end
    end
end   
fprintf("\n\n  the 50 samples for the index RH");
fprintf("\n\n the percentage that can be accepted null hypothesis of 50 samples");
fprintf("\n\n for relative humidity index is %f\n\n",(100*w)/(Q*M));


P3=zeros(M,Q);





for i=1:Q
[V1,V2]=dragatsikawExe3Fun1(A(:,11),B(:,11));

[h1,p1] =dragatsikawExe3Fun2(V1,V2,M,n);
h_T=h1;
p_T=p1;

P3(:,i)=p1;
end
e=0;
for i=1:M
    for j=1:Q
        if (P3(i,j)>alpha)
            e=e+1;
        end
    end
end   
fprintf("\n\n the 50 samples for the index WIND");
fprintf("\n\n the percentage that can be accepted null hypothesis of 50 samples");
fprintf("\n\n for wind speed index is %f\n\n",(100*e)/(Q*M));



fprintf("\n\n Therefore, using the two standardisation tests we observe that the second has higher validity than the first due to sample size."); 
fprintf("\n However, at the 95% confidence level we could say that the two tests agree with each other,"); 
fprintf("\n which means that the null hypothesis for those medians burnt and unburnt areas is accepted at the 95% significance level"); 
fprintf("\n This means that temperature, relative humidity and wind speed are no more significant in one area than they are in the other,");
fprintf("\n i.e. burnt and unburnt areas. There is no dramatic change in any of the three indicators in the two different regions");



