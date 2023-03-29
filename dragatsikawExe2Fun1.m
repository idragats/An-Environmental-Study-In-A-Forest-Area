function[L1] = dragatsikawExe2Fun1(x,y,M,n,alpha)
CIa=zeros([M,1]);
CIb=zeros([M,1]);
h=zeros([M,1]);
P_Value=zeros([M,1]);
for i=1:M
T1 = randsample(x,n);
T2 =randsample(y,n);
[h1,p1,ci1,~] = ttest2(T1,T2,alpha,'both');
h(i)=h1;
P_Value(i)=p1;
CIa(i)=ci1(1,1);
CIb(i)=ci1(2,1);
end 
L1=table(P_Value,h,CIa,CIb);
end 