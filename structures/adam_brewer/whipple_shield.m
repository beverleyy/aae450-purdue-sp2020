% Author: Adam Brewer
% This script calculates the thicknesses of a Whipple shield for
% micrometeorite protection on the cycler.
% Outputs: Inner thickness, outer thickness, total thickness
% Inputs: Projectile mass, projectile density, projectile velocity,
% projectile diameter, material density, material yield strength,
% barrier spacing

clear;
clc;

% Initialize variables
m = input('Enter projectile mass (g): ');
rho_p = input('Enter projectile density (g/cm^3): ');
d = input('Enter projectile diameter (cm): ');
v = input('Enter projectile velocity (km/s): ');
rho_b = input('Enter material density (g/cm^3): ');
sigma = input('Enter material yield stress (MPa): ');
S = input('Enter space between barriers (cm): ');

% Calculations
sigma_imp = sigma * 0.145038; % convert to ksi

t_b = 0.25*d*rho_p/rho_b;
t_w = 0.16*sqrt(d)*(rho_b*rho_p)^(1/6)*m^(1/3)*v/sqrt(S)*(sigma_imp/70)^0.5;
t_t = t_b + S + t_w;

% Output results
fprintf('\nThe outer wall thickness is %.2f cm.\n', t_b);
fprintf('The inner wall thickness is %.2f cm.\n', t_w);
fprintf('The total thickness is %.2f cm.\n', t_t);
