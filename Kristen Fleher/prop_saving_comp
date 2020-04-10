%% propelant mass savings by componenet
% to use input the weight of your sytem and the delta v it provides to the
% taxi
% this code calculates the amount of propellant mass that is saved by using
% the propellantless launches compared to a chemical propellant launch
clc
clear
close all

%% component values
% the mass of the system launching the vehicle (ex. tether system mass)
m_sys = 51100;                                                  %[Mg] 
% the delta v you apply to the taxi
delta_v = 6.7;                                                  %[km/s] 

%% system values
% Taxi Mass
m_taxi = 190;                                                   %[Mg]
% Isp of a LOx Hydrazine System
Isp_hyd = 339;                                                  %s
% Isp of a LOx LH2 System
Isp_lh2 = 450;                                                  %s

%% constants
% Earth's gravitational constant     
g = 9.80665/1000;                                               %[km/s^2]

%% tether prop savings
% Mass savings is the mass of chemical propellants that would be used per
% taxi launch in a typical launch
% Mass of propellant that would be used for a LOx Hydrazine System
m_p_sav_hyd = (m_taxi)*(exp(delta_v/g/Isp_hyd)-1);              %Mg
% Mass of propellant that would be used for a LOx LH2 System
m_p_sav_lh2 = (m_taxi)*(exp(delta_v/g/Isp_lh2)-1);              %Mg

%% number of taxi throws to be beneficial
% The number of taxis is the number of taxi launches necessary for the mass
% of the system to be less than the (cummulative) mass of propellants that
% would be used to launch the taxi
% Number of Taxi Launches for a LOx Hydrazine System
num_taxi_hyd = ceil(m_sys/m_p_sav_hyd);
% Number of Taxi Launches for a LOx LH2 System
num_taxi_lh2 = ceil(m_sys/m_p_sav_lh2);

%% output
fprintf('Hydrazine Values') 
fprintf('\nPropellant Mass Savings: %.1f Mg', m_p_sav_hyd)
fprintf('\nNumber of Trips for Benefit: %i', num_taxi_hyd)

fprintf('\n\nLH2 Values') 
fprintf('\nPropellant Mass Savings: %.1f Mg', m_p_sav_lh2)
fprintf('\nNumber of Trips for Benefit: %i', num_taxi_lh2)
