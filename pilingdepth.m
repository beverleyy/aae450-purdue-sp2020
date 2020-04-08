%%This script is designed to run piling depth calculations. 
%%Author: Steven Lach

%%Inputs
mass = input('Mass: (kg) '); %Max mass of taxi(kg)
gravity = 9.80665; %Gravity of the earth

%%Initial Calculations
burjforce = 500000000*9.80655; %Gravitational Force on the Burj Khalifa
burjdepth = 50; %Depth of Burj Khalifa Pilings
safetyfactor = 2; %Safety Factor to account for different soils

%%Piling Calculations
force = mass * gravity; %Gravitational force of the tether sling system using Earth's gravity
pilingfactor = force/burjforce; %A ratio of the tether sling gravitational force and the Burj Khalifa Gravitational force
depth = burjdepth * pilingfactor * safetyfactor; %An estimate of the piling depth needed based on the Burj Khalifa dimensions

%%Output Statements
fprintf('\nPiling Depth: %.3f m \n', depth) %Output of the piling depth (m)
