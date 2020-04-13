%% Initialization
Tsun = 5778; %Temperature of the Sun (K)
sigma = 5.67*10^-8; %Stefan-Boltzmann Constant (W.m^-2.K^-4)
r_s = 695700*10^3; %Volumetric Mean Radius of Sun
As = 4*pi * r_s^2; %Surface Area of the Sun
r_e = 6378137; %Radius of the Earth (m)
z_geo = 42164 *10^3; %Altitude of GEO including Radius (m)
D_per = 147098074*1000; %Distance of Earth from Sun (center to center) (m)
D_aph = 152097701*1000; %Distance of Earth from Sun (center to center) (m)
e_time = 1.1579 * 3600; %Eclipse time in seconds
period = 23.9345 * 3600; %Time Period of the orbit
T_cold = -10 + 273; %Coldest the body can get
T_hot = 45+273; %Hottest the body can get

%% Equations
H0 = sigma * Tsun^4; %Intensity of the Sun's Surface (W/m^2)

D_coldest = D_aph + z_geo; %Coldest Distance from Earth
D_hottest = D_per - z_geo; %Hottest Dstance from Earth

H_coldest = (r_s^2)*H0/(D_coldest)^2; %Solar Irradiance at coldest
H_hottest = (r_s^2)*H0/(D_hottest)^2; %Solar Irradiance at hottest

Alpha_ratio_cold_cold = sigma * (T_cold^4) / H_coldest;
Alpha_ratio_hot_cold = sigma * (T_hot^4) / H_coldest;
Alpha_ratio_cold_hot = sigma * (T_cold^4) / H_hottest;
Alpha_ratio_hot_hot = sigma * (T_hot^4) / H_hottest ;
 
Alpha_Ratio = mean([Alpha_ratio_cold_cold,Alpha_ratio_cold_hot,Alpha_ratio_hot_cold,Alpha_ratio_hot_hot]);

fprintf('At the coldest place, furthest from the Sun, the Solar Irradiance is %d\n', H_coldest)
fprintf('At the hottest place, closest to the Sun, the Solar Irradiance is %d\n', H_hottest)

%{
Radius of GEO: https://earthobservatory.nasa.gov/features/OrbitsCatalog
Negligible Albedo or IR at GEO or Higher orbits: Book


%}

