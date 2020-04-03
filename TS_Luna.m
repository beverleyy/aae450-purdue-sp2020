clear;clc;
%% Tether Sling on Luna - Propellant Analysis
% Author: Shuting Yang
% Date: Feb 15, 2020
% Description: The code is used to perform propellant analysis for 
%              tether sling system on Luna. The code also tests what variables 
%              need to be changed to decrease the mass ratio of tether to 
%              propellant with a required safety factor of 10 for the 
%              tether sling on Luna.

%% Assumptions
% 1. The safety factor of the tether is 10.
% 2. Maximum acceleration is 2g.
% 3. Payload mass/a taxi mass is 186.777Mg provided by the taxi team.
% 4. The material of the tether is Zylon as suggested by the 
%    structures team. 
%
%% Initializations

% Constants & Self-defined Parameters
g = 9.80665; %Standard gravitational acceleration on the Earth's Surface (m/s^2)
a_max = 2*g; %Maximum acceleration people can withstand.
m_p = 189.713e3; %Payload/A taxi mass (kg)

% Properties of the Tether Material
sf = 10; %Safety factor of the tether

rou = 1550; %Density of Zylon (kg/m^3)
%rou = 1340; %Density of Carbon Nanotube(kg/m^3)
%rou = 1500; %Density of Carbides(kg/m^3)
%rou = 2330; %Density of Monocrystalline Silicon(m-Si)(kg/m^3)

sigma = 5.8e9; %Effective Ultimate Tensile Strength (UTS) of Zylon (Pa)
%sigma = 62e9; %UTS of Carbon Nanotube (Pa)
%sigma = 5.93e9 %UTS of Carbides (Pa)
%sigma = 7e9; %UTS of Monocrystalline Silicon(m-Si)(Pa)


% Isp of A Chemical Propellant
Isp_1 = 424; %Vacuum Specific Impulse of LOX/LH2 used in Saturn V (s)
Isp_2 = 313; %Vacuum Specific Impulse of NTO/MMH used in Space Shuttle (s)
Isp_3 = 304; %Vacuum Specific Impulse of LOX/RP-1 used in Saturn V(s)
Isp_4 = 285; %Vacuum Specific Impulse of NTO/Aerozine 50 used in Titan2 (s)
Isp_5 = 266; %Vacuum Specific Impulse of HTPB Solid used in Delta2 (s)

%% Calculations
%Nondimensional Velocity
v_c = sqrt(2*sigma/rou); %Characteristic velocity of the tether (m/s)
v = 5.1515e3; %Delta V from Luna to Cycler(m/s)

%New delta V tested for improvement (m/s)
%v = 5e3;
%v = 4.5e3;
%v = 4e3; 

v_star = v/v_c; %Nondimensional velocity (m/s)

% Isp Matrix
Isp = [Isp_1 Isp_2 Isp_3 Isp_4 Isp_5]; %Combine the Isp of various chemical propellants

% Mass Ratio of Tether to Propellant
n = v_c./(Isp.*g); 
MR_prop = exp(n.*v_star)-1; %The mass ratio of propellant to the payload corresponding to different propellants.
MR_t = sqrt(pi)*v_star*exp(v_star^2)*erf(v_star); %The mass ratio of tether to payload 
MR_tp = 10*MR_t./MR_prop; %The mass ratio of the tether to chemical propellants. 

% Tether Parameters
m_t = MR_t * m_p/(10^3)*sf; %The tether mass (Mg)
l = v^2/a_max; %The tether length (m)
At = (m_p * v^2/(sigma*l))*10^4*sf; %cross section area at the end of the tether (cm^2)
A0 = At*exp(v^2*rou/(2*sigma)); %cross section area at the start of the tether (cm^2)

%% Outputs
disp('--------------------------Tether Sling on Luna---------------------')
fprintf(' A tether length is %.2f km.', l/1000)
fprintf('\n The total tether mass is %.0f Mg.', m_t)
fprintf('\n The tether mass required for each kg of payload that is propelled in order are: \n %.4f kg, %.0f kg, %.0f kg, %.0f kg, %.0f kg.\n', MR_tp(1),MR_tp(2),MR_tp(3),MR_tp(4),MR_tp(5))
fprintf(' The cross section area at the end of the tether is %.2f cm^2. \n', At)
fprintf(' The cross section area at the start of the tether is %.2f cm^2. \n', A0)
disp( ' ' )
