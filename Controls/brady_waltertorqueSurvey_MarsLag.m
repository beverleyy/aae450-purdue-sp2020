m = 0;
M1 = 8418;
M2 = 40476;
M3 = 42043; 
SA = 0;

muEarth = 3.986e14;
muSun = 1.327124e20;
muMars = 4.282837e13;

au = 1.496e+11;
REarth = au * .3814;
RMars = au * 1.3814;
RSun = au * 1.3814;

TggEarth = 3 * muEarth / (2 * REarth^3) * (M3 - M1);
TggSun = 3 * muSun / (2 * RSun^3) * (M3-M1);
TggMars = 3 * muMars / (2 * RMars^3) * (M3-M1);

TsrS = 3.2e-7 * 490/1361; 
%solar constant reduced given increased distance from the sun. 

totalMLAGtorque = TggEarth + TggSun + TggMars + TsrS
