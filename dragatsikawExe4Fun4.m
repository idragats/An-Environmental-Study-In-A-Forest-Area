function [tlower,tupper]=dragatsikawExe4Fun4(A1,A2,alpha,L,n)
t=zeros(1,L);
for i=1:L
    [rl,~]=corrcoef(A1(:,i),A2(:,i));
    t(i)=rl(1,2)*sqrt((n-2)/(1-rl(1,2)^2));
   
end    
     H=sort(t);
    tlower=H(L*alpha/2);
    tupper=H(L*(1-alpha/2));
end    