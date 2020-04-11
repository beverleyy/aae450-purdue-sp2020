% massdriver_kinematics
% Author: Arch Pleumpanya
% Description: This script analyzes kinematics of the mass driver launch
% using kinematics equations. A plot of launch acceleration (in g's) and launch
% duration at varying track lengths is output. Required driving force is
% also calculated.
clear
clc
close all
set(0,'defaultlinelinewidth',1.5);
set(0,'defaultaxesfontsize',12);
set(0,'defaulttextinterpreter','latex');
% 
%% Kinematic equations on mass driver
g = 9.80665; % Earth's gravitational acceleration [m/s2]
V_esc_mars = 5000; % Mars' escape velocity [m/s]
V_esc_moon = 2500; % Moon's escape velocity [m/s]
x_track_moon = linspace(100000,200000); % possible range of driver length on the Moon [m]
acc_moon = V_esc_moon^2/2./x_track_moon; % vehicle acceleration on the Moon [m/s2]
delta_t_moon = V_esc_moon./acc_moon; % launch duration on the Moon [s]
x_track_mars = linspace(300000,700000); % possible range of driver length on Mars [m]
acc_mars = V_esc_mars^2/2./x_track_mars; % vehicle acceleration on Mars [m/s2]
delta_t_mars = V_esc_mars./acc_mars; % launch duration on Mars [s]
% 
%% Calculate force required at chose acceleration
m_taxi = 300e3; % estimated vehicle mass [kg]
acc_g_moon = 2; % chosen acceleration limit on the Moon [g]
F_req_moon = m_taxi*acc_g_moon*g; % force required on the Moon [N]
acc_g_mars = 2; % chosen acceleration limit on Mars [g]
F_req_mars = m_taxi*acc_g_mars*g; % force required on Mars [N]
% 
%% Plots
figure(1)
subplot(211)
yyaxis left
plot(x_track_mars/1000,acc_mars/g)
ylabel('acceleration [g]','fontsize',12)
yyaxis right
plot(x_track_mars/1000,delta_t_mars/60,'--')
ylabel('duration [min]','fontsize',12)
title('Launch Acceleration And Duration on Mars','fontsize',16)
xlabel('track distance [km]','fontsize',12)
legend('acceleration','duration','Location','best')
grid on
subplot(212)
yyaxis left
plot(x_track_moon/1000,acc_moon/9.81)
ylabel('acceleration [g]','fontsize',12)
yyaxis right
plot(x_track_moon/1000,delta_t_moon/60,'--')
ylabel('duration [min]','fontsize',12)
title('Launch Acceleration And Duration on Luna','fontsize',16)
xlabel('track distance [km]','fontsize',12)
legend('acceleration','duration','Location','best')
grid on
% end
