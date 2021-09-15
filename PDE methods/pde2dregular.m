close;
clear;

% % basic setting
model = createpde;
a11=1;
a12=0;
a21=0;
a22=1;


% % geometry
R1 = [3,4,-(a11+a21)/2,(a11-a21)/2,(a11+a21)/2,(-a11+a21)/2,-(a12+a22)/2,(a12-a22)/2,(a12+a22)/2,(-a12+a22)/2]';
gm = [R1];
sf = 'R1';
ns = char('R1');
ns = ns';

g = decsg(gm,sf,ns);
geometryFromEdges(model,g);
axis equal

pdegplot(model,'EdgeLabels','on')


% % % boundary condition:1)in u function location.x(y) is a metrix.
applyBoundaryCondition(model,'dirichlet','Edge',[1,2,3,4],...
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

