function[b1,bDEa,bDEb] = dragatsikawExe6Fun1(k1,k2,M,n)

alpha=0.05;
b1=zeros(1,M);
bDEa=zeros(1,M);
bDEb=zeros(1,M);
for i=1:M
x = randsample(k1,n);
y = randsample(k2,n);
xm = [ones(n,1) x];
[b, ~,~,~,~] = regress(y,xm);

t=tinv(1-alpha/2,n-2);

p = polyfit(x,y,1);


b1(i) = p(1,1);
bDEa(i) = b(2)-t*b1(i);  
bDEb(i) =b(2)+t*b1(i); 
end
end 