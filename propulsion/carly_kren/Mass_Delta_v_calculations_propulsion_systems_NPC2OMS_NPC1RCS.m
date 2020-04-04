%% Mass_Delta_v_calculations_propulsion_systems_NPC2OMS_NPC1RCS.m

%%%%%%%%%%%%%%%%%%%%%%%
% This code determines the total mass of the propulsion systems on the
% taxi based on the new pod configuration for OMS (NPC2) and RCS (NPC1).
% Please note that NPC# depends on each system, so NPC1 for OMS and NPC1
% for RCS are not the same configurations, although same config. #.
% Current systems are NPC2 iteration for OMS and NPC1 iteration for RCS.
% It currently assumes that the valves and lines are negligible mass 
% compared to the entire weight of the system. It includes the mass of the 
% engines themselves. It also determines the total deltaV from the OMS.

% This code calculates the deltaV given the new configuration from OMS
% only.

% Assumes mass of the tanks is just the mass of one tank * a determined
% scaling factor of the NPC# to the OPC config. to achieve estimated deltaV
% for OMS or to achieve the structural allotment maximization for RCS.

% Note: The names of the variable names serve as comments to the line of
% code (they are made descrptive enough to not have to repeat in comments
% for description of what the variable is). For questions on the process,
% please view report.

% NPC# designs are the designs applied to the taxi system, and are not
% those of the Space Shuttle Orbiter. Such values from Space Shuttle
% Orbiter are denoted OPC.

%Acronyms: 
%MPS = Main Propulsion Systems (everything upstream of the engines
%themselves)
%OPC = Shuttle Orbiter pod configuration used applied to taxi system
%NPC2 = New pod configuration designed for OMS
%NPC1 = New pod configuration designed for RCS

%Created by: Caroline Kren
%Created on: 2/27/2020

%Last updated by: Caroline Kren
%Last updated on: 3/8/2020

%REV #: 0
%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

%% Inputs

%For the OPC config. applied to taxi
[m_other_components_OPC, number_pods_OPC, total_m_OMS_RCS_propulsion_OPC, total_m_initial_OPC, total_m_final_OPC, ...
    delta_v_OPC] = Delta_v_calculations_pod_config_REV3();

%Per each OPC pod system
[m_OMS_fuel_OPC, m_OMS_fuel_tank_empty_OPC, m_OMS_oxidizer_OPC, m_OMS_oxidizer_tank_empty_OPC, m_OMS_He_OPC, m_OMS_He_tank_empty_OPC, ...
    m_OMS_N_OPC, m_OMS_N_tank_empty_OPC, m_RCS_fuel_OPC, m_RCS_fuel_tank_empty_forward_OPC, m_RCS_fuel_tank_empty_aft_OPC, ...
    m_RCS_oxidizer_OPC, m_RCS_oxidizer_tank_empty_forward_OPC, m_RCS_oxidizer_tank_empty_aft_OPC, m_RCS_He_OPC, m_RCS_He_tank_empty_OPC, ...
    m_OMS_MPS_OPC, m_OMS_engine_OPC, m_RCS_forward_MPS_OPC, m_RCS_aft_MPS_OPC, m_RCS_engine_primary_OPC, m_RCS_engine_vernier_OPC] = ...
    Mass_calculations_propulsion_systems_pod_config_REV3();

Isp_OMS = 316; %[sec] for OMS engine 
Isp_RCS_primary = 306; %[sec] for RCS Primary thruster engine 
Isp_RCS_vernier = 280; %[sec] for RCS Vernier thruster engine 
g_0 = 9.80665; %[m/s^2] acceleration due to gravity

ullage_allowance = 0.95; %allows for (1 - ullage_allowance) percentage of ullage volume
number_pods_NPC2 = 4; %number of pod configurations = number of stacks = column stacks in new configuration for OMS

