ME = 5.972e24; %kg
G = 6.67408e-11; %m^3/(kg*s^2)
muE = ME*G; %m^3/s^2

hOrb = (928+6378)*1000; %m
Lteth = (573.555)*1000; %m

Mteth = 19827e3; %kg
Mbank = 28000e3; %kg
Mtaxi = 182e3; %kg

Mtot = Mteth + Mbank + Mtaxi; %kg
CoM = (Mbank * 0 + Mteth * Lteth * .5 + Mtaxi * Lteth)/Mtot; %com from bank, assuming point masses for bank and taxi

%MOI calcs
l1 = CoM; %meters
l2 = (Lteth - CoM); %meters
m1t = (CoM/Lteth) * Mteth; %kg
m2t = Mteth - m1t; %kg

MOI = (l1^2 * m1t)/3 + (l2^2 * m2t)/3 + l1^2*Mbank + l2^2*Mtaxi; %kg*m^2

p = 0:.1:360; %deg
Tgg = -3/2 * muE / (hOrb)^3 * MOI * sind(2*p); %N*m
plot(p, Tgg)

%find Torque input
th = asind(1/Lteth); %deg
v = 3720.245; %m/s
dvdt = tand(th) * v^2 / (cosd(th)*Lteth); %m/s^2
aaccel = dvdt / (cosd(th) * Lteth); %rad/s^2
Tinp = aaccel * MOI; %N*m
wdes = 

hold on;
%{
plot(simout.time, simout.signals.values)
plot(simout1.time, simout1.signals.values)
maxDif = max(abs(simout.signals.values-simout1.signals.values));
Vdiff = maxDif * cosd(th) * Lteth;
%}

