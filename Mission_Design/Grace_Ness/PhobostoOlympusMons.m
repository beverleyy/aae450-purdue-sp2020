%SIMPLE Lambert of Phobos to Olympus Mons
% author: Grace Ness

u = 42828.372;
R = 3389.5;
a = 18.65*pi/180;
P = 2*pi*sqrt((9378^3)/u);
r1 = [9378 0 0];
v11 = [sqrt(u/R) 0 0];
r2 = [0 R*cos(a) R*sin(a)+140];
c = r2 - r1;

R1 = sqrt(r1(1)^2 + r1(2)^2 + r1(3)^2);
R2 = sqrt(r2(1)^2 + r2(2)^2 + r2(3)^2);
C = sqrt(c(1)^2 + c(2)^2 + c(3)^2);

S = 0.5*(R1 + R2 + C);

A = 710;
alpha = 2*asinh(sqrt(S/(2*A)));
beta = 2*asinh(sqrt((S - C)/(2*A)));
TOF = sqrt((A^3)/u)*((sinh(alpha) - alpha) - (sinh(beta) - beta));
H = alpha - beta; %change in hyperbolic anomaly

f = 1 - (A/R1)*(cosh(H) - 1);
g = TOF - sqrt((A^3)/H)*(sinh(H) - H);
v1 = (1./g).*(r2 - f.*r1);
f_dot = (-sqrt(u*A)/(R1*R2))*sinh(H);
g_dot = 1 - ((A/R2)*(cosh(H) - 1));
v2 = f_dot.*r1 + g_dot.*v1;
V2 = sqrt(v2(1)^2 + v2(2)^2 + v2(3)^2);
v_mars = 868.22/3600; %km/s
V1 = v1 - v11;