%% Per each OMS NPC2 pod system (there will be number_pods_NPC2 stacks of these) --> reference A1, A6, A7, & A16
m_OMS_fuel_NPC2 = m_OMS_fuel_OPC * number_pods_OPC / number_pods_NPC2; %[kg] fuel per tank in NPC2 config.
m_OMS_oxidizer_NPC2 = m_OMS_oxidizer_OPC * number_pods_OPC / number_pods_NPC2; %[kg] oxidizer per tank in NPC2 config.
m_OMS_He_NPC2 = m_OMS_He_OPC * number_pods_OPC / number_pods_NPC2; %[kg] He per tank in NPC2 config. (no ullage accounted for)
m_OMS_N_NPC2 = m_OMS_N_OPC * number_pods_OPC / number_pods_NPC2; %[kg] N per tank in NPC2 config. (no ullage accounted for)

density_OMS_fuel = 880; %[kg/m^3]
density_OMS_oxidizer = 1440; %[kg/m^3]
density_OMS_He = 44.115; %[kg/m^3]
density_OMS_N = 190.234; %[kg/m^3]

vol_OMS_fuel_NPC2 = m_OMS_fuel_NPC2 / density_OMS_fuel; %[m^3]
vol_OMS_oxidizer_NPC2 = m_OMS_oxidizer_NPC2 / density_OMS_oxidizer; %[m^3]
vol_OMS_He_NPC2 = m_OMS_He_NPC2 / density_OMS_He; %[m^3]
vol_OMS_N_NPC2 = m_OMS_N_NPC2 / density_OMS_N; %[m^3]

radius_OMS_He_tank_NPC2 = (3 * vol_OMS_He_NPC2 / (4*pi))^(1/3); %[m] spherical tank
diameter_OMS_He_tank_NPC2 = radius_OMS_He_tank_NPC2 * 2; %[m] spherical tank
radius_OMS_N_tank_NPC2 = (3 * vol_OMS_N_NPC2 / (4*pi))^(1/3); %[m] spherical tank
diameter_OMS_N_tank_NPC2 = radius_OMS_N_tank_NPC2 * 2; %[m] spherical tank

diameter_OMS_propellant_tank_OPC = 1.24714; %[m] domed cylinder (from Shuttle Orbiter data)
height_tot_OMS_propellant_tank_OPC = 2.448052; %[m] domed cylinder (from Shuttle Orbiter data)
ratio_diameter_height_tot_propellant_tank_OPC = diameter_OMS_propellant_tank_OPC / height_tot_OMS_propellant_tank_OPC; %ratio of OPC propellant tank diameter to total height of domed cylinder
%Applying same ratio to NPC2 system

radius_OMS_fuel_tank_NPC2 = (vol_OMS_fuel_NPC2 / (((2*((1 / ratio_diameter_height_tot_propellant_tank_OPC) - 1)) + (4/3))*pi))^(1/3); %[m] domed cylinder
radius_OMS_oxidizer_tank_NPC2 = (vol_OMS_oxidizer_NPC2 / (((2*((1 / ratio_diameter_height_tot_propellant_tank_OPC) - 1)) + (4/3))*pi))^(1/3); %[m] domed cylinder
height_cylinder_OMS_fuel_tank_NPC2 = 2 * radius_OMS_fuel_tank_NPC2 * ((1 / ratio_diameter_height_tot_propellant_tank_OPC) - 1); %[m] domed cylinder
height_cylinder_OMS_oxidizer_tank_NPC2 = 2 * radius_OMS_oxidizer_tank_NPC2 * ((1 / ratio_diameter_height_tot_propellant_tank_OPC) - 1); %[m] domed cylinder

%1 fuel tank, 1 oxidizer tank, 1 He tank, 1 N tank = 1 OMS NPC2 stack/pod
total_OMS_height_stack = (height_cylinder_OMS_fuel_tank_NPC2 + (2*radius_OMS_fuel_tank_NPC2)) + ...
    (height_cylinder_OMS_oxidizer_tank_NPC2 + (2*radius_OMS_oxidizer_tank_NPC2)) + ...
    diameter_OMS_He_tank_NPC2 + diameter_OMS_N_tank_NPC2; %[m]

