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

M=100;
n=40;
p1 = polyfit(RH,TC,1);

fprintf("\n the coefficient â from the group of sample is: â=%f",p1(1,1));

[b1,bDEa1,bDEb1] = dragatsikawExe6Fun1(RH,TC,M,n);

figure(1);
histogram(b1);
xlabel("b")
title("parametric test")
q=0;

for i=1:length(b1)
    
    if (p1(1,1)<=bDEa1(i) && p1(1,1)>=bDEb1(i))
        q=q+1;
    end
end   
fprintf("\n the percentage of appearance from parametric test is: %f percentage",q/M*100);

% Bootstrap

[bl_1,blDEa_1,blDEb_1] = dragatsikawExe6Fun2(RH,TC,M,n);

figure(2);
histogram(bl_1);
xlabel("b")
title("bootstrap test")
e=0;

for i=1:length(bl_1)
    
    if (p1(1,1)<=blDEa_1(i) && p1(1,1)>=blDEb_1(i))
        e=e+1;
    end
end   
fprintf("\n the percentage of appearance from  bootstrap test is : %f percentage",e/M*100);

fprintf("\n\n we could see the differences between of 2 tests, parametric and bootstrap. "); 
fprintf("\n  The result of distribution about the b coefficient of the parametric test shows us a narrow distribution. "); 
fprintf("\n  However the result of distribution about the b coefficient of the bootstrap test shows us a wide distribution ");
fprintf("\n  as a final result, we can have a better assessments about accuracy of the b coefficient from bootstrap test "); 
















