m = 0;
M1 = 8418;
M2 = 40476;
M3 = 42043; 
SA = 0;

muEarth = 3.986e14;
muSun = 1.327124e20;
muMars = 4.282837e13;

RMars = 20428*1000;
Rsun = 2.066545e+11;
minREarth = 57056627899.999626;

%gg torques
%mars
theta = .1;
TggMars = 3 * muMars / (2 * RMars^3) * (M3 - M1) * sind(2 * theta);
TggEarth = 3 * muEarth / (2 * minREarth^3) * (M3 - M1);
TggSun = 3 * muSun / (2 * Rsun^3) * (M3 - M1);

TsrS = 3.2e-7 * 490/1361; 
%solar constant reduced given increased distance from the sun. 

%solar reflection from mars (based on Earth values and scaled)
refScale = .16 / .3 * 3390^2 / 6378^2 * 148^2 / 229^2;
TsrM = 2.2e-8 * refScale;
tempScale = 148^2/229^2 * 213^4 / 288^4;
TtrM = 2.5e-8*tempScale;

totalMGEOtorque = TggEarth + TggSun + TggMars + TsrS + TsrM + TtrM
