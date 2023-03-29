function[C,D]=dragatsikawExe4Fun3(CR,p,k,n,L)
C=zeros(n,L);
D=zeros(n,L);  
 for i=1:L
    C(:,i)=randsample(CR(:,p),n);
    D(:,i)=randsample(CR(:,k),n);
end  