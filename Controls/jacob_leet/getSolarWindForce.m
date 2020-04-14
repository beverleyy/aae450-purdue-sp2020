function [Fx, Fy, Fz] = getSolarWindForce(U,V,W,dim,r,i)
% Constants
pV2 = 2.3e-9;

% Direction
speed = sqrt(U(i)^2 + V(i)^2 + W(i)^2);

diru = U(i)/speed;
dirv = V(i)/speed;
dirw = W(i)/speed;

% Distance converted to AU
rss = r/149597870.700e3;

% Affected Area
A = 0.5*pi*dim(1)*dim(2);

% Force Calculation
FSolar = pV2*A/rss^2;

% Force Vector
Fx = -diru*FSolar;
Fy = -dirv*FSolar;
Fz = -dirw*FSolar;