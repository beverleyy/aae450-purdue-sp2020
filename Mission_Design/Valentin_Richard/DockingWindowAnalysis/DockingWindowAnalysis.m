%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valentin RICHARD (Mission Design)
%
% This script was created to study the Docking Window on the Tethers on
% Phobos, Mars and Luna. 
%
% The length of the telescopic arm of the Tether/Taxi
% connector will be discussed as the output parameter  for this study.
% The input being the docking time.
%
% We want to maximize the docking time and minimizing the Telescopic
% arm length.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format compact
clc, clear all, close all

%% Entry variables and constants
%   The maximum DeltaV values for each Tether will be used. 
%   Using the most binding values will give us the MINIMUM docking time.
       
% Mars Tether Sling
maxVelocityMars = 4.0218;            % (km/s) : Maximum DeltaV
ArmLengthMars = 825;                 % (km) : Length of the Tether arm
omegaMars = maxVelocityMars / ArmLengthMars;
                                     % (rad/s) : Tether angular vel.


% Phobos Tether Sling
maxVelocityPhobos = 3.6508;          % (km/s) : Maximum DeltaV
ArmLengthPhobos = 680;               % (km) : Length of the Tether arm
omegaPhobos = maxVelocityPhobos / ArmLengthPhobos;
                                     % (rad/s) : Tether angular vel.

                                     
% Luna Tether Sling
maxVelocityLuna = 5.1515;            % (km/s) : Maximum DeltaV
ArmLengthLuna = 1353;                % (km) : Length of the Tether arm
omegaLuna = maxVelocityLuna / ArmLengthLuna;
                                     % (rad/s) : Tether angular vel.
                                 
%% Inputs
dockingTime = linspace(0,2,1000);    % (s) : Docking window

%% Outputs

% The docking angle, is the angle swept by the Tether 
%  during which docking can be made (please refer to my Presentation 3 for
%  illustrative figures and further explanations)
dockingAngleMars   = omegaMars * dockingTime;   % (rad) : Docking Angles
dockingAnglePhobos = omegaPhobos * dockingTime; %            "
dockingAngleLuna   = omegaLuna * dockingTime;   %            "

% Length of the Telescopic Arm of the Tether/Taxi connector
%  In meters (Hence the 10^3 factor)
telescArmMars = ArmLengthMars * 10^3 * (1./cos(dockingAngleMars) - 1);
telescArmPhobos = ArmLengthPhobos * 10^3 * (1./cos(dockingAnglePhobos) - 1);
telescArmLuna = ArmLengthLuna * 10^3 * (1./cos(dockingAngleLuna) - 1);


%% Plots and Analysis

% Plot of the differents telescopic arms vs docking time
figure
hold on
plot(dockingTime,telescArmMars,'lineWidth',2)       % Mars Plot
plot(dockingTime,telescArmPhobos,'lineWidth',2)     % Phobos Plot
plot(dockingTime,telescArmLuna,'lineWidth',2)       % Luna Plot
hlimit = refline(0,22); % Length restriction set by the structures team
hlimit.Color = 'green';
hlimit.LineStyle = '-';
hlimit.LineWidth = 2;
hold off
xlabel("Available Docking Window (s)")
ylabel("Telescopic Arm Length (m)")
title("Length of the Telescopic Arms = f(Docking Window)")
legend("Mars", "Phobos", "Luna", "Max Arm Length")
annotation('textbox',[0.125 0 0 0.065],'String',"Plot made by Valentin RICHARD",'FitBoxToText','on');
