
function bcMatrix = myufun(location,state)
% %set k1,k2 
a11=1;
a12=0;
a21=0;
a22=1;
lam=abs(a11*a22-a12*a21);
k1=(a22-a12)/lam;
k2=(a11-a21)/lam;
G=0
% % G(x) for loop
for n=-10:10;
    for m=-10:10;
      f=cos(2*pi*(k1*m*location.x+k2*n*location.y))/(4*pi^2*((k1*m)^2+(k2*n)^2)+1);
      G=G+f
    end
end
% %  set boundary condition
bcMatrix = G-besselk(0,(location.x.^2+location.y.^2))/(2*pi) ; % OK to vectorize
end