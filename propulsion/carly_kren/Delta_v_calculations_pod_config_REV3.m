function [m_other_components, number_pods, total_m_OMS_RCS_propulsion, total_m_initial, total_m_final, ...
    delta_v] = Delta_v_calculations_pod_config_REV3()
%%%%%%%%%%%%%%%%%%%%%%%
% This code determines the delta v achieved by the propulsion system,
% speciifcally the OMS for the taxi. This code assumes that all the fuel 
% and oxidizer are used in one firing of the engines for deltaV. 
% This code assumes the use of the OMS pods (each pod contains one engine 
% and the MPS) from the Space Shuttle Orbiter's OMS (SSOPC). This code determines
% how many SSOPC pods would be needed to achieve a delta v goal if applied
% to our taxi system, thus allowing us to use the corresponding mass values
% to design our taxi OMS configuration.

%Created by: Caroline Kren
%Created on: 1/25/2020

%Last updated by: Caroline Kren
%Last updated on: 3/8/2020

%Please note: This code reflects the mass data as of 3/8/2020

%REV #: 3
%Config: Pod
%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

%% Inputs
Isp = 316 %[sec] for OMS engine

m_landing_propulsion = 0; %[kg]
m_structures = 31207+892.80; %[kg]
m_humanfactors = 1699.20+1272+597.6+480+7.1+0.48+1418+18+14; %[kg]
m_power = 4106.80 %[kg]
m_thermal = 3459.26 %[kg]

m_other_components = m_landing_propulsion + m_structures + m_humanfactors + m_power + m_thermal; %[kg] include all compontents but propulsion (as of 3/8/2020)
extra_allotment = 30000 %allow for 30,000 kg of additional mass (allotment for changing structure)
m_other_components = m_other_components + extra_allotment; %[kg] include all components but propulsion (as of 3/8/2020) and an additional allotment for possible increase in mass changes

number_pods = 20
number_OMS_MPS = number_pods; % #OMS_MPS = #pods
number_RCS_forward_MPS = 4; %using Shuttle orbiter # of RCS forward MPS used for estimate
number_RCS_aft_MPS = number_OMS_MPS; %because the OMS and aft RCS MPS are housed together in each pod

number_RCS_aft_primary_engines = 12 * number_OMS_MPS; %using Shuttle orbiter # of RCS' used for estimate (12 x # pods = 12 x # OMS_MPS)
number_RCS_aft_vernier_engines = 2 * number_OMS_MPS; %using Shuttle orbiter # of RCS' used for estimate
number_RCS_forward_primary_engines = 14 %* number_RCS_forward_MPS; %using Shuttle orbiter # of RCS' used for estimate
number_RCS_forward_vernier_engines = 2 %* number_RCS_forward_MPS; %using Shuttle orbiter # of RCS' used for estimate
number_OMS_engines = number_OMS_MPS; %one engine per MPS P&ID
number_RCS_primary_engines = number_RCS_aft_primary_engines + number_RCS_forward_primary_engines; %summing total number of primary engines
number_RCS_vernier_engines = number_RCS_aft_vernier_engines + number_RCS_forward_vernier_engines; %summing total number of vernier engines


%% Constants
g_0 = 9.80665 %[m/s^2] acceleration due to gravity

%% Calculations for mass
[m_OMS_fuel, m_OMS_fuel_tank_empty, m_OMS_oxidizer, m_OMS_oxidizer_tank_empty, m_OMS_He, m_OMS_He_tank_empty, ...
    m_OMS_N, m_OMS_N_tank_empty, m_RCS_fuel, m_RCS_fuel_tank_empty_forward, m_RCS_fuel_tank_empty_aft, ...
    m_RCS_oxidizer, m_RCS_oxidizer_tank_empty_forward, m_RCS_oxidizer_tank_empty_aft, m_RCS_He, m_RCS_He_tank_empty, ...
    m_OMS_MPS, m_OMS_engine, m_RCS_forward_MPS, m_RCS_aft_MPS, m_RCS_engine_primary, m_RCS_engine_vernier] = ...
    Mass_calculations_propulsion_systems_pod_config_REV3(); %calling values [kg]

total_m_OMS_RCS_propulsion = (number_OMS_MPS * m_OMS_MPS) + (number_OMS_engines * m_OMS_engine) + ...
    (number_RCS_forward_MPS * m_RCS_forward_MPS) + (number_RCS_aft_MPS * m_RCS_aft_MPS) + ...
    (number_RCS_primary_engines * m_RCS_engine_primary) + (number_RCS_vernier_engines * m_RCS_engine_vernier); %the total of the wet mass for the OMS and RCS MPS and engines

total_m_initial = m_other_components + total_m_OMS_RCS_propulsion; %initial mass of taxi system

total_m_final = total_m_initial - (number_OMS_MPS * (m_OMS_fuel + m_OMS_oxidizer)); %to get deltaV due to OMS only, finding total mass of taxi system

delta_v = Isp * g_0 * log(total_m_initial / total_m_final) %delta v achieved
end