m_OMS_fuel_NPC2 = m_OMS_fuel_NPC2 * ullage_allowance; %[kg] actual fuel per tank in NPC2 config., allowing for ullage volume (note that volume is directly proportional to mass, since assuming constant density)
m_OMS_oxidizer_NPC2 = m_OMS_oxidizer_NPC2 * ullage_allowance; %[kg] actual oxidizer per tank in NPC2 config., allowing for ullage volume (note that volume is directly proportional to mass, since assuming constant density)

%% Totals for the OMS NPC2 system

total_m_OMS_MPS_NPC2 = (m_OMS_fuel_NPC2 * number_pods_NPC2) + (m_OMS_oxidizer_NPC2 * number_pods_NPC2) ...
    + (m_OMS_He_NPC2 * number_pods_NPC2) + (m_OMS_N_NPC2 * number_pods_NPC2) ...
    + (m_OMS_fuel_tank_empty_OPC * number_pods_OPC) + (m_OMS_oxidizer_tank_empty_OPC * number_pods_OPC) ...
    + (m_OMS_He_tank_empty_OPC * number_pods_OPC) + (m_OMS_N_tank_empty_OPC * number_pods_OPC); %[kg]

total_m_OMS_MPS_no_tanks_NPC2 = (m_OMS_fuel_NPC2 * number_pods_NPC2) + (m_OMS_oxidizer_NPC2 * number_pods_NPC2) ...
    + (m_OMS_He_NPC2 * number_pods_NPC2) + (m_OMS_N_NPC2 * number_pods_NPC2); %[kg] to validate with hand calcs --> VALIDATED 

%Using the OPC config. to determine the scaling factor for the tanks as an
%estimate of empty tank mass

total_m_OMS_engines_NPC2 = (m_OMS_engine_OPC * number_pods_NPC2); %[kg]

%% Per each RCS NPC1 stack (there will be 2 stacks of these per column stack, with 4 columns stacks tot) --> reference A1, A15, & A16
%Each stack includes 1 fuel, 1 oxidizer, and 2 He tanks in NPC1 config.

diameter_RCS_fuel_tank_NPC1 = 0.99; %[m] domed cylinder
diameter_RCS_oxidizer_tank_NPC1 = 0.99; %[m] domed cylinder
radius_RCS_fuel_tank_NPC1 = diameter_RCS_fuel_tank_NPC1 / 2; %[m] domed cylinder
radius_RCS_oxidizer_tank_NPC1 = diameter_RCS_oxidizer_tank_NPC1 / 2; %[m] domed cylinder
%Using ratio_diameter_height_tot_propellant_tank_OPC to keep same ratio for
%the fuel and oxidizer tanks for the RCS systems (since not spherical,
%still want same factor of safety as used on shuttle orbiter)
height_cylinder_RCS_fuel_tank_NPC1 = 2 * radius_RCS_fuel_tank_NPC1 * ((1 / ratio_diameter_height_tot_propellant_tank_OPC) - 1); %[m] domed cylinder
height_cylinder_RCS_oxidizer_tank_NPC1 = 2 * radius_RCS_oxidizer_tank_NPC1 * ((1 / ratio_diameter_height_tot_propellant_tank_OPC) - 1); %[m] domed cylinder
vol_RCS_fuel_NPC1 = (height_cylinder_RCS_fuel_tank_NPC1 * pi * (radius_RCS_fuel_tank_NPC1^2)) + ((4/3)*pi*(radius_RCS_fuel_tank_NPC1^3)); %[m^3] domed cylinder
vol_RCS_oxidizer_NPC1 = (height_cylinder_RCS_oxidizer_tank_NPC1 * pi * (radius_RCS_oxidizer_tank_NPC1^2)) + ((4/3)*pi*(radius_RCS_oxidizer_tank_NPC1^3)); %[m^3] domed cylinder

