function[h,P_Value] = dragatsikawExe3Fun2(x,y,M,n)
h=zeros([M,1]);
P_Value=zeros([M,1]);
for i=1:M
T1 = randsample(x,n);
T2 =randsample(y,n);
[p1,h1] = ranksum(T1,T2);
h(i)=h1;
P_Value(i)=p1;

end 
end 