m = 0;
M1 = 8418;
M2 = 40476;
M3 = 42043; 
SA = 0;

muEarth = 3.986e14;
muSun = 1.327124e20;
muMars = 4.282837e13;

au = 1.496e+11;
REarth = au;
RSun = au;
RMars = .3814*au;

TggEarth = 3 * muEarth / (2 * REarth^3) * (M3 - M1);
TggSun = 3 * muSun / (2 * RSun^3) * (M3-M1);
TggMars = 3 * muMars / (2 * RMars^3) * (M3-M1);

TsrS = 3.2e-7; 
%From Torque survey paper. Solar radiation torque included, but not
%reflective torque from any nearby bodies. 

totalELAGtorque = TggEarth + TggSun + TggMars + TsrS