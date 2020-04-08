%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Chuhao Deng
%
% Code for propulsion system design for Communication Satellites
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Mass Ratio vs. Specific Impulse

% Define delta-v
dv_1 = 2000; %m/s
dv_2 = 1000; %m/s

% Define assumed values
T = 0.01; %N
a = 10e-3; %kg/W
n = 0.5; %efficiency
g = 9.8; %m/s^2

% 1 year operating time
dt = 1*365*24*60*60; %s

% Define a range of specific impulse
I = 1:20000; %s

% Calculating mass ratio
ratio_1 = exp(-dv_1./(g.*I)) + (a*g^2.*I.^2.*exp(-dv_1./(I.*g)))./(2*n*dt) - a.*I.^2*g^2./(2*n*dt);
ratio_2 = exp(-dv_2./(g.*I)) + (a*g^2.*I.^2.*exp(-dv_2./(I.*g)))./(2*n*dt) - a.*I.^2*g^2./(2*n*dt);

% Calculating power needed
P = T*g*I/(2*n);

% Obtaining max mass ratio
maximum_1 = max(ratio_1);
maximum_2 = max(ratio_2);

% Obtaining optimal specific impulse
position_1 = find(ratio_1 == maximum_1);
BestIsp_1 = I(position_1);
position_2 = find(ratio_2 == maximum_2);
BestIsp_2 = I(position_2);
best_p_1 = P(find(I == BestIsp_1));
best_p_2 = P(find(I == BestIsp_2));

% Making dash lines in plots
vertical_line_y_1 = linspace(0,maximum_1,1000);
vertical_line_x_1 = BestIsp_1 * ones(1,length(vertical_line_y_1));
horizontal_line_x_1 = linspace(0,BestIsp_1,1000);
horizontal_line_y_1 = maximum_1 * ones(1,length(horizontal_line_x_1));

vertical_line_y_2 = linspace(0,maximum_2,1000);
vertical_line_x_2 = BestIsp_2 * ones(1,length(vertical_line_y_2));
horizontal_line_x_2 = linspace(0,BestIsp_1,1000);
horizontal_line_y_2 = maximum_2 * ones(1,length(horizontal_line_x_2));

p_vertical_line_y_1 = linspace(0,best_p_1,1000);
p_vertical_line_x_1 = BestIsp_1 * ones(1,length(vertical_line_y_1));
p_horizontal_line_x_1 = linspace(0,BestIsp_1,1000);
p_horizontal_line_y_1 = best_p_1 * ones(1,length(horizontal_line_x_1));

p_vertical_line_y_2 = linspace(0,best_p_2,1000);
p_vertical_line_x_2 = BestIsp_2 * ones(1,length(vertical_line_y_2));
p_horizontal_line_x_2 = linspace(0,BestIsp_1,1000);
p_horizontal_line_y_2 = best_p_2 * ones(1,length(horizontal_line_x_2));


% Plots
figure(1)
plot(I,ratio_1,'r')
hold on
plot(I,ratio_2,'b')
plot(vertical_line_x_1,vertical_line_y_1,'--')
plot(horizontal_line_x_1,horizontal_line_y_1,'--')
plot(vertical_line_x_2,vertical_line_y_2,'--')
plot(horizontal_line_x_2,horizontal_line_y_2,'--')
plot(BestIsp_1,ratio_1(position_1),'r*')
plot(BestIsp_2,ratio_2(position_2),'b*')
xlabel('Isp (s)')
ylabel('mu/m0')
title('mu/m0 vs. Isp')
legend('{\Delta}V = 2000 m/s','{\Delta}V = 1000 m/s','Location','southeast')
ylim([0 1])
set(gca,'FontSize',15);

figure(2)
plot(I,P)
hold on
plot(p_vertical_line_x_1,p_vertical_line_y_1,'--')
plot(p_horizontal_line_x_1,p_horizontal_line_y_1,'--')
plot(p_vertical_line_x_2,p_vertical_line_y_2,'--')
plot(p_horizontal_line_x_2,p_horizontal_line_y_2,'--')
plot(BestIsp_1,best_p_1,'r*')
plot(BestIsp_2,best_p_2,'b*')
legend('Power','Power for {\Delta}V = 2000 m/s', 'Power for {\Delta}V = 1000 m/s','Location','southeast')
xlabel('Isp (s)','Fontsize',24)
ylabel('Power (Watts)','Fontsize',24)
title('Power vs. Isp','Fontsize',24)
set(gca,'FontSize',15);

