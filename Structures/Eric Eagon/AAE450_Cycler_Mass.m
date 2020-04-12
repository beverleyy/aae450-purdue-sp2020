%% AAE 450 Cycler Mass Calculation Using Given Dimensions
% Author: Eric Eagon
% Structures Team
clear
clc
%% Constants and Dimensions
[AL_yield, AL_density] = cyclerMat(6);
[rad_yield, rad_density] = cyclerMat(8);
t_AL = 0.15;
t_rad = 0.5;
Ao = 3.5*76.67;
A = 2.5*75.67;
Bo = 7*76.67;
B = 6*75.67;
Co = 3.5*7;
C = 2.5*6;
Do = 25*3.5;
D = 25*2.5;
Eo = 25*76.67;
E = 25*75.67;

Ato = (8*Ao + 4*Bo + 4*Co + 2*Do + 2*Eo);   %outer surface area
At = (4*A + 4*B + 4*C + 2*D + 2*E);     %inner surface area
Vto = Ato*t_AL;
Vt = At*t_rad;
Mt = Vto*AL_density/1000 + Vt*rad_density/1000  %mass of one cycler habitat
