sigma = 5.67*10^-8; %Stefan-Boltzmann Constant (W.m^-2.K^-4)

%% GEO
H_light = 1.3679e+03; %W/m^2
H_dark = 5; %W/m^2
Input_Power = 3770.2;%Watts
Q_dot_diss = 0.75*Input_Power; %Watts
Q_heater = 0.0546*Input_Power;
As_GEO = 6*3*3; %m^2
epsilon = 0.03
alpha = 0.09


T_upper = (((H_light * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)
T_lower = (((H_dark * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)

%% AREO

H_light = 604.2534; %W/m^2
H_dark = 0; %W/m^2
Input_Power = 3053.9;%Watts
Q_dot_diss = 0.75*Input_Power; %Watts
Q_heater = 0.0546*Input_Power;
As_GEO = 6*3*3; %m^2

epsilon = 0.03
alpha = 0.09


T_upper = (((H_light * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)
T_lower = (((H_dark * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)

%% Mars and Sun L4L5

H_light = 715.9064; %W/m^2
H_dark = 0; %W/m^2
Input_Power = 3248.2;%Watts
Q_dot_diss = 0.75*Input_Power; %Watts
Q_heater = 0.0546*Input_Power;
As_GEO = 2*4*4 + 4*4*2; %m^2

epsilon = 0.03
alpha = 0.09


T_upper = (((H_light * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)

%% Earth and Sun L4L5

H_light = 1.4136e+03; %W/m^2
H_dark = 0; %W/m^2
Input_Power = 3248.2;%Watts
Q_dot_diss = 0.75*Input_Power; %Watts
Q_heater = 0.0546*Input_Power;
As_GEO = 2*4*4 + 4*4*2; %m^2

epsilon = 0.03
alpha = 0.09


T_upper = (((H_light * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)
