% Author: Adam Brewer
% This script calculates the dimensions and masses of the torque arm and
% central hub for a tether sling system.
% Outputs: torque arm length, torque arm mass, hub radius, hub mass, total
% mass
% Inputs: gravity acceleration, outer radius, inner radius, delta V, tether
% length

clear 
clc

% Initialize variables
g = input('Enter gravity (m/s^2): ');
ro =  input('Enter outer radius (m): ');
ri = input('Enter inner radius (m): ');
V = input('Enter target velocity (km/s): ');
l_km = input('Enter tether length (km): ');
rhoAl = 2700; % Material density, kg/m^3
sigmaAl_y = 184e6; % Al 6061-T6 tensile strength, N/m^2
rho_Dyn = 970; % Dyneema density, kg/m^3
sigmaDyn_uts = 3.325e9; % Effective dyneema ultimate tensile strength, N/m^2
M = 137363.4; % Mass of taxi, kg
syms L; % Length of torque arm, will solve for this later

% Intermediate calculations
v = V*1000;
l = l_km*1000;

% Calculate bending stress from gravity loading
sigma_g = 2*rhoAl*g*L^2*ro*(ro^2-ri^2)/(ro^4-ri^4); % N/m^2

% Calculate bending stress from centripetal force
F = 0;
for i = 0:0.01:l % Loop calculates centripetal force from the tether using an Euler method approximation
    dA = M*v^2/(sigmaDyn_uts*l)*exp(v^2*rho_Dyn/(2*sigmaDyn_uts)*(1-i^2/l^2));
    dm = dA * 0.01 * rho_Dyn;
    dFc = dm * (v/l)^2 * sqrt(L^2+i^2);
    dFb = dFc*cos(atan(l/i));
    F = F + dFb*0.01;
end
sigma_tether = 4*F*L*ro/(pi*(ro^4-ri^4)); % N/m^2
sigma_taxi = (M*v^2/(sqrt(L^2+l^2))*cos(atan(L/l)))/(pi*(ro^2-ri^2));
sigma_b = sigma_tether + sigma_taxi;

% Calculate minimum length of torque arm and masses
sigma_t = sigma_g + sigma_b; % Total stress, N/m^2
sigy_fos = sigmaAl_y / 1.5; % Accounts for factor of safety
length = vpasolve(sigma_t == sigy_fos, L);
Length = double(length(1)); % Takes the positive result
if Length > 1000
    Length = 900; % If maximum length is above 1000 m, sets to 900 m
end

rHub = 1000 - Length;
mTorque = pi*(ro^2-ri^2)*Length*rhoAl; % kg
mHub = pi*rHub^2*rhoAl*ro; % Assumes same height as torque arm, kg
mTotal = mTorque + mHub; % kg

% Output statements
mta = mTorque / 1e3; % Convert to Mg
mh = mHub / 1e3;
mt = mTotal / 1e3;
fprintf('\nThe length of the torque arm is %.1f m.\n', Length);
fprintf('The mass of the torque arm is %.2f Mg.\n', mta);
fprintf('The radius of the central hub is %.1f m.\n', rHub);
fprintf('The mass of the hub is %.1f Mg.\n', mh);
fprintf('The total mass of the system is %.0f Mg.\n', mt);
