%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valentin RICHARD (Mission Design)
%
% This script was created to study the feasability of using a tether sling
% on Mars.
%
% The first part is used to esimate the Tether dimensions, the second part
% will be used to study its Dynamics on Mars.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format compact
clc, clear all, close all


%% Entry variables and constants

%   Constants
g_earth = 9.80665;              % (m/s^2) : Earth's gravitationnal accel.
G = 6.67430*10^(-11);           % (m^3/kg/s^2) : Gravitational const.

% DeltaVs (as they are used for the tether design, we need to use the most
%  binding ones, i.e. the highest)
%
%   Mars Tether Sling needed DeltaVs (Estimates, will be updated asap)
dv3 = 1911;                     % (m/s) : Mars to Phobos
dv4 = 4022;   %(WARNING!)       % (m/s) : Phobos To Mars
v = dv4                         % (m/s) : Speed used for calculations

%   Payload Mass
mp = 90.3 * 10^3;               % (Kg) : Taxi mass

%   Maximum radial acceleration 
gamma_max = 2*g_earth           % (m/s^2) : Theoretical max accel.

%   Tengential acceleration
%gamma_t   = to be defined;     % (m/s^2)


%% Tether specifications

% Tether material : Dyneema (Based on Structures Team Researchs)
th_sigma = 3.325*10^9;          % (Pa) : Tether material Ultimate strength
s = 10;                         % (adim.) : Factor of safety
sigma = th_sigma/s;             % (Pa) : Effective Ultimate strength 
rho = 970;                      % (kg/m^3) : Tether material density    

%Tether dimensions
lt = (v^2)/gamma_max            % (m) : Tether's arm length
al = mp*(v^2)/sigma/lt;         % (m^2) : Tether area at the end
a0 = al*exp((v^2)*rho/2/sigma); % (m^2) : Tether area at the hub



%% Variables to compute (Tether)
%   Formulas used are based on "A Tether Sling for Lunar and Interplanetary
%   Exploration" from J. PUIG-SUARI, J. M. LONGUSKI and S. G. TRAGESSER

omega_tether = v/lt;            % (rad/s) : angular velocity
fc = mp*(v^2)/lt;               % (Newtons) : Maximum centripetal Force  
                                % exerced by the payload on the tether's arm 
%t_spinup = v/gamma_t;          % (s) : Spin-up time (not considered
                                %                     anymore)
vc = sqrt(2*sigma/rho);         % (m/s) : Caracteristic velocity 
                                %(maximum payload speed for a UNIFORM tether) 
v_star = v/vc;                  % (adim.) : Non-dimensional velocity. Used
                                %           for tether mass calculations
                                
mt = mp*sqrt(pi)*v_star*exp(v_star^2)*erf(v_star);  % (kg) : Tether mass


%% Tether Dynamics on Mars 
%   Formulas used are based on "Dynamics and Control of a Tether Sling
%   Stationed on a Rotating Body" from S. G. TRAGESSER and L. G. BAARS
% 
%   Assumptions: - Tether Arm mass is neglected (only mass in cosideration
%   is the payload)
%                - No tangential accel (Only accel is radial) ==> Tether
%                has a constant spin
%                - Tether Length is constant

% Entry variables
m = mp;                         % (kg) : Payload Mass 

% Hub Position
phi= 18.65 *pi/180              % (rad) : Latitude of the Hub
%lambda = ???                   % (rad) : Longitude of the Hub


% Mars Caracteristics
r_mars = 3396 *10^3;            % (m) : Mars Radius (Equator)
m_mars = 0.64171 * 10^24;       % (kg) : Mars Mass
g_mars = 3.71                   % (m/s^2) : Mars Surface gravity
T_mars = 24.6597 * 60*60;       % (s) : Length of a Martian Day
omega = 2*pi/T_mars;            % (rad/s) : Mars Rotation rate
r_hub = 50                      % (m) : Hub Length (ARBITRARY)
Dtheta = v/ (lt+r_hub);         % (rad/s) : Rotation rate of the Hub
h_olympus = 26000;              % (m) : Olympus Mons height

% Simulink variable definition and initial conditions
t_sim = T_mars;                 % (s) : Simulation time (1/4 Mars Orbit)
alphaCond = 0;
dAlphaCond = 0;
betaCond = 0;
dBetaCond = 0;



