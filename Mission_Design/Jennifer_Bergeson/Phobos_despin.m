clearvars
clc
format long

G = 6.67*10^(-11);  %universal gravitational constant in m^3/(kg*s^2)

%% Data of Phobos
rho_phobos = 2*100^3 / 1000;    %density of Phobos in kg/m^3
axis1_phobos = 13500;   %m
axis2_phobos = 10800;   %m
axis3_phobos = 9400;     %m
avg_short_axis = 10000; %m
P_phobos = 9.5738*3600; %period of Phobos rotation about axis in seconds
omega_phobos = 2*pi/P_phobos;   %rotation rate of Phobos about axis in rad/s

v_phobos = 4*pi*axis1_phobos*axis2_phobos*axis3_phobos/3;   %volume of phobos in m^3
m_phobos = rho_phobos*v_phobos;  %kg
omega_escape = (2*G*m_phobos)^.5/(axis1_phobos/2)^1.5  %rotation rate for escape velocity on Phobos

%% Data of Tether
m_taxi = 182*10^6;  %mass of taxi in kg
m_taxi_range = [130:230]*10^6;
r_tether = 700*10^3;    %length of tether in m
tip_speed = 3.7051*1000;    %m/s
tip_speed_range = [3.5:.001:5]*1000; %m/s
m_tether = 21126;   %kg
spin_up_time = 6.3*60;   %spin up time in s

%% Momenta Calculations
I_phobos = m_phobos*(1/5)*(axis1_phobos^2 + avg_short_axis^2);  %moment of inertia of Phobos in kg*m^2
H_phobos = I_phobos*omega_phobos;   %angular momentum of phobos in kg*m^2/s

omega_tether_omega = tip_speed/r_tether;  %rotation rate of tether in rad/s
omega_tether_mass = tip_speed_range/r_tether;
H_taxi_point_omega = m_taxi_range*r_tether^2 * omega_tether_omega;  %angular momentum of taxi assuming that one taxi modeled as a point mass rotates on a massless tether
H_taxi_point_mass = m_taxi*r_tether^2 * omega_tether_mass;
H_tether_omega = m_tether*(r_tether/3)^2 * omega_tether_omega;  %angular momentum of tether itself assuming that the mass is centered at R/3
H_tether_mass = m_tether*(r_tether/3)^2 * omega_tether_mass;
%% Maximum Torque on Tether and Taxi
d_omega_dt_max_tether_omega = 10*omega_tether_omega/spin_up_time;  %maximum rate of change of angular velocity in rad/s^2
d_omega_dt_max_tether_mass = 10*omega_tether_mass/spin_up_time;
T_max_spin_omega = (m_taxi_range*r_tether^2 + m_tether*(r_tether/3)^2)*d_omega_dt_max_tether_omega;   %maximum torque on tether and taxi in N*m
T_max_spin_mass = (m_taxi*r_tether^2 + m_tether*(r_tether/3)^2)*d_omega_dt_max_tether_mass;

%% Maximum Rate of Change of Phobos Rotation Rate from Spin up or Down
d_omega_dt_max_Phobos_spin_omega = T_max_spin_omega/I_phobos; %maximum rate of change of angular velocity of Phobos as a result of tether spin in rad/s^2
d_omega_dt_max_Phobos_spin_mass = T_max_spin_mass/I_phobos;
d_omega_spin_omega = d_omega_dt_max_Phobos_spin_omega*spin_up_time; %maximum change in angular velocity of Phobos in rad/s
d_omega_spin_mass = d_omega_dt_max_Phobos_spin_mass*spin_up_time;

%% Maximum Rate of Change of Phobos Rotation Rate from Taxi Attachment or Detachment
T_max_attach_omega = H_taxi_point_omega;   %maximum torque from taxi leaving or joining tether assuming 1 second encounter time
T_max_attach_mass = H_taxi_point_mass;
d_omega_dt_phobos_taxi_omega = T_max_attach_omega/I_phobos;    %rate of change of angular velocity of Phobos as a result of taxi encounter in rad/s^2
d_omega_dt_phobos_taxi_mass = T_max_attach_mass/I_phobos;
d_omega_taxi_omega = d_omega_dt_phobos_taxi_omega;  %change in angular velocity of Phobos due to taxi encounter assuming the encounter takes 1 s
d_omega_taxi_mass = d_omega_dt_phobos_taxi_mass;

%% Print Current Design
omega_phobos
d_omega_taxi_omega(51)
d_omega_spin_omega(51)

percent_change_taxi = d_omega_taxi_omega(51)*100/omega_phobos
percent_change_spin = d_omega_spin_omega(51)*100/omega_phobos 
%% Generate Plots

figure(1) % Change due to spin up and down
plot(m_taxi_range/10^6, d_omega_spin_omega)
hold on
plot(m_taxi_range(51)/10^6, d_omega_spin_omega(51), 'r*')
xlabel('Taxi Mass (tons)')
ylabel('Change in Angular Velocity (rad/s)')
title('Delta Angular Velocity Based on Taxi Mass')
legend('Full Range', 'Current Design', 'location', 'best')

figure(2) % Change due to spin up and down
plot(m_taxi_range/10^6, d_omega_taxi_omega)
hold on
plot(m_taxi_range(51)/10^6, d_omega_taxi_omega(51), 'r*')
xlabel('Taxi Mass (tons)')
ylabel('Change in Angular Velocity (rad/s)')
title('Delta Angular Velocity Based on Taxi Mass')
legend('Full Range', 'Current Design', 'location', 'best')

figure(3) % Change due to spin up and down
plot(tip_speed_range/1000, d_omega_spin_mass)
hold on
plot(tip_speed_range(206)/10^3, d_omega_spin_mass(206), 'r*')
xlabel('Tip Speed (km/s)')
ylabel('Change in Angular Velocity (rad/s)')
title('Delta Angular Velocity Based on Tip Speed')
legend('Full Range', 'Current Design', 'location', 'best')

figure(4) % Change due to spin up and down
plot(tip_speed_range/10^3, d_omega_taxi_mass)
hold on
plot(tip_speed_range(206)/10^3, d_omega_taxi_mass(206), 'r*')
xlabel('Tip Speed (km/s)')
ylabel('Change in Angular Velocity (rad/s)')
title('Delta Angular Velocity Based on Tip Speed')
legend('Full Range', 'Current Design', 'location', 'best')