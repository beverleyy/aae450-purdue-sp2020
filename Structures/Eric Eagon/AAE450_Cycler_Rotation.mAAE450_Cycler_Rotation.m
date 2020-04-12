%% AAE 450: Project Escallator
% Author: Eric Eagon
% Structures Team
clear,clc,close all

%% Cycler Rotation
% CONSTANTS
g = 9.81;  %[m/s^2]
a1 = g;   %Earth's acceleration
a2 = 0.376*g;   %Mars acceleration
%limits
RPM_MAX = 3;   %[rpm]
RADIUS_MIN = 40;  %[m]
% CALCULATIONS
R = linspace(10,500,2^10);   %Radius of the vehicle [m]
T1 = 2*pi.*sqrt(R./a1);    %Spacecraft period for Earth [seconds]
T2 = 2*pi.*sqrt(R./a2);    %Spacecraft period for Mars [seconds]
RPM1 = 1./T1*60;   %[rpm]
RPM2 = 1./T2*60;   %[rpm]
%Tether Mass and Volume Calculations
MASS = 5.1e6;   %[kg]
omega = RPM1*2*pi/60;   %[rad/sec] rotation required to create 1g
lin_v = R.*omega;  %[m/s]
n = 2;   %number of vehicle "hubs" (multiples of 2 since we need one on each end)
eta = 10;   %safety factor
[yield, density] = cyclerMat(3);
tensile_yield = yield;   %[Pa]
sigma = tensile_yield/eta;   %[Pa] effective yield strength
At = (MASS/n).*lin_v.^2./(sigma.*R);  %Area of tether at the end
Ac = At.*exp(density*lin_v.^2./(2*sigma));  %Area of tether at center
Tether_Area = (Ac+At)./2;  %[m^2] average cross-sectional area of tether
Tether_Vol = Tether_Area.*2.*R;    %[m^3]
Tether_Mass = Tether_Vol*density;    %[kg]
% FIGURES
figure(1)
plot(R,RPM1,'b')
hold on
plot(R,RPM2,'r')
rad_min = line([RADIUS_MIN RADIUS_MIN],[0,10],'Color',[1 0 0]);
rpm_max = line([0 500],[RPM_MAX RPM_MAX],'Color',[1 0 0]);
    grid on
    grid minor
    title('Cycler Vehicle Radius vs Rotational Speed')
    xlim([0,500])
    xlabel('Radius of Vehicle [m]')
    ylabel('Rotations per Minute [rpm]')
    legend('g = 1.0','g = 0.376')  
figure(2)
plot(R, Tether_Area)
    grid on
    title('Cycler Vehicle Radius vs Tether Cross-Sectional Area')
    xlabel('Radius of Cycler Vehicle [m]')
    ylabel('Area of Connecting Tether [m^2]')
figure(3)
plot(R, Tether_Vol)
    grid on
    title('Cycler Vehicle Radius vs Tether Volume')
    xlabel('Radius of Cycler Vehicle [m]')
    ylabel('Volume of Connecting Tether [m^3]')
figure(4)
plot(R, Tether_Mass)
    grid on
    title('Cycler Vehicle Radius vs Tether Mass')
    xlabel('Radius of Cycler Vehicle [m]')
    ylabel('Mass of Connecting Tether [kg]')
% FINAL VALUES
%Tether Material is Zylon
indx = find(abs(R-400) < 0.2);  %index closest to R = 400 m
R = 400;  %[m]
Period = T1(indx);  %[sec]
omega = 2*pi/T1(indx)  %[rad/sec]
Mass_tether = Tether_Mass(indx);   %[kg]
Vol_tether = Tether_Vol(indx);   %[kg]




