%% CARGO MISSION LEO TO LUNA
clc
clear 
% The goal of the cargo system is to be able to send payloads from low
% Earth orbit to the Moon without taking up one of the launch windows of
% the hybrid electrodynamic tether sling in LEO, or to bring back payloads
% from the moon, this system is both reusable and propellantless
% This analysis is preliminary and to figure out if cargo missions would be
% possible/a benifical addition

%% Constants
% Gravitational Parameter of Earth
mu_earth = 398600.4415;                             %km^3/s^2
% Mean equatorial radius of Earth 
r_earth = 6378.136;                                 %km 
% Earth's gravitational constant
g = 9.80665;                                        %(m/s^2)
% Average magnetic field of earth @ Equator
B0 = 3.12e-5;                                       % [T]

%% Time Stepping
i = 1; %s
delta_t = 60;

%% Initial Variables
% the cargo is assuemd to start at a 300 km orbit 
h(i) = 300; %km
r(i) = h(i) + r_earth;
% the final orbit of the cargo mission is at the same altitude of the
% moon's orbit
r_f = 385000; %km
% length of the wire curent is being sent through
% it is assumed the wire is rigid and alwasy in a straight line
L = 5000;                                           %m
% mass of the cargo
m_pay = 40000;
% current in wire
I_ed = 2000;                                        % [A]
% Cross sectional area of wire
A_ed = .00067245;                                   %m^2
% Density of wire
den_ed = 2710;                                      %kg/m^3
% Radius of wire
r_ed = .035;                                        %m
% Resistance of the wire 
R_ed = 2.65e-8/(pi*r_ed^2);                         %ohms/m
% Combined mass cargo and system traveling to the moon
m = m_pay + L *pi *r_ed^2 * den_ed*1.2*2;           %kg
% Circular orbit velocities of the given orbits
v(i) = sqrt(mu_earth/r(i));
v_f = sqrt(mu_earth/r_f);

%% Time Step Calculations
while r(i) < r_f
    % Magnetic Field at Altitude
    B(i) = B0 .* (r_earth./r(i)).^3;
    % Force from the electrodynamic interaciton with Earth's Magnetic Field
    F(i) = I_ed*B(i)*L;
    % Acceleration of the cargo load
    a(i) = F(i)/m;
    % Increase time step
    i = i+1;
    % New Velocity due to the acceleration
    v(i) = v(i-1) - a(i-1)*delta_t;
    % New orbit radius 
    r(i) = mu_earth/(v(i)^2);
end

%% Fial Values
% time taken for cargo mission
t_s = delta_t * i;                                  %[s]   
t_day = t_s/3600/24;                                %[day]

% current through the wires
R_ed = R_ed * L;                                    % [ohms]
% power requried for the electrical current
P = I_ed^2*R_ed/1000;                               %kW
% energy required for the system
E = P*t_day*24;                                     %kW-hr

% solar panel sizing is scaled from the solar panels used for the ED tether
% area of the solar panels
a_solar = P/500000*1242000;                         %m^2
% mass of the solar panels
m_solar = a_solar/1242000*608;                      %Mg

%% Cargo Mass Savings
% Isp of propellant combination
% Hydrazine and Liquid Oxygen
Isp_hyd = 339;                                              %s
% Liquid Hydrogen and Liquid Oxygen
Isp_lh2 = 450;                                              %s

% Mass of propellant that would be used in a typical chemical propellant
% burn instead of the ED boost
m_p_sav_hyd = (m)*(exp((v(1)-v_f)/g/Isp_hyd)-1);               %Mg
m_p_sav_lh2 = (m)*(exp((v(1)-v_f)/g/Isp_lh2)-1);               %Mg

% number of taxi launches for the mass of propellant necesary to be larger
% than the mass of the hybrid electrodynamic tether
num_taxi_hyd = ceil(m/m_p_sav_hyd);
num_taxi_lh2 = ceil(m/m_p_sav_lh2);

%% Outputs
fprintf('Mass of system: %.0f Mg', m)
fprintf('\nTime of Flight: %.0f days', t_day)
fprintf('\nInitial Orbit Radius: %.0f km', r(1))
fprintf('\nFinal Orbit Radius:  %.0f km', r_f)
fprintf('\nLength of Wires: %.1f', L)
fprintf('\nCurrent through Wires: %i A', I_ed)
fprintf('\nPower Required: %.1f kW', P)
fprintf('\nEnergy Required: %.1f kW-hr', E)
fprintf('\nSolar Panel Area: %.0f m^2', a_solar)
fprintf('\nLH_2 & LOx Propellant Mass Savings: %.1f Mg', m_p_sav_lh2)
fprintf('\nLH_2 & LOx Number of Trips for Mass Benefit: %i', num_taxi_lh2)
fprintf('\nHydrazine & LOx Propellant Mass Savings: %.1f Mg', m_p_sav_hyd)
fprintf('\nHydrazine & LOx Number of Trips for Mass Benefit: %i', num_taxi_hyd)
fprintf('\n')
