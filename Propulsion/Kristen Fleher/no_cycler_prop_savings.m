%% Earth to Mars Propellant Mass Savings (NO CYCLER)
clc
clear
close all

%% system values
m_taxi = 189.7; %Mg
Isp_hyd = 339; %s
Isp_lh2 = 450; %s

m = 6*m_taxi;

%% delta v's from https://www-spof.gsfc.nasa.gov/stargaze/Smars2.htm
delta_v_em = 2.945+2.649;
delta_v_me = 2.545+2.966;

%% Constants
g = 9.80665/1000;                    %gravitational constant     [km/s^2]

%% Prop Savings
%Hydrazine
m_p_sav_em_hyd = (m)*(exp(delta_v_em/g/Isp_hyd)-1); %Mg
m_p_sav_me_hyd = (m)*(exp(delta_v_me/g/Isp_hyd)-1); %Mg
m_p_sav_tot_hyd = m_p_sav_em_hyd + m_p_sav_me_hyd;
%Lox LH2
m_p_sav_em_lh2 = (m)*(exp(delta_v_em/g/Isp_lh2)-1); %Mg
m_p_sav_me_lh2 = (m)*(exp(delta_v_me/g/Isp_lh2)-1); %Mg
m_p_sav_tot_lh2 = m_p_sav_em_lh2 + m_p_sav_me_lh2;

%% No Refueling
m_p_sav_em_hyd_no = (m+m_p_sav_me_hyd)*(exp(delta_v_em/g/Isp_hyd)-1); %Mg
m_p_sav_tot_hyd_no = m_p_sav_em_hyd_no + m_p_sav_me_hyd;

m_p_sav_em_lh2_no = (m+m_p_sav_me_lh2)*(exp(delta_v_em/g/Isp_lh2)-1); %Mg
m_p_sav_tot_lh2_no = m_p_sav_em_lh2_no + m_p_sav_me_lh2;

%% output
fprintf('Hydrazine Values') 
fprintf('\nRound Trip Average Propellant Mass Savings: %.1f Mg', m_p_sav_tot_hyd)
fprintf('\nWithout Refueling: %.1f Mg', m_p_sav_tot_hyd_no)

fprintf('\n\nLH2 Values') 
fprintf('\nRound Trip Average Propellant Mass Savings: %.1f Mg', m_p_sav_tot_lh2)
fprintf('\nWithout Refueling: %.1f Mg\n', m_p_sav_tot_lh2_no)
