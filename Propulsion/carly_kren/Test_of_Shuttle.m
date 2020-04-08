%%%%%%%%%%%%%%%%%%%%%%%
% This code determines compares the hand calcs final delta v when applied
% to the Shuttle Orbiter (based on data from ksc.nasa.gov) to the final
% delta V from the data given by the following online sources: Wikipedia
% and Astronautix.com. It has been concluded from this check that the hand
% calculations are sound, and that there may be a mistake in the Wikipedia
% page.

%Acronyms: 
%MPS = Main Propulsion Systems (everything upstream of the engines
%themselves)

%Created by: Caroline Kren
%Created on: 2/9/2020

%Last updated by: Caroline Kren
%Last updated on: 2/17/2020

%%%%%%%%%%%%%%%%%%%%%%%

%% Mass calcs
clear all
clc

%Per each OMS pod
m_OMS_fuel = 2239.95; %[kg]
m_OMS_oxidizer = 3665.38; %[kg]
m_OMS_fuel_tank_empty = 113.398; %[kg]
m_OMS_oxidizer_tank_empty = 113.398; %[kg]
m_OMS_He = 0.08632; %[kg]
m_OMS_He_tank_empty = 123.376; %[kg]
m_OMS_N = 0.001229; %[kg]
m_OMS_N_tank = 0.2516; %[kg]
m_OMS_engine = 118; %[kg]

%Per each RCS engine
m_RCS_fuel = 447.89; %[kg]
m_RCS_oxidizer = 732.92; %[kg]
m_RCS_fuel_tank_empty_forward = 31.9329; %[kg}
m_RCS_oxidizer_tank_forward = 31.9329; %[kg}
m_RCS_fuel_tank_empty_aft = 34.926; %[kg}
m_RCS_oxidizer_tank_aft = 34.926; %[kg}
m_RCS_He = 0.0089259; %[kg] per each tank (there are two)
m_RCS_He_tank_empty = 10.8862; %[kg] per each tank (there are two)
m_RCS_engine_primary = 19.051; %[kg]
m_RCS_engine_vernier = 1.497; %[kg]

%%

Isp = 316 %[sec] for OMS engine

%% Reference portion --> Not used in calculations, as initial mass given
%Based on ksc.nasa data

%Number OMS pods --> i.e. number OMS MPS systems = numbers aft RCS MPS
%systems
number_OMS_MPS = 2;
number_RCS_MPS_aft = number_OMS_MPS;
number_RCS_MPS_forward = 1;

%Number of engines
number_OMS = 2;
number_RCS_aft_primary = 12 * number_OMS; %using Shuttle orbiter # of RCS' used for preliminary estimate
number_RCS_aft_vernier = 2 * number_OMS; %using Shuttle orbiter # of RCS' used for preliminary estimate
number_RCS_forward_primary = 14; %using Shuttle orbiter # of RCS' used for preliminary estimate
number_RCS_forward_vernier = 2; %using Shuttle orbiter # of RCS' used for preliminary estimate


%% Constants
g_0 = 9.80665 %[m/s^2]

%% Calculations
total_m_initial = 110000 %[kg] launch mass from shuttle orbiter

total_m_final_hand_calcs = total_m_initial - (number_OMS_MPS*m_OMS_fuel) - (number_OMS_MPS*m_OMS_oxidizer);
total_m_final_online_sources = total_m_initial - 8174 - 13486; %Using Wikipedia and Astronautix data

delta_v_hand_calcs = Isp * g_0 * log(total_m_initial / total_m_final_hand_calcs)
%Sources for hand calcs = ksc.nasa.gov
delta_v_online_sources_discrepancy = Isp * g_0 * log(total_m_initial / total_m_final_online_sources)
%Sources for online sources discrepancy = wikipedia, astronautix 
fprintf('Total deltaV of Shuttle Orbiter (actual) = 300 m/s\n')
fprintf('Total deltaV of Shuttle Orbiter (hand calcs) = %.2f m/s\n', delta_v_hand_calcs)
fprintf('Total deltaV of Shuttle Orbiter (online sources discrepancy) = %.2f m/s\n', delta_v_online_sources_discrepancy)
fprintf('\nAs the deltaV from the hand calcs and the online sources do no match, after careful checking, it has been \ndetermined that to achieve the deltaV of 300m/s stated by NASA, that the hand calcs are trustworthty, and \nthere may be a mistake in both the Wikipedia page and the Astronautix page (the latter of which could have \nbeen based on the Wikipedia page.')
fprintf('\nThis conclusion is based on the severe difference in the deltaV from the online sources discrepancy data and the \ncloseness of the deltaV from the hand calcs based on ksc.nasa.gov\n')
