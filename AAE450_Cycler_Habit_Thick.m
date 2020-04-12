%% AAE 450 Preliminary Cycler Research
% Author: Eric Eagon
% Structures Team
%% Constants
P0 = 101.325e3;  %[Pa] Cabin pressure
r = 4;  %[m]  Habitation Radius
[yield, density] = cyclerMat(1);   %AL T6061 material
eta = 10;   %safety factor

%% Calculations
%Wall thickness
sigma_hoop = yield;   %max allowable hoop stress
t_min = P0 * r / sigma_hoop;   %[m] minimum allowable thickness
t_a = t_min * eta;   %[m] acceptable thickness of pressurized habitat
t_a = 0.1;
%Mass and Volume of Pressurized Habitat
L = 80;  %[m] length of tube
A = pi*((r+t_a/2)^2 - (r-t_a/2)^2);  %[m^2] cross sectional area
V = 4*L*A;  %[m^3] volume of aluminum
M_press = density*V;   %[kg] mass of pressurized tube

%Excess empty mass:
M_whip = 209e3;  %[kg]   whipple shield
M_ex = 400;  %[kg]       exercise machines
M_emergenc = 60;  %[kg]  emergency supplies
M_bioregen = 500;  %[kg]  bioregenerative structure

M_empty = (M_press + M_whip)/1000;
V_empty = (pi/2*r^2)*L*4;   %half the tube is habitable (not beneath the floor) and there are 4 tubes

%% Mass of Habitat
[al_yield, al_density] = cyclerMat(6);
[comp_yield, comp_density] = cyclerMat(7);
t = 0.1;
t_comp = 0.02;
h = 2.5;
A_floor_int = 50*50.31;
A_floor_hab = 6*75.67;
V_int_al = (2*A_floor_int*t + 2*t*h*50.31 + 2*t*h*50)*2;
V_hab_al = (2*A_floor_hab*t + 2*t*6 + 2*t*75.67)*2;
V_int_comp = (2*A_floor_int*t_comp + 2*t_comp*h*50.31 + 2*t_comp*h*50)*2;
V_hab_comp = (2*A_floor_hab*t_comp + 2*t_comp*6 + 2*t_comp*75.67)*2;
V = V_int_al + V_hab_al + V_int_comp + V_hab_comp;
M_hab = (V_int_al + V_hab_al)*al_density + (V_int_comp + V_hab_comp)*comp_density;
