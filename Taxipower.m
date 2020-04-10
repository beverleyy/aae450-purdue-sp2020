%%%PEM Fuel Cell%%%
%Liquid Oxygen and Hydrogen Requirements 
t=480; %mission hours for a 20 day mission
hr = 0.6*t; %hydrogen requirement output in pounds
or = 4*t; %oxygen requirement in pounds
%Liquid Hydrogen and Oxygen Tank Sizing
nhc = 92; %amount of hydrogen carried in space shuttle tank
noc = 781; %NASA oxygen capacity
htw = 216; %hydrogen tank empty weight in pounds
otw = 201; %oxygen tank empty weight in pounds
thtw = linearscale(nhc, hr, htw); %taxi hydrogen tank weight in pounds
totw = linearscale(noc, or, otw); %taxi oxygen tank weight in pounds 
nod = 26094.09; %NASA oxygen tank volume inches cubed
nhd = 49321.11; %NASA hydrogen tank volume inches cubed
otd = linearscale(noc, or, nod); %oxygen tank dimensions inches cubed
htd = linearscale(nhc, hr, nhd); %hydrogen tank dimensions inches cubed
%Water Generation
%Oxygen is limiting factor so calculate how much water can be made using
%the oxygen required
mmo = 15.999; %g/mol, molar mass of oxygen
mmh = 1.00784; %g/mol, molar mass of hydrogen
okg = (or/2.2)*1000; %oxygen required from pounds to grams
hkg = (hr/2.2)*1000; %hydrogen required from pounds to grams
molo = okg/mmo; %moles of oxygen given oxygen required
molh = hkg/mmh; %moles of hydrogen
mmh2o = 18; %molar mass of water
water = (molo*mmh2o)/1000 %mass of water needed in kilograms
%Water tank sizing
wd = 997; %density of water in kg/m^3
wtv = water/wd; %volume of water tank in m^3
%Total Mass and Volume 
fcm = 27.55778; %Total fuel cell weight in pounds
mcm = 150; %Misc. fuel cell component weight in pounds
tmass = (or+hr+thtw+totw+fcm+mcm)*2.2; %Total mass of the fuel cell system in kg
fvol = (14*15*40)*5; %total fuel cell volume in^3
tvol = (fvol+otd+htd)*0.000016387; %total power system volume






