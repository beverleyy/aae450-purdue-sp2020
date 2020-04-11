clc;
clear;
%% Introduction
% Project Escalator
%
% Code Author: Natasha Yarlagadda
%
% This code calculates various specifications and parameters for a chemical
%
% propellant based landing of the taxi on Mars

%% Assumptions
% - cylindrical propellant tanks
%
% - based on taxi configuration from beginning of Project Escalator
%
% - propellant tanks made from Al-Li alloy
%
% - heat shielding not taken into account
%
% - values may be higher in code than shown in final report due to
%
% rounding of values in hand calculations done for final report

%% Variable Initializations
m_taxi = 189.17; %(kg) mass of system
F_Falcon9 = 7686; %(kN) thrust to land Falcon 9 booster
k = 6.5; %scaling factor from Falcon 9 to taxi system (6.5 heavier)
F_RS25 = 1.86; %(MN) thrust produced by one RS-25 engine
m_RS25 = 3.17; %(Mg) mass of one RS-25 engine
p_ox = 1141; %(kg/m^3) density of liquid oxygen
p_fuel = 70.8; %(kg/m^3) density of liquid hydrogen
m_ss_total = 2000000; %(kg) total space shuttle stack mass 
m_ss_srb = 571000; %(kg) solid rocket booster mass
m_ox_ss = 617763.778; %(kg) mass of liquid oxygen on space shuttle
m_fuel_ss = 103256.22; %(kg) mass of liquid hydrogen on space shuttle
u = 1.05; %ullage scaling factor, accounts for 5% ullage
t = 0.075; %(m) thickness of tank
p_tank = 2685; %(kg/m^3) density of Al-Li alloy for tank
d_taxi = 4.2; %(m) width of taxi vehicle

%% Section I
% Calculates the required thrust to land based on system weight
F_req = (k*F_Falcon9)/1000; %(MN)

%% Section II
% Calculates # of engines needed and total added weight of engines
% Currently based on RS-25 thrust due to propellant selection
n_engine = ceil(F_req / F_RS25); %(#)
m_engine = n_engine*m_RS25; %(Mg)

%% Section III
% Calculates volumes and masses for scaling based on system corresponding
% to propellant selected. Currently this system is Space Shuttle (ss). 
m_ss = (m_ss_total - 2*m_ss_srb)/1000; %(Mg)
v_ox_ss = m_ox_ss / p_ox; %(m^3)
v_fuel_ss = m_fuel_ss / p_fuel; %(m^3)

%% Section IV
% Calculates the volumes and masses of fuel (liquid hydrogen) and oxidizer
% (liquid oxygen) in our system based on scaling factors
v_ox = (m_taxi/m_ss)*v_ox_ss; %(m^3)
v_fuel = (m_taxi/m_ss)*v_fuel_ss; %(m^3)
m_ox = (v_ox*p_ox)/1000; %(Mg)
m_fuel = (v_fuel*p_fuel)/1000; %(Mg)

%% Section V
% Calculates the tank volumes for the fuel and oxidizers
v_prop = v_ox + v_fuel; %(m^3)
v_tank = v_prop*u; %(m^3)
v_tank_ox = (v_ox/v_prop)*v_tank; %(m^3)
v_tank_fuel = (v_fuel/v_prop)*v_tank; %(m^3)

%% Section VI
% Calculates dimensions of tank, added tank weight, and total system weight
r_taxi = d_taxi/2; %(m)
h_tank = v_tank/(pi*power(r_taxi,2)); %(m)
h_outer = h_tank + 2*t; %(m)
d_outer = d_taxi + 2*t; %(m)
r_outer = d_outer/2; %(m)
v_outer = (pi*power(r_outer,2))*h_outer; %(m^3)
v_tank_material = v_outer - v_tank; %(m^3)
m_tank = (v_tank_material*p_tank)/1000; %(Mg)
m_total = m_ox + m_fuel + m_tank + m_engine; %(Mg)

%% Displaying outputs
fprintf ('Thrust required to land: %f MN\n', F_req)
fprintf ('Number of engines required to land: %f engines\n', n_engine)
fprintf ('Total mass of engines: %f Mg\n', m_engine)
fprintf ('Mass of oxidizer: %f Mg\n', m_ox)
fprintf ('Mass of fuel: %f Mg\n', m_fuel)
fprintf ('Volume of oxidizer: %f Mg\n', v_ox)
fprintf ('Volume of fuel: %f Mg\n', v_fuel)
fprintf ('Volume of total tank: %f m^3\n', v_tank)
fprintf ('Volume of oxidizer tank: %f m^3\n', v_tank_ox)
fprintf ('Volume of fuel tank: %f m^3\n', v_tank_fuel)
fprintf ('Height of total tank: %f m\n', h_outer)
fprintf ('Width of total tank: %f m\n', d_outer)
fprintf ('Mass of tank: %f Mg\n', m_tank)
fprintf ('Total mass of chemical landing system: %f Mg\n', m_total)