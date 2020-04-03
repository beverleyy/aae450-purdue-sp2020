%Salek, Peter               AAE 450
%MagLev Power Moon
clear
clc
close all

% Given
SA_Cart = 78.5; %m^2
Cd = 0.295;
Cart_Mass = 300*1000; %kg
g = 9.80665; %m/s^2
a = 2*g; %m/s^2
p = 0.0; %kg/m^3
Eff = 0.75;
t_final = 2*60+7;
% Calculations
t = linspace(0,t_final, t_final+1);
v = a*t;

Power = (Cart_Mass*a*v + (Cd*SA_Cart*p*v.^3)/2)/Eff/1000000000; %GW
Peak_Power = Power(length(Power))
Energy = cumtrapz(Power);
Total_Energy = Energy(length(Energy)) %GJoules
Average_Power = Total_Energy/t_final;

% Determine battery and solar panel sizing
%Solar
AU = 1.496*10^11;
Distance = AU;
[Energy] = SOlRadiation(Distance);
Solar_Eff = .3;
Solar_density = 1.76; %kg/m^2

Solar_Power = Total_Energy/30/24/60/60*1000000000*3 %Watts
Solar_Area = Solar_Power/(Energy*Solar_Eff)
Solar_Mass = Solar_density*Solar_Area/1000 %Mg

% Battery
Bat_Loss = .8;
Failure_Rate = 1/1000000;
Bat_Eff = 650*3600*Bat_Loss; %J/kg
Bat_Vol_Eff = 650/1400/1000; %m^3/kg
Battery_Mass = 3*(Total_Energy*1000000000 - Solar_Power*t_final)/Bat_Eff/1000 % Mg
Battery_Volume = Battery_Mass*1000*Bat_Vol_Eff
Battery_Num_Of_Cells = Battery_Volume*100*10 

% Battery Life
Cycles = 450;
Launches_Per_Year = 2;
NumOfCyclers = 4;
LifeTime = Cycles/Launches_Per_Year/NumOfCyclers

Total_Mass = Battery_Mass + Solar_Mass

plot(t, Power)
title('Power vs Time (Moon)')
xlabel('Time (seconds)')
ylabel('Power (GW)')


