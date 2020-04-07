%%This script is designed to run tether calculations with a known material,
%%delta V, and taxi mass. It will output tether length, cross sectional
%%area at the tip and mass.
%%Author: Steven Lach

%%Inputs
mass = input('Taxi Mass: (kg) '); %Max mass of taxi(kg)
uts = input('Tensile Strength: (GPa) '); %Ultimate Tensile Strength of Spectra 2000 (Pa)
density = input('Material Density: (kg/m^3) '); %kg/m^3
velocity = input('Exit Velocity: (m/s) '); %Exit Velocity (m/s)

%%Intermediate Calculations
maxa = 2 * 9.80665; %Maximum g force (m/s^2)
ts = uts*1e9; %Tensile Strength with safety factor built in

%%Output Calculations: Equations based on paper by Jokic, M.D., Longuski,
%%J.M., "Design of Tether Sling for Human Transportation Systems Between
%%Earth and Mars," Journal of Spacecraft and Rockets, Vol. 41, No. 6,
%%November-December 2004, pp. 1010-1015
length = (velocity^2/maxa); %Length of the tether sling(m)
area = mass * (velocity^2/(ts*length))*10000; %Cross Sectional Area at the tip (cm^2)
masstether = (mass*velocity*(density/(2*ts))^.5*pi^.5*exp(density*velocity^2/(2*ts))*erf(velocity*(density/(2*ts))^.5))/1000; %Mass of the tether(Mg)
basearea = mass * ((velocity^2)/(ts*length))*exp((velocity^2*density)/(2*ts))*10000;%Cross Sectional Area of the tether at the base (cm^2)
masstether = masstether*10; %Accounting for sf=10
basearea = basearea*10; %Accounting for sf=10
area = area*10; %Accounting for sf=10
length = length/1000; %convert to km

%%Output Statement
fprintf('\nTether Length: %.3f km \nCross Sectional Area at the Tip: %.4f cm^2 \nCross Sectional Area at the Base: %.4f cm^2 \nTether Mass: %.1f Mg \n', length, area, basearea, masstether)