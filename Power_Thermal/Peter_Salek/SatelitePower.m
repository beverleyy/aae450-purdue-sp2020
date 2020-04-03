%Salek, Peter                   Satelite Power          AAE 450
clear
clc

% Satelite Power Requirements (Watts)
Thermal = 1.0546; % ref P&T team member
Thruster = 600; % ref prop team
Num_Thrusters = 4; %Not in Watts
COM_GEO = 850; % ref comm team
COM_EarthLagrange = 325; % ref comm team
COM_MarsLagrange = 400; % ref comm team
COM_Lagrange = COM_MarsLagrange;
COM_Mars = 232.5; % ref comm team
Extra = 1.1; %Percent extra

% Solar Panel Data
Solar_Eff = .3; %percent
Solar_thick = .003; %m
Solar_density = 1.76; %kg/m^2

% Battery Data
Bat_Eff = 650; %Wh/kg
Bat_Veff = 1400; %Wh/L
Bat_Vol = (Bat_Eff/Bat_Veff)*0.001; %m^3

% Solar Energy on each location
AU = 1.496*10^11;
Earth_Distance = AU;
Lagrange_Distance = 1.5*AU;
Mars_Distance = 1.524*AU;

[Earth_Energy] = SOlRadiation(Earth_Distance)
[Lagrange_Energy] = SOlRadiation(Lagrange_Distance)
[Mars_Energy] = SOlRadiation(Mars_Distance)

% Eclipse Time (Hours)
GEO_Eclipse = 1.15; % Ref Prop Team
Mars_Eclipse = 1.3; % Ref Prop Team

% GEO PWV
GEO_Power = (Thruster*Num_Thrusters + COM_GEO) * Extra * Thermal
GEO_Solar_Area = GEO_Power/(Earth_Energy*Solar_Eff)
GEO_Solar_Mass = Solar_density*GEO_Solar_Area
GEO_Battery_Mass = 10*Thermal*(COM_GEO)/Bat_Eff/GEO_Eclipse
GEO_Battery_Volume = Bat_Vol*GEO_Battery_Mass
GEO_Total_Mass = GEO_Battery_Mass + GEO_Solar_Mass

% Lagrange
Lagrange_Power = (Thruster*Num_Thrusters + COM_Lagrange) * Extra * Thermal
Lagrange_Solar_Area = Lagrange_Power/(Lagrange_Energy*Solar_Eff)
Lagrange_Solar_Mass = Solar_density*Lagrange_Solar_Area
Lagrange_Battery_Mass = 10*Thermal*(COM_Lagrange)/Bat_Eff/GEO_Eclipse
Lagrange_Battery_Volume = Bat_Vol*Lagrange_Battery_Mass
Lagrange_Total_Mass = Lagrange_Battery_Mass + Solar_density*Lagrange_Solar_Area

% Mars
Mars_Power = (Thruster*Num_Thrusters + COM_Mars) * Extra * Thermal
Mars_Solar_Area = Mars_Power/(Mars_Energy*Solar_Eff)
Mars_Solar_Mass = Solar_density*Mars_Solar_Area
Mars_Battery_Mass = 10*Thermal*(COM_Mars)/Bat_Eff/Mars_Eclipse
Mars_Battery_Volume = Bat_Vol*Mars_Battery_Mass
Mars_Total_Mass = Mars_Battery_Mass + Solar_density*Mars_Solar_Area
