clear;clc;

aval=load('G3.txt');

j=1;
for i=1:50:size(aval,1)
     cor(j,:)=aval(i,:);
     j=1+j;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=size(cor,1);
X1=zeros(a,1);
Y1=zeros(a,1);
Z1=zeros(a,1);
X1(:,1)=cor(:,1);
Y1(:,1)=cor(:,2);
Z1(:,1)=cor(:,3);

X2=(X1-min(X1))./((max(X1)-min(X1)));
X=(X2-.5).*2;

Y2=(Y1-min(Y1))./((max(Y1)-min(Y1)));
Y=(Y2-.5).*2;

Z2=(Z1-min(Z1))./((max(Z1)-min(Z1)));
Z=(Z2-.5).*2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bir=zeros(size(X,1),1);
bir(:,1)=1;
A=[bir X Y X.^2 X.*Y Y.^2 X.^3 (X.^2).*Y X.*(Y.^2) Y.^3];
B=inv(A'*A)*A'*Z;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x, y] = meshgrid([min(X):.1:max(X)],[min(Y):.1:max(Y)]);

z =B(1) + B(2)*x + B(3)*y + B(4)*x.^2 + B(5)*(x.*y) + B(6)*y.^2 + B(7)*x.^3 +B(8)*((x.^2).*y) + B(9)*(x.*(y.^2)) + B(10)*y.^3;
x=(x./2+.5).*((max(X1)-min(X1)))+min(X1);
y=(y./2+.5).*((max(Y1)-min(Y1)))+min(Y1);
z=(z./2+.5).*((max(Z1)-min(Z1)))+min(Z1);

% mesh(x,y,z);hold on;
% plot3(X1,Y1,Z1,'.'); hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ZZ = B(1) + B(2).*X + B(3).*Y + B(4).*X.^2 + B(5).*(X.*Y) + B(6).*Y.^2 + B(7).*X.^3 +B(8).*((X.^2).*Y) + B(9).*(X.*(Y.^2)) + B(10).*Y.^3;
ZZZ=(ZZ./2+.5).*((max(Z1)-min(Z1)))+min(Z1);
err=Z1-ZZZ;   
      
g=-1;
a=1;
b=4;
w=2;

for i=1:size(err,1)
    if err(i,1)<=g
        p(i,i)=1;
    elseif g<err(i,1)<=g+w
        p(i,i)=1/(1+a*(err(i,1)-g)^b);
    else p(i,i)=0;
    end
end

B=inv(A'*p*A)*A'*p*Z;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ZZ = B(1) + B(2).*X + B(3).*Y + B(4).*X.^2 + B(5).*(X.*Y) + B(6).*Y.^2 + B(7).*X.^3 +B(8).*((X.^2).*Y) + B(9).*(X.*(Y.^2)) + B(10).*Y.^3;
%    ZZZ=(ZZ./2+.5).*((max(Z1)-min(Z1)))+min(Z1);
%     err1=Z1-ZZZ;

cor=load('G3.txt');

a=size(cor,1);
X1=zeros(a,1);
Y1=zeros(a,1);
Z1=zeros(a,1);
X1(:,1)=cor(:,1);
Y1(:,1)=cor(:,2);
Z1(:,1)=cor(:,3);

X2=(X1-min(X1))./((max(X1)-min(X1)));
X=(X2-.5).*2;

Y2=(Y1-min(Y1))./((max(Y1)-min(Y1)));
Y=(Y2-.5).*2;

Z2=(Z1-min(Z1))./((max(Z1)-min(Z1)));
Z=(Z2-.5).*2;

ZZ = B(1) + B(2).*X + B(3).*Y + B(4).*X.^2 + B(5).*(X.*Y) + B(6).*Y.^2 + B(7).*X.^3 +B(8).*((X.^2).*Y) + B(9).*(X.*(Y.^2)) + B(10).*Y.^3;
ZZZ=(ZZ./2+.5).*((max(Z1)-min(Z1)))+min(Z1);
err1=Z1-ZZZ;

thresholdd=(err1>1);
exploree=find(thresholdd==1);
X1(exploree)=[];
Y1(exploree)=[];
Z1(exploree)=[];
aval2=[X1,Y1,Z1];

% plot3(X1,Y1,Z1,'.'); hold off;

j=1;
for i=1:150:size(aval2,1)
     cor2(j,:)=aval2(i,:);
     j=1+j;
end

a=size(cor2,1);
X1=zeros(a,1);
Y1=zeros(a,1);
Z1=zeros(a,1);
X1(:,1)=cor2(:,1);
Y1(:,1)=cor2(:,2);
Z1(:,1)=cor2(:,3);


F=scatteredInterpolant(X1,Y1,Z1,'linear','none');

ti = min(X1):1:max(X1);
tj = min(Y1):1:max(Y1);


[xq,yq] = meshgrid(ti,tj);


vq = F(xq,yq);



figure
surf(xq,yq,vq,'EdgeAlpha',0);

