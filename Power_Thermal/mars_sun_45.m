%% Calculating Sun Irradiance
%% Initialization

Tsun = 5778; %Temperature of the Sun (K)
sigma = 5.67*10^-8; %Stefan-Boltzmann Constant (W.m^-2.K^-4)
r_s = 695700*10^3; %Volumetric Mean Radius of Sun

D_per = 206700000*1000; %Distance of Mars from Sun (center to center) (m)
D_aph = 249200000*1000; %Distance of Mars from Sun (center to center) (m)

%% Calculations

As = 4*pi * r_s^2; %Surface Area of the Sun
H0 = sigma * Tsun^4; %Intensity of the Sun's Surface (W/m^2)
D_coldest = D_aph; %Furthest distance from the Sun (m)
D_hottest = D_per; %Closest distance from the Sun (m)

H_coldest = (r_s^2)*H0/(D_coldest)^2; %Intensity of the Sun furthest from the Sun
H_hottest = (r_s^2)*H0/(D_hottest)^2; %Intensity of the Sun closest from the Sun

%% Calculating the absorptivity/emissivity ratio

%% Initialization

e_time = 1.1579 * 3600; %Eclipse time in seconds
period = 23.9345 * 3600; %Time Period of the orbit

T_cold = -10 + 273; %Coldest the body can get
T_hot = 45+273; %Hottest the body can get

%% Calculations

Alpha_ratio_cold_cold = sigma * (T_cold^4) / H_coldest
Alpha_ratio_hot_cold = sigma * (T_hot^4) / H_coldest;
Alpha_ratio_cold_hot = sigma * (T_cold^4) / H_hottest;
Alpha_ratio_hot_hot = sigma * (T_hot^4) / H_hottest 
 
Alpha_Ratio = mean([Alpha_ratio_cold_cold,Alpha_ratio_cold_hot,Alpha_ratio_hot_cold,Alpha_ratio_hot_hot]);


%{
Radius of GEO: https://earthobservatory.nasa.gov/features/OrbitsCatalog
Negligible Albedo or IR at GEO or Higher orbits: Book


%}

%% Calculating the Temperature of Satellite in GEO

%% Initialization

sigma = 5.67*10^-8; %Stefan-Boltzmann Constant (W.m^-2.K^-4)
Power_Input = 3248.2; %Power required for the entire system (Watts)
Solar_Flux = H_hottest %Solar Irradiance at the hottest point (W/m^2)
epsilon = 0.4;
alpha = epsilon*Alpha_Ratio

As = 2*4*4 + 4*4*2;
%T_space = (Solar_Flux / sigma)^0.25 %Temperature of space at that point (K)



%% Heat Fluxes

Q_space = 0; %sigma * epsilon * As * (T_space^4);
Q_albedo = 0;
Q_IR = 0;
Q_diss = 0.75*Power_Input;
Q_heater = 0;
Q_sun = Solar_Flux * alpha * As/2;

T = ((Q_space + Q_albedo + Q_IR + Q_diss + Q_heater + Q_sun)/(sigma*epsilon*As))^0.250

%T_lower = ((Q_space + Q_albedo + Q_IR + Q_diss + Q_heater)/(sigma*epsilon*As))^0.250


