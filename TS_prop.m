clear;clc;
%% Tether Sling - Chemical Propellant Savings
% Author: Shuting Yang
% Date: March 1, 2020
% Description: The code is used to calculate the mass of chemical
%              propellant if we use LOX/LH2 and NTO/MMH during the flight.
%

%% Initialization
m_p = 189.713e3; %Payload/A taxi mass (kg)
MR1 = [92 134 117 468]; %Order: C to M, M to P, P to C, L to C
MR2 = [57 80 72 264]; %Order: C to M, M to P, P to C, L to C

%% Calculation
m_prop1 = m_p .* MR1/1000; %Propellant mass of LOX/LH2 (Mg)
m_prop2 = m_p .* MR2/1000; %Propellant mass of NTO/MMH (Mg)

%% Result
disp('--------------------------Chemical Propellant Savings---------------------')
fprintf('\n The saved propellant mass of LOX/LH2 for each flight phase in order are: \n %.0f Mg, %.0f Mg, %.0f Mg, %.0f Mg.\n', m_prop1(1),m_prop1(2),m_prop1(3),m_prop1(4))
fprintf('\n The saved propellant mass of NTO/MMH for each flight phase in order are: \n %.0f Mg, %.0f Mg, %.0f Mg, %.0f Mg.\n', m_prop2(1),m_prop2(2),m_prop2(3),m_prop2(4))

