%% ED Boost of the electrodynamic hybrid tether after taxi launches
clc
clear 

%% Constants
% Mean equatorial raius of Earth
r_earth = 6378.136;                                     % [km]
% Earths gravitational constant
g = 9.80665;                                            %[m/s^2]
% Average magnetic field at Earth's equator
B0 = 3.12e-5;                                           % [T]
% Gravitational parameter of Earth
mu_earth = 398600.4415;                                 % km^3/s^2

%% Mass of Given System Components
% Taxi Mass
m_taxi = 189.3;                                         % [Mg]
% Tether Mass
m_tether = 19827.4;                                     % [Mg]
% Momentum Bank Mass
m_mombank = 30000;                                      % [Mg]
% Hub & Arm Mass
m_hub = 63828;                                          % [Mg]
% Total Mass of System
m = m_tether + m_mombank + m_hub;                       % [Mg]

%% Given Parameters 
% Maximum Time Allowed for Boost
% The boost will occur after two taxi launches and must be completed before
% the tether must spin up again (the time between launches is 13.5 days)
t_max = 8;                                              % [days]
t_max_s = t_max * 24*3600;                              % [s]
i=1;
% Current through Wires
I_ed = 50;                                              %[Amps]
% Resistance per length of copper wrires
R_ed = .011*1000/304.8;                                 %ohms/m
% Cross sectional area of the copper wire
A_ed = .00067245;                                       %m^2
% Density of the copper wires
den_ed = 8960;                                          %kg/m^3
% Altitude of system after two taxi launches
h_init = 911;                                           %km
% Initial raidus of orbit
r(i) = h_init + r_earth;
% Inital velocity of system 
% assumes fully circular orbit
v(i) = sqrt(mu_earth/r(i));
% Altitude of system after boost
h_f = 956;                                              %km
% Radius of Orbit afte boost
r_f = h_f + r_earth;
% Final velocity of system 
% assumes fully circular orbit
v_f = sqrt(mu_earth/r_f);
% Change in velocity necissary to be applied
delta_v = 0.022333*1000;                                %m/s

%% Maximum Values
% Maximum current for copper wires
I_max = 770;
% Maximum power of system
p_max = 500*1e6;
% Time step
delta_t = 1; %s

%% Time Step Calculations
while r(i) < r_f
    % Earth's Magnetic Field at Altitude
    B(i) = B0 .* (r_earth./r(i)).^3;
    % Find an appropriate total length of the wires based on force required
    % and force at lowest altitude 
    if(i==1)
        % Total forces needed for the required for the boost
        F_boost_tot = (m*1e3)*(delta_v*2)/t_max_s;
        % Combined length of the ed wires
        L_eff = F_boost_tot/(I_max*B)/(t_max*10);
    end
    % Instantaneous Force on System
    F(i) = I_ed*B(i)*L_eff;
    % Acceleration of system
    a(i) = F(i)/m;
    % Time step
    i = i+1;
    % addition of change in velocity
    v(i) = v(i-1) - (a(i-1)*delta_t)/1000;
    % change in orbit altitiude 
    r(i) = mu_earth/(v(i)^2);
end

%% Final Values
% Total Time of Boost
t = i*delta_t;
t_day = t/24/3600;
% Resistance of ED Wires
R_ed = R_ed*L_eff;

%% power required from boost
% Power Required
p_ed = I_ed^2*R_ed;                                     %W
% Voltage Requred
V = I_ed*R_ed;                                          %V
% Energy Required
E = p_ed*t_max*24/1000;                                 %kW-hr

%% ED System Sizing
% Mass of ED wires for boost
m_ed = L_eff*A_ed*den_ed/1000; %Mg
% Radius of disk containing ED Wires
r_ed = sqrt((L_eff*.03)*4/pi); %m

%% System Checks
% Checks if ED boost system is too massive
if (m_ed > m_mombank/8)
    fprintf('ED MASS TOO LARGE\n')
end

% Checks if the time of the boost is too long
if (i*delta_t > t_max_s)
    fprintf('TOO LONG OF BOOST\n')
end

% Checks if the power required exceeds the power allotted for the boost
if (p_ed > p_max)
    fprintf('POWER REQUIREMENT TOO LARGE\n')
end

%% prop savings just boost
% Isp of propellant combination
% Hydrazine and Liquid Oxygen
Isp_hyd = 339;                                              %s
% Liquid Hydrogen and Liquid Oxygen
Isp_lh2 = 450;                                              %s

% Mass of propellant that would be used in a typical chemical propellant
% burn instead of the ED boost
m_p_sav_hyd = (m)*(exp(delta_v/g/Isp_hyd)-1);               %Mg
m_p_sav_lh2 = (m)*(exp(delta_v/g/Isp_lh2)-1);               %Mg

% number of taxi launches for the mass of propellant necesary to be larger
% than the mass of the hybrid electrodynamic tether
num_taxi_hyd = ceil(m/m_p_sav_hyd);
num_taxi_lh2 = ceil(m/m_p_sav_lh2);

%% Outputs
fprintf('Mass of system: %.0f Mg', m)
fprintf('\nTime of Flight: %.0f days', t_day)
fprintf('\nInitial Orbit Radius: %.0f km', r(1))
fprintf('\nFinal Orbit Radius:  %.0f km', r_f)
fprintf('\nCombined Length of Wires: %.1f', L_eff)
fprintf('\nRadius of Wires Disk: %.1f', r_ed)
fprintf('\nCurrent through Wires: %i A', I_ed)
fprintf('\nPower Required: %.1f kW', p_ed)
fprintf('\nLH_2 & LOx Propellant Mass Savings: %.1f Mg', m_p_sav_lh2)
fprintf('\nLH_2 & LOx Number of Trips for Mass Benefit: %i', num_taxi_lh2)
fprintf('\nHydrazine & LOx Propellant Mass Savings: %.1f Mg', m_p_sav_hyd)
fprintf('\nHydrazine & LOx Number of Trips for Mass Benefit: %i', num_taxi_hyd)
fprintf('\n')
