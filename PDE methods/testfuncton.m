
a11=1;
a12=0;
a21=0;
a22=1;
lam=abs(a11*a22-a12*a21);
k1=(a22-a12)/lam;
k2=(a11-a21)/lam;
x=-a11/2:0.01:a11/2;
y=-a22/2:0.01:a22/2;
[X Y]=meshgrid(x,y);
location.x=X;
location.y=Y;
G=0
% % G(x) for loop
for n=-100:100;
    for m=-100:100;
      f=cos(2*pi*(k1*m*location.x+k2*n*location.y))/(4*pi^2*((k1*m)^2+(k2*n)^2)+1);
      G=G+f;
    end
end
% %  set boundary condition
bcMatrix = G-besselk(0,sqrt(location.x.^2+location.y.^2))/(2*pi) ; % OK to vectorize
surf(X,Y,bcMatrix)
a=0.01;
[b c]=size(x)
s=round(c/2);
R0=(bcMatrix(s,s+1)+bcMatrix(s,s-1)+bcMatrix(s+1,s)+bcMatrix(s-1,s))/4