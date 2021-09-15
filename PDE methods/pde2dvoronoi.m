close;
clear;

% % basic setting
model = createpde;

% % set the lattices
a11=1;
a12=0;
a21=0.5;
a22=sqrt(3)/2;
x_1=-(a12^2*a22-a22^2*a12-a21^2*a12+a11^2*a22)/(2*(a21*a12-a11*a22));
if a12 ~=0
  y_1=-(a11/a12)*(x_1-a11/2)+a12/2;
else 
  y_1=-(a21/a22)*(x_1-a21/2)+a22/2;
end

b11=a21;
b12=a22;
b21=a21-a11;
b22=a22-a12;
x_2=-(b12^2*b22-b22^2*b12-b21^2*b12+b11^2*b22)/(2*(b21*b12-b11*b22));
if b12 ~=0
  y_2=-(b11/b12)*(x_2-b11/2)+b12/2;
else 
  y_2=-(b21/b22)*(x_2-b21/2)+b22/2;
end

c11=b21;
c12=b22;
c21=-a11;
c22=-a12;
x_3=-(c12^2*c22-c22^2*c12-c21^2*c12+c11^2*c22)/(2*(c21*c12-c11*c22));
if c12 ~=0
  y_3=-(c11/c12)*(x_3-c11/2)+c12/2;
else 
  y_3=-(c21/c22)*(x_3-c21/2)+c22/2;
end


% % % geometry R1 denote the pde lattice
R1 = [3,6,x_1,x_2,x_3,-x_1,-x_2,-x_3,y_1,y_2,y_3,-y_1,-y_2,-y_3]';

gm = [R1];
sf = 'R1';
ns = char('R1');
ns = ns';

g = decsg(gm,sf,ns);
geometryFromEdges(model,g);
axis equal

pdegplot(model,'EdgeLabels','on')


% % % boundary condition:1)in u function location.x(y) is a metrix.
applyBoundaryCondition(model,'dirichlet','Edge',[1:6],...
                                         'u',@myufun,...
                                         'Vectorized','on');




% % pde condition m∂^2u/∂t^2+d∂u/∂t −∇·(c∇u)+au=f
specifyCoefficients(model,'m',0,'d',0,'c',1,'a',1,'f',0);

% % mesh
generateMesh(model,'Hmax',0.1);


% % solve
results = solvepde(model);
u = results.NodalSolution;


% % plot
pdeplot(model,'XYData',u)
b=min(u)