vol_RCS_propellant_tank_OPC = 0.5089716508; %[m^3] domed cylinder (from Shuttle Orbiter data)
vol_RCS_He_tank_OPC = 0.0561980355; %[m^3] spherical (from Shuttle Orbiter data)
ratio_vol_propellant_to_He_tank_OPC = vol_RCS_He_tank_OPC/vol_RCS_propellant_tank_OPC; %ratio to keep the same sclaing factor by volume and mass
vol_RCS_He_NPC1 = vol_RCS_fuel_NPC1*ratio_vol_propellant_to_He_tank_OPC; %[m^3] spherical, per tank
radius_RCS_He_tank_NPC1 = (vol_RCS_He_NPC1 / ((4/3)*pi))^(1/3); %[m] per tank
diameter_RCS_He_tank_NPC1 = 2*radius_RCS_He_tank_NPC1; %[m] per tank
%For total height of the stack, unlike in the OMS NPC2 config. there are
%NOT 1 stack per 1 stacked column, and 4 stacked columns total. 
%In the RCS NPC1 config. there are 2 stacks per 1 stacked column, and 4
%stacked columns total.
total_RCS_height_stack = height_cylinder_RCS_fuel_tank_NPC1+diameter_RCS_fuel_tank_NPC1+...
    height_cylinder_RCS_oxidizer_tank_NPC1+diameter_RCS_oxidizer_tank_NPC1+...
    (2*diameter_RCS_He_tank_NPC1); %[m] Note: there are two Helium tanks
%Because we have a structural allotment of 10.5m, taking
%10.5/total_height_stack gives us 2 stacks to have per one column stack

density_RCS_fuel = 880; %[kg/m^3]
density_RCS_oxidizer = 1440; %[kg/m^3]
density_RCS_He = 32.57987809; %[kg/m^3]

m_RCS_fuel_NPC1 = vol_RCS_fuel_NPC1 * density_RCS_fuel; %[kg] per tank
m_RCS_oxidizer_NPC1 = vol_RCS_oxidizer_NPC1 * density_RCS_oxidizer; %[kg] per tank
m_RCS_He_NPC1 = vol_RCS_He_NPC1 * density_RCS_He; %[kg] per tank

number_RCS_stacks = 2; %number stacks of 1F, 1O, 2He per 1 column stack
number_RCS_column_stacks = 4; %number of column stacks
number_RCS_He_per_stack = 2; %number of He tanks per stack

%determine scaling factor before accounting for ullage
scaling_factor_empty_tanks = (m_RCS_fuel_NPC1*number_RCS_stacks*number_RCS_column_stacks) / m_RCS_fuel_OPC;

m_RCS_fuel_NPC1 = m_RCS_fuel_NPC1 * ullage_allowance; %[kg] actual fuel per tank in NPC1 config., allowing for ullage volume (note that volume is directly proportional to mass, since assuming constant density)
m_RCS_oxidizer_NPC1 = m_RCS_oxidizer_NPC1 * ullage_allowance; %[kg] actual oxidizer per tank in NPC1 config., allowing for ullage volume (note that volume is directly proportional to mass, since assuming constant density)


%% Totals for the RCS NPC1 system

total_RCS_height_stack_column = number_RCS_stacks * total_RCS_height_stack; %[m] (This is the equivalent of a 'stack' in OMS system, where 'stack=column stack' for OMS, thus 2 stacks in 1 column stack for RCS)

total_m_RCS_MPS_NPC1 = (m_RCS_fuel_NPC1*number_RCS_stacks*number_RCS_column_stacks) + ...
    (m_RCS_oxidizer_NPC1*number_RCS_stacks*number_RCS_column_stacks) + ...
    (m_RCS_He_NPC1*number_RCS_He_per_stack*number_RCS_stacks*...
    number_RCS_column_stacks)+...
    (m_RCS_fuel_tank_empty_aft_OPC*scaling_factor_empty_tanks) + ...
    (m_RCS_oxidizer_tank_empty_aft_OPC*scaling_factor_empty_tanks) + ...
    (m_RCS_He_tank_empty_OPC*number_RCS_He_per_stack*...
    scaling_factor_empty_tanks); %[kg]
