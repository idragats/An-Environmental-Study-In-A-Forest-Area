function [t,p,r,ra,rb]=dragatsikawExe4Fun2(R,n,m)

r=zeros(m,1);
p=zeros(m,1);
t=zeros(m,1);
ra=zeros(m,1);
rb=zeros(m,1);
for i=1:m
[rl,pl,RL1,RU1]=corrcoef(R(:,1),R(:,i+1));
r(i)=rl(1,2);
p(i)=pl(1,2);
t(i)=rl(1,2)*sqrt((n-2)/(1-rl(1,2)^2));
ra(i)=RL1(1,2);
rb(i)=RU1(1,2); 

end