% Simulation
SimOut = sim('Alpha_Beta_sim')
figure
hold on
plot(SimOut.t/60,SimOut.beta*180/pi)
plot(SimOut.t/60,SimOut.alpha*180/pi)
title("In and out of plane angles over time")
legend("beta","alpha")
xlabel("Time (min)")
ylabel("Out of plane angles (°)")
annotation('textbox',[0.125 0 0 0.065],'String',"Plot made by Valentin RICHARD",'FitBoxToText','on');
hold off

%% Plot payload position in Tether centered rotating frame
x_pos = lt*cos(SimOut.alpha).*cos(SimOut.beta);
y_pos = lt*sin(SimOut.alpha).*cos(SimOut.beta);
z_pos = lt*sin(SimOut.beta);
pos_tether = [x_pos, y_pos, z_pos];
figure
plot3(x_pos,y_pos,z_pos)
title("Payload position in the Tether centered rotating frame")
xlabel("x axis")
ylabel("y axis")
zlabel("z axis")
annotation('textbox',[0.125 0 0 0.065],'String',"Plot made by Valentin RICHARD",'FitBoxToText','on');


% Converting to inertial frame         
for i=1:1:length(SimOut.t)
    % Direction cosine matrix from Martian frame to intermediate frame
    C_SEZ_ijk(:,:,:,i) = [sin(phi)*cos(omega*SimOut.t(i)), -sin(omega*SimOut.t(i)), cos(phi)*cos(omega*SimOut.t(i));
                          sin(phi)*sin(omega*SimOut.t(i)),  cos(omega*SimOut.t(i)), cos(phi)*sin(omega*SimOut.t(i));
                         -cos(phi),                         0,                      sin(phi)]' ;
                     
    % Direction cosine matrix from Tether rotating frame to an intermediate frame                       
    C_xyz_SEZ(:,:,:,i) = [ cos(Dtheta*SimOut.t(i)), sin(Dtheta*SimOut.t(i)), 0;
                          -sin(Dtheta*SimOut.t(i)), cos(Dtheta*SimOut.t(i)), 0;
                           0,                       0,                       1];
    
    % Position of the Tether tip in the Inertial Martian frame
    pos_inertial(i,:) = pos_tether(i,:) * C_xyz_SEZ(:,:,:,i) * C_SEZ_ijk(:,:,:,i) ...
        + (r_mars+h_olympus)*[cos(phi)*cos(omega*SimOut.t(i)) cos(phi)*sin(omega*SimOut.t(i)) sin(phi)];
    
    % Position of the axis of the Tether in the Inertial Martian frame
    pos_tetherAxis(i,:) = [ 0 0 1]* C_xyz_SEZ(:,:,:,i) * C_SEZ_ijk(:,:,:,i);
end

figure
% (i,j,k): Inertial Martian frame
xlabel("i")
ylabel("j")
zlabel("k")
title("Tether trajectory in the inertially fixed frame")


%% Adding the position of the Tether tip to the plot
for i=1:1:length(SimOut.t)
    %pause(0.0025)
    %plot3(pos_inertial(i,1),pos_inertial(i,2),pos_inertial(i,3),'x') 
    plot3(pos_inertial(1:i,1),pos_inertial(1:i,2),pos_inertial(1:i,3)) 
end
%plot3(pos_inertial(:,1),pos_inertial(:,2),pos_inertial(:,3)) 
annotation('textbox',[0.125 0 0 0.065],'String',"Plot made by Valentin RICHARD",'FitBoxToText','on');

hold on
%   Add planet to plot
ne=1000; %500                                    % Number of points
nt = 25; %25                                     % Number of turns (spiral)
%theta_earth=linspace(0, 0, ne);
theta_earth=linspace(-pi/2, pi/2, ne);           % Latitude range
phi_earth = linspace(0,nt*2*pi, ne);             % Longitude range

% Plot Mars 3D (simpified)
plot3(r_mars.*cos(theta_earth).*cos(phi_earth), r_mars*cos(theta_earth).*sin(phi_earth), r_mars*sin(theta_earth), '-r','LineWidth', 0.05)
hold off

% 2D Graph showing when the tether is hitting mars surface
%   Represents the distance between the tether tip and the Martian surface
figure
inertial_norm = (pos_inertial(:,1).^2+pos_inertial(:,2).^2+pos_inertial(:,3).^2).^0.5;
plot(SimOut.t./60, inertial_norm -r_mars)
refline(0,0)
xlabel("Time (min)")
ylabel("Distance from surface (m)")
title("Tether Tip distance to Mars surface over time")
annotation('textbox',[0.125 0 0 0.065],'String',"Plot made by Valentin RICHARD",'FitBoxToText','on');



