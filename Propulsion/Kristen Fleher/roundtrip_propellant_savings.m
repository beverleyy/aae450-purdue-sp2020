%% Propellant Mass Savings - Round Trip 
% Finds the mass savings per taxi for the system
% the mass savings is the propellant mass that would be used in a typical
% chemical propulsion system

clc
clear
close all

%% system values
m_taxi = 189.7; %Mg
Isp_hyd = 339; %s
Isp_lh2 = 450; %s
%m_sys =
%Once a total system mass value is known fill in and uncomment num taxi
%section

%% delta v's (average)
% Low Earth Orbit -> Cycler
delta_v_leo_cyc_a = 4.30;                                   %km/s
% Cycler -> Mars Orbit
delta_v_cyc_lmo_a = 3.18;                                   %km/s
% Mars Orbit -> Cycler
delta_v_lmo_cyc_a = 2.80;                                   %km/s
% Cycler -> LEO
delta_v_cyc_leo_a = 4.88;                                   %km/s

%% delta v's (worst case)
% Low Earth Orbit -> Cycler
delta_v_leo_cyc_w = 4.65;                                   %km/s
% Cycler -> Mars Orbit
delta_v_cyc_lmo_w = 3.83;                                   %km/s
% Mars Orbit -> Cycler
delta_v_lmo_cyc_w = 3.55;                                   %km/s
% Cycler -> LEO
delta_v_cyc_leo_w = 5.18;                                   %km/s

%% constants
% Earth's Gravitaional Constant
g = 9.80665/1000;                                           %[km/s^2]

%% tether prop savings
%Hydrazine & LOx
m_p_sav_leo_cyc_a_hyd = (m_taxi)*(exp(delta_v_leo_cyc_a/g/Isp_hyd)-1); %Mg
m_p_sav_cyc_lmo_a_hyd = (m_taxi)*(exp(delta_v_cyc_lmo_a/g/Isp_hyd)-1); %Mg
m_p_sav_lmo_cyc_a_hyd = (m_taxi)*(exp(delta_v_lmo_cyc_a/g/Isp_hyd)-1); %Mg
m_p_sav_cyc_leo_a_hyd = (m_taxi)*(exp(delta_v_cyc_leo_a/g/Isp_hyd)-1); %Mg

m_p_sav_leo_cyc_w_hyd = (m_taxi)*(exp(delta_v_leo_cyc_w/g/Isp_hyd)-1); %Mg
m_p_sav_cyc_lmo_w_hyd = (m_taxi)*(exp(delta_v_cyc_lmo_w/g/Isp_hyd)-1); %Mg
m_p_sav_lmo_cyc_w_hyd = (m_taxi)*(exp(delta_v_lmo_cyc_w/g/Isp_hyd)-1); %Mg
m_p_sav_cyc_leo_w_hyd = (m_taxi)*(exp(delta_v_cyc_leo_w/g/Isp_hyd)-1); %Mg

m_p_sav_tot_a_hyd = m_p_sav_leo_cyc_a_hyd + m_p_sav_cyc_lmo_a_hyd + m_p_sav_lmo_cyc_a_hyd + m_p_sav_cyc_leo_a_hyd;
m_p_sav_tot_w_hyd = m_p_sav_leo_cyc_w_hyd + m_p_sav_cyc_lmo_w_hyd + m_p_sav_lmo_cyc_w_hyd + m_p_sav_cyc_leo_w_hyd;
 
%Lox LH2
m_p_sav_leo_cyc_a_lh2 = (m_taxi)*(exp(delta_v_leo_cyc_a/g/Isp_lh2)-1); %Mg
m_p_sav_cyc_lmo_a_lh2 = (m_taxi)*(exp(delta_v_cyc_lmo_a/g/Isp_lh2)-1); %Mg
m_p_sav_lmo_cyc_a_lh2 = (m_taxi)*(exp(delta_v_lmo_cyc_a/g/Isp_lh2)-1); %Mg
m_p_sav_cyc_leo_a_lh2 = (m_taxi)*(exp(delta_v_cyc_leo_a/g/Isp_lh2)-1); %Mg

m_p_sav_leo_cyc_w_lh2 = (m_taxi)*(exp(delta_v_leo_cyc_w/g/Isp_lh2)-1); %Mg
m_p_sav_cyc_lmo_w_lh2 = (m_taxi)*(exp(delta_v_cyc_lmo_w/g/Isp_lh2)-1); %Mg
m_p_sav_lmo_cyc_w_lh2 = (m_taxi)*(exp(delta_v_lmo_cyc_w/g/Isp_lh2)-1); %Mg
m_p_sav_cyc_leo_w_lh2 = (m_taxi)*(exp(delta_v_cyc_leo_w/g/Isp_lh2)-1); %Mg

m_p_sav_tot_a_lh2 = m_p_sav_leo_cyc_a_lh2 + m_p_sav_cyc_lmo_a_lh2 + m_p_sav_lmo_cyc_a_lh2 + m_p_sav_cyc_leo_a_lh2;
m_p_sav_tot_w_lh2 = m_p_sav_leo_cyc_w_lh2 + m_p_sav_cyc_lmo_w_lh2 + m_p_sav_lmo_cyc_w_lh2 + m_p_sav_cyc_leo_w_lh2;

%% num taxis
% the number of taxis that must be launched for entire system to be less
% than the mass of chemical propellant used to send an equivalent number of
% taxis

% num_taxi_hyd = m_sys/m_p_sav_tot_a_hyd;
% num_taxi_lh2 = m_sys/m_p_sav_tot_a_lh2;

%% output
fprintf('Hydrazine (Average) Values') 
fprintf('\nLEO to Cycler Mass Savings: %.1f Mg', m_p_sav_leo_cyc_a_hyd)
fprintf('\nCycler to Mars Mass Savings: %.1f Mg', m_p_sav_cyc_lmo_a_hyd)
fprintf('\nMars to Cycler Mass Savings: %.1f Mg', m_p_sav_lmo_cyc_a_hyd)
fprintf('\nCycler to LEO Mass Savings: %.1f Mg', m_p_sav_cyc_leo_a_hyd)
fprintf('\nRound Trip Average Propellant Mass Savings: %.1f Mg', m_p_sav_tot_a_hyd)
%fprintf('\nNumber of Trips for Benefit: %i', num_taxi_hyd)

fprintf('\n\nLH2 (Average) Values') 
fprintf('\nLEO to Cycler Mass Savings: %.1f Mg', m_p_sav_leo_cyc_a_lh2)
fprintf('\nCycler to Mars Mass Savings: %.1f Mg', m_p_sav_cyc_lmo_a_lh2)
fprintf('\nMars to Cycler Mass Savings: %.1f Mg', m_p_sav_lmo_cyc_a_lh2)
fprintf('\nCycler to LEO Mass Savings: %.1f Mg', m_p_sav_cyc_leo_a_lh2)
fprintf('\nRound Trip Average Propellant Mass Savings: %.1f Mg\n', m_p_sav_tot_a_lh2)
%fprintf('Number of Trips for Benefit: %i\n', num_taxi_lh2)
