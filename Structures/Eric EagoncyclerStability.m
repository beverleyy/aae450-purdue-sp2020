%% AAE 450 Cycler Stability
% Author: Eric Eagon

clear all
close all

%% Cycler Stability
clear;
% PDR Values
Ixx = 4.643e10;  %kg-m^2
Iyy = 5.082e12;  %kg-m^2
Izz = 5.06e12;  %kg-m^2
I_pdr = diag([Ixx Iyy Izz]);
% CDR Values
Ixx = 4.526e10;  %kg-m^2
Iyy = 7.048e12;  %kg-m^2
Izz = 7.047e12;  %kg-m^2
I_cdr = diag([Ixx Iyy Izz]);
% FINAL VALUES
Ixx = 7.635e9;  %kg-m^2
Iyy = 1.319e12;  %kg-m^2
Izz = 1.322e12;  %kg-m^2
I = diag([Ixx Iyy Izz]);
%Applied Moments
Mx = 0;  %N-m
My = 0;  %N-m
Mz = 0;  %N-m
M = [Mx My Mz];
%Angular Velocity
omega = 0.1566047;  %rad/sec
x0 = [0.01, 0.01, omega]; %initial rotational velocity
tspan = [0, 400];
options = odeset('RelTol',1E-6,'AbsTol',1E-6);
% INTEGRATION
%PDR
[tA,xA] = ode45(@cyclerPaxis,tspan,x0,options,M,I_pdr);
%CDR
[tB,xB] = ode45(@cyclerPaxis,tspan,x0,options,M,I_cdr);
%FINAL
[tC,xC] = ode45(@cyclerPaxis,tspan,x0,options,M,I);

% DATA ASSIGNMENT
w_xA = xA(:,1);
w_yA = xA(:,2);
w_zA = xA(:,3);
w_xB = xB(:,1);
w_yB = xB(:,2);
w_zB = xB(:,3);
w_xC = xC(:,1);
w_yC = xC(:,2);
w_zC = xC(:,3);

% PLOTS
figure(5)
subplot(3,1,1)
plot(tA,w_xA,'-k','Linewidth',2)
hold on
plot(tA,w_yA,'--k','Linewidth',2)
plot(tA,w_zA,'-.k','Linewidth',2)
    grid on
    title('PDR Cycler Anguler Velocity vs Time - Eric Eagon')
    ylabel('Angular Velocity [rad/s]')
    xlabel('Time [s]')
    legend('w_x','w_y','w_z')

subplot(3,1,2)
plot(tB,w_xB,'-k','Linewidth',2)
hold on
plot(tB,w_yB,'--k','Linewidth',2)
plot(tB,w_zB,'-.k','Linewidth',2)
    grid on
    title('CDR Cycler Anguler Velocity vs Time - Eric Eagon')
    ylabel('Angular Velocity [rad/s]')
    xlabel('Time [s]')
    legend('w_x','w_y','w_z')
    
subplot(3,1,3)
plot(tC,w_xC,'-k','Linewidth',2)
hold on
plot(tC,w_yC,'--k','Linewidth',2)
plot(tC,w_zC,'-.k','Linewidth',2)
    grid on
    title('Cycler Anguler Velocity vs Time - Eric Eagon')
    ylabel('Angular Velocity [rad/s]')
    xlabel('Time [s]')
    legend('w_x','w_y','w_z')
    
figure(6)
plot(tC,w_xC,'-k','Linewidth',2)
hold on
plot(tC,w_yC,'--k','Linewidth',2)
plot(tC,w_zC,'-.k','Linewidth',2)
    grid on
    title('Cycler Anguler Velocity with Perturbations')
    ylabel('Angular Velocity [rad/s]')
    xlabel('Time [s]')
    xlim([0,100])
    legend('w_x','w_y','w_z')
