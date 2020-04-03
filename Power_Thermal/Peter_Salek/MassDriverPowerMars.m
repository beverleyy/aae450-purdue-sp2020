%Salek, Peter               AAE 450
%MagLev Power Mars
clear
clc
close all

% Given
SA_Cart = 78.5; %m^2
Cd = 0.295;
Cart_Mass = 300*1000; %kg
g = 9.80665; %m/s^2
a = 2*g; %m/s^2
p = 0.0021; %kg/m^3
Eff = 0.75; %
t_final = 4*60+14; 
% Calculations
t = linspace(0,t_final, 10*(t_final)+1);
v = a*t;

Power = (Cart_Mass*a*v + (Cd*SA_Cart*p*v.^3)/2)/Eff/1000000000; %GW
Peak_Power = Power(length(Power))
Energy = cumtrapz(Power);
Total_Energy = Energy(length(Energy))/10 %GJoules
Average_Power = Total_Energy/t_final;

% Determine battery and solar panel sizing
% Solar
AU = 1.496*10^11;
Distance = 1.524*AU;
[Energy] = SOlRadiation(Distance);
Solar_Eff = .3;
Solar_density = 1.76; %kg/m^2

Solar_Power = Total_Energy/30/24/60/60*1000000000*3 %Watts
Solar_Area = Solar_Power/(Energy*Solar_Eff)
Solar_Mass = Solar_density*Solar_Area/1000; %Mg

% Battery
Bat_Loss = .8;
Failure_Rate = 1/1000000;
Bat_Eff = 650*3600*Bat_Loss; %J/kg
Bat_Vol_Eff = 650/1400/1000; %m^3/kg
Battery_Mass = 3*(Total_Energy*1000000000 - Solar_Power*t_final)/Bat_Eff/1000 % Mg
Battery_Mass = Battery_Mass * (1+Failure_Rate);
Battery_Volume = Battery_Mass*1000*Bat_Vol_Eff
Battery_Num_Of_Cells = Battery_Volume*100*10

% Battery Life
Cycles = 450;
Launches_Per_Year = 2;
NumOfCyclers = 4;
LifeTime = Cycles/Launches_Per_Year/NumOfCyclers

Total_Mass = Battery_Mass + Solar_Mass

plot(t, Power)
hold on
plot(t, Solar_Power*ones(length(t),1)/1000000000)
title('Power vs Time (Mars)')
xlabel('Time (seconds)')
ylabel('Power (GW)')
legend('Total Power', 'Power Provided by Solar Panels')

sigma = 3*10^7;
permeability = 4*pi*10^-7;
thickness = .015; %m
vc = 2/sigma/permeability/thickness;

F = Cart_Mass*.25;
mag_drag = (2*vc*v.^2)./(vc^2+v.^2)*F;
max_mag = max(mag_drag)/1000
figure
plot(t, mag_drag/1000)
title('Power due to Magnetic Drag')
xlabel('Time (seconds)')
ylabel('Power (kW)')

air_drag = (Cd*SA_Cart*p*v.^3)/2/1000000000/Eff;
max_air = max(air_drag)
figure
plot(t, air_drag)
title('Power due to Air Drag')
xlabel('Time (seconds)')
ylabel('Power (GW)')
