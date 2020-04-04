function [m_OMS_fuel, m_OMS_fuel_tank_empty, m_OMS_oxidizer, m_OMS_oxidizer_tank_empty, m_OMS_He, m_OMS_He_tank_empty, ...
    m_OMS_N, m_OMS_N_tank_empty, m_RCS_fuel, m_RCS_fuel_tank_empty_forward, m_RCS_fuel_tank_empty_aft, ...
    m_RCS_oxidizer, m_RCS_oxidizer_tank_empty_forward, m_RCS_oxidizer_tank_empty_aft, m_RCS_He, m_RCS_He_tank_empty, ...
    m_OMS_MPS, m_OMS_engine, m_RCS_forward_MPS, m_RCS_aft_MPS, m_RCS_engine_primary, m_RCS_engine_vernier] = ...
    Mass_calculations_propulsion_systems_pod_config_REV3()
%%%%%%%%%%%%%%%%%%%%%%%
% This code determines the total mass of the propulsion systems on the
% taxi based on Shuttle Orbiter's pod configuration. It currently assumes 
% that the valves and lines are negligible mass compared to the entire 
% weight of the system. It includes the mass of the engines themselves. 

%This code includes the ideal gas assumption for He and N

%This code has been updated to reflect new masses of the RCS engines

%Acronyms: 
%MPS = Main Propulsion Systems (everything upstream of the engines
%themselves)

%Created by: Caroline Kren
%Created on: 1/25/2020

%Last updated by: Caroline Kren
%Last updated on: 3/8/2020

%REV #: 3
%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

%Per each OMS pod (MPS + engines)
m_OMS_fuel = 2239.95; %[kg]
m_OMS_oxidizer = 3665.38; %[kg]
m_OMS_fuel_tank_empty = 113.398; %[kg]
m_OMS_oxidizer_tank_empty = 113.398; %[kg]
m_OMS_He = 21.236; %[kg]
m_OMS_He_tank_empty = 123.376; %[kg]
m_OMS_N = 0.187; %[kg]
m_OMS_N_tank_empty = 0.2516; %[kg]
m_OMS_engine = 118; %[kg]

%Per each RCS MPS
m_RCS_fuel = 447.89; %[kg]
m_RCS_oxidizer = 732.92; %[kg]
m_RCS_fuel_tank_empty_forward = 31.9329; %[kg]
m_RCS_oxidizer_tank_empty_forward = 31.9329; %[kg]
m_RCS_fuel_tank_empty_aft = 34.926; %[kg]
m_RCS_oxidizer_tank_empty_aft = 34.926; %[kg]
m_RCS_He = 1.625; %[kg] per each tank (there are two)
m_RCS_He_tank_empty = 10.8862; %[kg] per each tank (there are two)

%Per each RCS engine
m_RCS_engine_primary = 10; %[kg]
m_RCS_engine_vernier = 3.70; %[kg]

%Totals
m_OMS_MPS = m_OMS_fuel + m_OMS_oxidizer + m_OMS_fuel_tank_empty + m_OMS_oxidizer_tank_empty + m_OMS_He ...
    + m_OMS_He_tank_empty + m_OMS_N + m_OMS_N_tank_empty; %[kg] total wet mass per each OMS pod MPS

m_RCS_forward_MPS = m_RCS_fuel + m_RCS_oxidizer + m_RCS_fuel_tank_empty_forward + m_RCS_oxidizer_tank_empty_forward ...
    + (2*m_RCS_He) + (2*m_RCS_He_tank_empty); %[kg] total wet mass for RCS forward MPS

m_RCS_aft_MPS = m_RCS_fuel + m_RCS_oxidizer + m_RCS_fuel_tank_empty_aft + m_RCS_oxidizer_tank_empty_aft ...
    + (2*m_RCS_He) + (2*m_RCS_He_tank_empty); %[kg] total wet mass for RCS aft MPS

%Printing values for reference
%in Mg
% fprintf('\nMPS:')
% fprintf('\nMass of each OMS MPS: %.2f Mg\n', (m_OMS_MPS/(10^3)))
% fprintf('Mass of each forward RCS MPS: %.2f Mg\n', (m_RCS_forward_MPS/(10^3)))
% fprintf('Mass of each aft RCS MPS: %.2f Mg\n', (m_RCS_aft_MPS/(10^3)))
% fprintf('\nEngine:')
% fprintf('Mass of each OMS engine: %.2f Mg\n', (m_OMS_engine/(10^3)))
% fprintf('Mass of each primary RCS engine: %.2f Mg\n', (m_RCS_engine_primary/(10^3)))
% fprintf('Mass of each vernier RCS engine: %.2f Mg\n', (m_RCS_engine_vernier/(10^3)))
end
