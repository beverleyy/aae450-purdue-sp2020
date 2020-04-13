%%%%%%%%%%%%%%%%% Spin-up/down Times for EVERY transfer %%%%%%%%%%%%%%%%%%%
%%%                       Author: Grace Ness                            %%%
%Global Constants%
M_taxi  = 187*10^3;          %mass of the taxi [kg]

%%%%%%%%%%%%%%%%%%%%%%% Tether Material & Power %%%%%%%%%%%%%%%%%%%%%%%%%%%
%Phobos Tether: Dyneema
rho_p = 970;                 %density of the tether [kg/m^3]
UTS_p = 3325;                %ultimate strength of tether [kN/m^2]
P_p = 1*10^9;                %tether power on Phobos [Watts]
t_p = 1.927;                 %spin-time [hours]

%Mars Tether: Dyneema
rho_m = 970;                 %density of the tether [kg/m^3]
UTS_m = 3325;                %ultimate strength of tether [kN/m^2]
P_m = 2*10^9;                %power available on Phobos [Watts]
t_m = 2;                     %spin-time [hours]

%Lunar Tether: Zylon
rho_l = 1550;                %density of the tether [kg/m^3]
UTS_l = 5800;                %ultimate strength of tether [kN/m^2]
P_l = 2*10^9;                %power available on Phobos [Watts]
t_l = 4;                     %spin-time [hours]

%%%%%%%%%%%%%%%%%%%%%%%%% Spin-up/down Times %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%To/From Phobos 
V_p = [3.5, 2.4];                  %delta V vector
[P_pp] = FINDpower(V_p,rho_p,UTS_p,M_taxi,t_p*3600);
P_reqp = (P_pp(1) - P_pp(2))./(10^9);

%To/From Mars 
V_m = [4.0, 0.22];                  %delta V vector
[P_mm] = FINDpower(V_m,rho_m,UTS_m,M_taxi,t_m*3600);
P_reqm = (P_mm(1) - P_mm(2))./(10^9);

%To/From Luna 
V_l = [5.15, 4.0];                  %delta V vector
[P_ll] = FINDpower(V_l,rho_l,UTS_l,M_taxi,t_l*3600);
P_reql = (P_ll(1) - P_ll(2))./(10^9);





