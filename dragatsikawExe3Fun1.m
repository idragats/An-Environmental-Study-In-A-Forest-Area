function [nr1,nr2] = dragatsikawExe3Fun1(n1,n2)
n=[n1;n2];

cols = size(n,1);
P = randperm(cols);
nr = n(P,:);
nr1=zeros(1,length(n1));
nr2=zeros(1,length(n2));

for i=1:length(n1)
    nr1(i)= nr(i);
end
for i=1:length(n2)
    nr2(i)= nr(i);
end


end