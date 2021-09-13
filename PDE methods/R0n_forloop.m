clear
a11=1;
a12=0;
a21=0;
a22=1;
lam=abs(a11*a22-a12*a21);

X=0.001;
Y=0;

for N=1:1000;
    g=0;
    X0(N)=N
    for m=-N:1:N;
        for n=-N:1:N;
          k1=(a22*m-a12*n)/lam;
          k2=(a11*n-a21*m)/lam;
          f=exp(2*pi*i*(k1*X+k2*Y))/(4*pi^2*(k1^2+k2^2)+1);
          g=g+f;
        end
    end
    R(N)=g-besselk(0,X)/(2*pi);
end
plot(X0,R)