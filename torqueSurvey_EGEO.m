%first satellite: Earth GEO orbits

%m = 0;
M1 = 8418;
M2 = 40476;
M3 = 42043; 
%SA = 0;

muEarth = 3.986e14;
muSun = 1.327124e20;
muMars = 4.282837e13;
REarth = (35786+6378) * 1000;
Rsun = 149597870*1000;
minRMars = 57056627899.999626;

%TORQUES: gravity gradient

%Earth
theta = .1;
TggEarth = 3 * muEarth / (2 * REarth^3) * (M3 - M1) * sind(2 * theta);

%Sun
%"sin(2x)" term is considered 1 to maximize angle
TggSun = 3 * muSun / (2 * Rsun^3) * (M3 - M1);

%Mars- Maximum possible (this is max angle AND earth as close to mars as
%possible at Mars periapsis)
TggMars = 3 * muMars / (2 * minRMars^3) * (M3 - M1);

%TORQUES: solar radiation

%FROM GALILEO (Paper by longuski et al), ESTIMATIONS
TsrS = 3.2e-7; 
TsrE = 2.2e-8;
TtrE = 2.5e-8; %planet thermal radiation from Earth
%Torque from sun is significant, as is radiation reflected from Earth.

totalEGEOtorque = TggEarth + TggSun + TggMars + TsrE + TsrS + TtrE