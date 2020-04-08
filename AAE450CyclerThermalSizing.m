%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAE 450 Program Description 
%	This script loads the Trajectory Information and plots the position of
%	the cycler as well as plots the locations at where the cycler interacts
%	with a planet. The code also determines the hottest Temperature case
%	and determines the necessary emitted Temperature for the cycler to
%	maintain the heat flux given by the Sun. This code also sizes the
%	Thermal System for the Cycler given the constants provided in
%	Larson,Pranke.
%
%  
%
% Author Information
%	Author:             Suhas Anand, anand24@purdue.edu
%  	Team :              Power and Thermal
%  	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hf_power = 1.3e6; %watts
A_s = 39689;
engin_power = 1.8e6;
controller_power = 4000;
solar_array_power = 1.8e6;
power2heat_factor = 1;
% Determine Hot Case
L = 3.86e26;
S = L/(4*pi*(1.2436e+11)^2);
hot_case = S*A_s*0.5;
total_energy_need_diss = (hf_power+engin_power+controller_power+solar_array_power+hot_case)*power2heat_factor;
total_diss_kW = total_energy_need_diss/1000;
A_rad = total_energy_need_diss/(0.9*0.86*5.67e-8*(930^4-274^4));
IR_mars = 30*A_s;
total_energy_cold = (hf_power+IR_mars+controller_power)/1000
total_energy_heat = total_diss_kW - total_energy_cold;
% Heat Acquisition
mass_heat_ex = 17 + 0.25*(total_energy_cold);
mass_coldplate = 12*(total_energy_cold);
volume_heat_ex = 0.016+0.0012*total_energy_heat;
volume_coldplate = 0.028*total_energy_heat;

% Heat Transport
mass_pumps = 4.8*100;
power_pumps = 23*100;
volume_pumps = 0.017*100;
mass_heat_pumps = 8*total_energy_cold;
power_heat_pumps = 5.7*(mass_heat_pumps/425.1);
% Heat rejection
mass_radiators = 5.3*A_rad;
volume_radiators = 0.02*A_rad;
% PTC (Passive Thermal Control)
mass_MLI = 3*A_s;
volume_MLI = 0.01 * A_s;
mass_heaters = 0.7*total_energy_cold;
mass_louvers = 22*A_s;
volume_louvers = 0.1*A_s;
mass_heatpipes = 130;
volume_heatpipes = 260;
power_heaters = 300*8;
% Sum 
total_mass = (mass_coldplate+mass_heat_ex+mass_heat_pumps+mass_heaters+mass_heatpipes+mass_louvers+mass_MLI+mass_pumps+mass_radiators)*1.25;
total_volume = volume_coldplate+volume_heat_ex+volume_heatpipes+volume_louvers+volume_MLI+volume_pumps+volume_radiators;
total_power = power_pumps + power_heat_pumps + power_heaters;