% Calculate Mass Numbers
mass_ppu_1 = a*P(BestIsp_1); %kg
mass_ppu_2 = a*P(BestIsp_2); %kg
mass_u_1 = 1582.5; %kg
mass_u_2 = 1521; %kg
mass_u_3 = 1908; %kg
mass_u_4 = 1873; %kg
mass_pr_1 = mass_u_1/maximum_1 - (mass_ppu_1 + mass_u_1); %kg
mass_pr_2 = mass_u_2/maximum_2 - (mass_ppu_2 + mass_u_2); %kg
mass_pr_3 = mass_u_3/maximum_2 - (mass_ppu_2 + mass_u_2); %kg
mass_pr_4 = mass_u_4/maximum_2 - (mass_ppu_2 + mass_u_2); %kg
total_mass_1 = mass_pr_1 + mass_ppu_1 + mass_u_1;
total_mass_2 = mass_pr_2 + mass_ppu_2 + mass_u_2;
total_mass_3 = mass_pr_2 + mass_ppu_2 + mass_u_3;
total_mass_4 = mass_pr_2 + mass_ppu_2 + mass_u_4;

%% Propellant Saving

%Constants & Self-defined Parameters
g = 9.80665; %Standard gravitational acceleration on the Earth's Surface (m/s^2)
m_p_geo = 1583; %Payload mass (kg)
m_p_areo = 1521; %kg

%Isp of Chemical Propellants
Isp_1 = 424; %Vacuum Specific Impulse of LOX/LH2 used in Saturn V (s)
Isp_2 = 313; %Vacuum Specific Impulse of NTO/MMH used in Space Shuttle (s)
Isp_3 = 304; %Vacuum Specific Impulse of LOX/RP-1 used in Saturn V(s)
Isp_4 = 285; %Vacuum Specific Impulse of NTO/Aerozine 50 used in Titan2 (s)
Isp_5 = 266; %Vacuum Specific Impulse of HTPB Solid used in Delta2 (s)

%Isp Matrix
Isp = [Isp_1 Isp_2 Isp_3 Isp_4 Isp_5]; %Combine the Isp of various chemical propellants
m_prop_geo = (exp(dv_2./(g*Isp))-1)*m_p_geo;
m_prop_areo = (exp(dv_1./(g*Isp))-1)*m_p_areo;


%% Further Analysis

% Initializations
A = (0.3/2)^2*pi; %m^2
q = 1.602e-19; %C
x_a = 0.5;
e_0 = 8.8541878128e-12; %F/m
T = 0.01; %N
sf = 5; %Safety Factor

% Atomic Mass
M_helium = 6.6464764e-27; %kg
M_neon = 3.3509177e-26; %kg
M_argon = 6.6335209e-26; %kg
M_krypton = 1.3914984e-25; %kg
M_xenon = 2.18e-25; %kg
M = linspace(M_helium,M_xenon*10,10000);
M_gas = [M_helium M_neon M_argon M_krypton M_xenon];
xa = linspace(0,0.1,1000);

% Calculations
V0 = (9*x_a.^2/(4*e_0)*best_p_1/A*sqrt(M/(2*q))).^(2/5);
V0_xenon = (9*x_a.^2/(4*e_0)*best_p_1/A*sqrt(M_xenon/(2*q)))^(2/5);
V0_gas = (9*x_a.^2/(4*e_0)*best_p_1/A*sqrt(M_gas/(2*q))).^(2/5);
va = sqrt(2*q*V0./M);
va_xenon = sqrt(2*q*V0_xenon/M_xenon)/sf;
va_gas = sqrt(2*q*V0_gas./M_gas)/sf;
va = va/sf;

% Making dash lines
vertical_line_y = linspace(0,va_xenon,1000);
vertical_line_x = M_xenon * ones(1,length(vertical_line_y_1));
horizontal_line_x = linspace(0,M_xenon,1000);
horizontal_line_y = va_xenon * ones(1,length(horizontal_line_x_1));

% Plot
figure(3)
plot(M,va)
hold on
plot(vertical_line_x,vertical_line_y,'--')
plot(horizontal_line_x,horizontal_line_y,'--')
plot(M_xenon,va_xenon,'r*')
title('Atomic Mass vs. Exhaust Velocity')
xlabel('Atomic Mass (kg)')
ylabel('Exhaust Velocity (m/s)')



