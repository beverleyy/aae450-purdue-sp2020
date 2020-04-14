function [Fx,Fy,Fz] = getRadForce(dirx,diry,dirz,X,Y,Z,r,radii,dim,albedo,constants,i,j)
% Constants Declaration
c = constants(2);
f0 = constants(3);

% Distance converted to AU
rss = r/149597870.700e3;

% Affected Area
A = 0.5*pi*dim(1)*dim(2);
k = 1;

% Direct Solar Radiation
if j == 1
    f = f0/rss^2;
    Frad = k*A*f/c;
    
% Reflected Solar Radiation    
else
    rps = sqrt((X(i)-X(1))^2 + (Y(i)-Y(1))^2 + (Z(i)-Z(1))^2)/149597870.700e3;
    f = (2*albedo(j)*radii(j)^2*f0)/(3*r^2*rps^2);
    Frad = k*A*f/c;
end

Fx = -dirx*Frad;
Fy = -diry*Frad;
Fz = -dirz*Frad;