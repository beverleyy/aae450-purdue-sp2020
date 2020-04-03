% Author: Adam Brewer
% This script calculates the stress in the rotating tethers on the cycler
% due to centripetal force.
% Outputs: Maximum stress, minimum factor of safety
% Inputs: Rotation rate, tether length, habitation module mass

clear
clc

% Initialize variables
r = input('Enter tether length (m): ');
omega  = input('Enter rotation rate (RPM): ');
A = input('Enter tether cross sectional area (m^2): ');
M = input('Enter habitation module mass (Mg): ');
rho = 1560; % density of Zylon, kg/m^3
sigma_uts = 5.8e9; % ultimate tensile stress of Zylon, N/m^2

% Intermediate calculations
omega_rad = omega * 2  * pi / 60; % convert to rad/s
m = M * 1000 / 4; % convert to kg  and account for having 4 tethers

% Perform calculations
F_h = m * omega_rad^2 * r;
sigma_h = F_h / A; % stress from habitation module

sigma_t = 0.5 * rho * omega_rad^2 * r^2; % stress from tether

sigma_tot = sigma_h + sigma_t;
sigma = sigma_tot / 1e6; % convert to MPa
fos = sigma_uts/sigma_tot;

% Output results
fprintf('\nThe maximum stress is %.1f. \n', sigma);
fprintf('The minimum factor of safety is %.1f. \n', fos);
