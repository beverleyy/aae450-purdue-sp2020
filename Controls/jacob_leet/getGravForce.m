function [Fx,Fy,Fz] = getGravForce(dirx,diry,dirz,r,constants,mass,i,j)
% Defines Constant
G = constants(1);

% Calculates Net Gravitational Force
Fgrav = G*mass(i)*mass(j)/r^2;

% Separates Function into Fx,Fy,Fz directions
Fx = Fgrav*dirx;
Fy = Fgrav*diry;
Fz = Fgrav*dirz;


