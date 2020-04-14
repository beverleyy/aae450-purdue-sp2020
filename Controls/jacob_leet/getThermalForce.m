function [Fx,Fy,Fz] = getThermalForce(dirx,diry,dirz,r,temp,emis,radii,dim,constants,j)
% Constants
c = constants(2);
sigma = constants(4);

% Distance converted to AU
rps = r/149597870.700e3;

% Affected Area
A = 0.5*pi*dim(1)*dim(2);
k = 1;

% Caculation
E0 = sigma*emis(j)*temp(j)^4;
Fthermal = k*A*E0*radii(j)^2/c/rps^2;

% Force Vector
Fx = -dirx*Fthermal;
Fy = -diry*Fthermal;
Fz = -dirz*Fthermal;