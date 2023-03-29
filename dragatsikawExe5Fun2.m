function[R2,adjR2,est,xgrd,ygrd] = dragatsikawExe5Fun2(x,T)
n=40;
k=3;
nr=1000;
xmin = min(x);
xmax = max(x);
xgrd = (linspace(xmin,xmax,nr))';
 
xreg = [ones(n,1) x  ];
xgr = [ones(nr,1) xgrd ];
[b, ~,~,~,~] = regress(T,xreg);
ygrd = xgr * b;
yhat = xreg * b;
muT = mean(T);
e = T-yhat;
R2 = (1-(sum(e.^2))/(sum((T-muT).^2)))*100;
adjR2 =1-((n-1)/(n-(k+1)))*(sum(e.^2))/(sum((T-muT).^2));


se2 = (1/(n-(k+1)))*(sum((T-yhat).^2));
se = sqrt(se2);
est = e ./ se;

end 