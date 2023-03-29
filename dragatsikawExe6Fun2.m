function[bl,b1DEa,blDEb] = dragatsikawExe6Fun2(N1,N2,M,n)


alpha=0.05;
bl=zeros(1,M);
b1DEa=zeros(1,M);
blDEb=zeros(1,M);


for i=1:M
x = randsample(N1,n);
y = randsample(N2,n);
r = unidrnd(n,n,1);
X_new=x(r);
Y_new=y(r);


xm = [ones(n,1) X_new];
[b, ~,~,~,~] = regress(Y_new,xm);

t=tinv(1-alpha/2,n-2);

p = polyfit(X_new,Y_new,1);


bl(i) = p(1,1);
b1DEa(i) = b(2)-t*bl(i);  
blDEb(i) =b(2)+t*bl(i); 
end
end 