%assuming that the RCS tanks will be in the aft portion of the taxi,
%therefore overestimating the 3kg difference between forward and aft empty
%tank mass (using the heavier one)
%Includes 2 tanks of He per stack and then * by the appropiate value to get
%column stack
total_m_RCS_MPS_no_tanks_NPC1 = (m_RCS_fuel_NPC1*number_RCS_stacks*number_RCS_column_stacks) + ...
    (m_RCS_oxidizer_NPC1*number_RCS_stacks*number_RCS_column_stacks) + ...
    (m_RCS_He_NPC1*number_RCS_He_per_stack*number_RCS_stacks* ...
    number_RCS_column_stacks); %[kg]

%SUBJECT TO CHANGE DEPENDING ON CONTROLS TEAM 
number_RCS_primary_engines = 17; %using Shuttle orbiter # of RCS' used for estimate
number_RCS_vernier_engines = 4; %using Shuttle orbiter # of RCS' used for estimate

total_m_RCS_engines_NPC1 = (number_RCS_primary_engines*m_RCS_engine_primary_OPC)...
    +(number_RCS_vernier_engines*m_RCS_engine_vernier_OPC); %[kg]

%% Finding DeltaV
total_m_initial_NPC2OMS_NPC1RCS = m_other_components_OPC + total_m_OMS_MPS_NPC2 + total_m_OMS_engines_NPC2 + ...
    total_m_RCS_MPS_NPC1 + total_m_RCS_engines_NPC1; %[kg] TOTAL mass of non-prop and prop

total_m_final_NPC2OMS_NPC1RCS = total_m_initial_NPC2OMS_NPC1RCS - (number_pods_NPC2 * (m_OMS_fuel_NPC2 + m_OMS_oxidizer_NPC2)); %[kg] TOTAL mass of non-prop and prop

delta_v_OMS = Isp_OMS * g_0 * log(total_m_initial_NPC2OMS_NPC1RCS / total_m_final_NPC2OMS_NPC1RCS); %[m/s] DeltaV from OMS

fprintf('Total Height OMS Stack: %.2f m', total_OMS_height_stack)
fprintf('\nTotal Number OMS Stacks: %.0f', number_pods_NPC2)
fprintf('\nTotal Mass OMS MPS (including empty tanks) NPC2: %.2f kg', total_m_OMS_MPS_NPC2)
fprintf('\nTotal Mass OMS MPS (not including empty tanks) NPC2: %.2f kg', total_m_OMS_MPS_no_tanks_NPC2)
fprintf('\nTotal Number OMS Engines NPC2: %.0f', number_pods_NPC2)
fprintf('\nTotal Mass OMS Engines NPC2: %.2f kg', total_m_OMS_engines_NPC2)
fprintf('\nTotal Wet Mass OMS: %.2f kg', total_m_OMS_MPS_NPC2+total_m_OMS_engines_NPC2) %includes empty tanks

fprintf('\n\nTotal Height RCS Stack: %.2f m', total_RCS_height_stack_column)
fprintf('\nTotal Number RCS Column Stacks: %.0f', number_pods_NPC2)
fprintf('\nTotal Mass RCS MPS (including empty tanks) NPC1: %.2f kg', total_m_RCS_MPS_NPC1)
fprintf('\nTotal Mass RCS MPS (not including empty tanks) NPC1: %.2f kg', total_m_RCS_MPS_no_tanks_NPC1)
fprintf('\nTotal Number RCS Engines NPC1: Primary - %.0f, Vernier - %.0f,', number_RCS_primary_engines, number_RCS_vernier_engines)
fprintf('\nTotal Mass RCS Engines NPC1: %.2f kg', total_m_RCS_engines_NPC1)
fprintf('\nTotal Wet Mass RCS: %.2f kg', total_m_RCS_MPS_NPC1+total_m_RCS_engines_NPC1) %includes empty tanks

fprintf('\n\nDeltaV achieved by OMS system with combined OMS NPC2 and RCS NPC1 config. = %.2f m/s\n', delta_v_OMS)

