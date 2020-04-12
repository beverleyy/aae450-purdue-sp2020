%% AAE 450 Cycler Pressure Structural Analysis
% Author: Eric Eagon
% Structures Team
%% Constants and Dimensions
P = 101.3; %[kPa]
[yield, density] = cyclerMat(6);   %AL 7075-T6
H = 2.5;  %[m] height of hab module
h = 4;  %[m] width of hab module
Lv = 30;  %[m] length of hallway with supporting stay
alpha = H/h;
C = H/2+0.2;
syms t1 t2
I1 = H*t1^3/12;   %[m^4] moment of inerita of strip of thickness, t1
I2 = 2*h*t2^3/12;   %[m^4] moment of interia of strip of thickness, t2
K = I2/I1*alpha;
% Stress values
S1 = P*h/(4*t1)*(4-((2+K*(5+alpha^2))/(1+2*K)));
S2 = S1 + P*h^2*C/(12*I2)*(1+K*(3-alpha^2))/(1+2*K);
S3 = S1 + P*h^2*C/(12*I2)*(1+2*alpha^2*K)/(1+2*K);
% Allowable stress
eta = 5;  %Safety factor
S_allow = yield/1000/eta;  %[kPa]
% Test values of thickness
t1p = 0.15;  %[m]
t2p = 0.15;  %[m]
% Print values
S_allow
S1p = vpa(subs(S1,[t1,t2],[t1p,t2p]),6)  %[kPa]
S2p = vpa(subs(S2,[t1,t2],[t1p,t2p]),6)  %[kPa]
S3p = vpa(subs(S3,[t1,t2],[t1p,t2p]),6)  %[kPa]
