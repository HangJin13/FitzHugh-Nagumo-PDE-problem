function bcMatrix = myufun(location,state)
% %set k1,k2 
a11=1;
a12=0;
a21=0;
a22=1;
% % % % set a1=(a11,a12) a2=(a21.a22)
% % a22=(sqrt(3)/2)/sqrt(sqrt(3)/2) for a2=pi/3
%% a11=sqrt(2)  for a2=pi/6
lam=abs(a11*a22-a12*a21);
%% lamda is the area of the lattice
% % K=0.7;
% % a=0.01;
% % x=-K:a:K;
% % y=-K:a:K;
% % % % k is the area of the graph, not relate with green function, a is the
% % % accuracy of the graph
% % [X Y]=meshgrid(x,y);
% % % mesh x,y
% % Z=besselk(0,sqrt(X.^2+Y.^2));
g=0
N=100;
for m=-N:1:N;
    for n=-N:1:N;
        k1=(a22*m-a12*n)/lam;
        k2=(a11*n-a21*m)/lam;
        f=cos(2*pi*(k1*location.x+k2*location.y))/(4*pi^2*(k1^2+k2^2)+1);
        g=g+f;
    end
end
% % Re=real(g);
% % I=imag(g);
% % R=(Re/lam)-Z/(2*pi);
% % R=(Re/lam);
% % Re is the real part of G and I is the imaginary part of G and R is the
% regular function
% % surf(X,Y,R)
% % s=(K/a)+1;
% % R0=(R(s,s+1)+R(s,s-1)+R(s+1,s)+R(s-1,s))/4
% %  set boundary condition
bcMatrix = g-besselk(0,sqrt(location.x.^2+location.y.^2))/(2*pi); % OK to vectorize
end