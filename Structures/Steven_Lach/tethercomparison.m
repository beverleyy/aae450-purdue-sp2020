%%This script is designed to assess the impact of the tether tip velocity
%%and taxi mass on the tether mass. This script achieves that by plotting
%%the relations next to each other.
%%Author: Steven Lach

density = 970; %Material density (kg/m^3)
uts = 3.325; %ultimat tensile strength (GPa)

%%Tether Mass vs Tip Velocity
velocityvar = [2000:1:6000]; %Max tether tip Velocity (m/s)
mass = [190000]; %Taxi Mass (kg)
sf = [10]; %Safety Factor

ts = (uts)*1e9; %Tensile Strength with safety factor built in
velmasstether = (mass.*velocityvar.*(density./(2.*ts)).^.5.*pi.^.5.*exp(density.*velocityvar.^2./(2.*ts)).*erf(velocityvar.*(density./(2*ts)).^.5))./1000; %Mass of the tether(Mg)
velmasstether = velmasstether./sf; %Adding the safety factor

%%Tether Mass vs Tether Mass
velocity = 4021.8; %Max tether tip velocity (m/s)
massvar = [50000:1:250000];
taximasstether = (massvar.*velocity.*(density./(2.*ts)).^.5.*pi.^.5.*exp(density.*velocity.^2./(2.*ts)).*erf(velocity.*(density./(2*ts)).^.5))./1000; %Mass of the tether(Mg)
taximasstether = taximasstether./sf; %Adding the safety factor

%%Output Plots
figure()
%%Tether Mass vs. Tether Tip Velocity
subplot(2,1,1) 
plot(velocityvar/1000, velmasstether, '-r')
title('Tether Mass vs. Tether Tip Velocity')
xlabel('Tether Tip Velocity (km/s)')
ylabel('Tether Mass (Mg)')

%%Tether Mass vs. Taxi Mass
subplot(2,1,2)
plot(massvar/1000, taximasstether, '-r')
title('Tether Mass vs. Taxi Mass')
xlabel('Taxi Mass (Mg)')
ylabel('Tether Mass (Mg)')
