% coil_sim
% Author: Arch Pleumpanya
% Description: This script outputs the acceleration profile of a single
% section of induction coilgun using arbitrary physical parameters to
% demonstrate the thrust ripple effect inherent in coilguns.
clear
clc
close all
set(0,'defaultlinelinewidth',1.5);
set(0,'defaultaxesfontsize',12);
set(0,'defaulttextinterpreter','latex');
% 
%% Initialization
g = 9.80665; % Earth's gravitational acceleration [m/s2]
m = 269e3; % projectile mass [kg]
R1 = 5.5; % tube radius [m]
R2 = 4.5; % projectile radius [m]
W1 = 50; % tube length [m]
W2 = 1; % projectile length [m]
N1 = 50; % number of coils along tube
N2 = 1; % number of coils along projectile
mu = 0.5*4e-7*pi; % magnetic permeability [H/m]
n = 1501; % number of points along section
x1 = linspace(-W1/2,W1,n); % distance from coil center [m]
A_c = pi*(W1/N1/2)^2*10000; % coil wire cross-sectional area [cm2]
I_c = 0.2*500*A_c; % coil current [A]
dt = 0.00001; % time step [s]
%
%% Calculations
coef = mu*pi*R1^2*R2^2*N1*N2/(2*W1); % multiplication coefficient
L1 = x1 - W1*ones(size(x1))/2; % distance from coil center to projectile aft edge [m]
L2 = x1 + W1*ones(size(x1))/2; % distance from coil center to projectile forward edge [m]
d1 = sqrt(L1.^2+R1^2*ones(size(x1))); % distance for calculation [m]
d2 = sqrt(L2.^2+R1^2*ones(size(x1))); % distance for calculation [m]
M = coef*(2/R1^2*(L2./d2 - L1./d1) - R2^2/4*(3-W2^2/R2^2)*(L1/d1.^5-L2./d2.^5)); % mutual inductance [H]
lambda = 0.37; % Nagaoka's coefficient
L_p = lambda*1e-7*(2*pi*R2*N2)^2/W2; % self-inductance of projectile
dM_dx = zeros(1,size(x1,2)); % discrete differentiation of M wrt to x
F_full = zeros(1,size(x1,2)); % induced force for constantly energized coil [N]
F_drive = zeros(1,size(x1,2)); % induced force for acceleration [N]
for i = 2:size(x1,2)
    dM_dx(i) =(M(i) - M(i-1))/(W1/(n-1));
    if M(i)*dM_dx(i)<0
        F_drive(i) = -I_c^2/L_p*M(i)*dM_dx(i);
    else
        F_drive(i) = 0;
    end
    F_full(i) = -I_c^2/L_p*M(i)*dM_dx(i);
end
a_c = F_drive'/m; % acceleration [m/s2]
% 
%% Multi-stage
a_ms = zeros(5501,10); % multi-stage acceleration [m/s2]
for i = 1:5
    a_ms((i-1)*1000+1:(i-1)*1000+1501,i) = a_c;
end
a_ms = sum(a_ms,2);
%
%% Plots
F_full(1) = NaN;
figure(1)
plot(x1/W1,F_full/m/g)
title('Acceleration for Single-Stage Coilgun','fontsize',15)
xlabel('distance from coil center [sections]')
ylabel('acceleration [g]')
grid on
% 
figure(2)
plot(x1/W1,a_c/g)
title('Acceleration for Single-Stage Coilgun','fontsize',15)
xlabel('distance from coil center [sections]')
ylabel('acceleration [g]')
grid on
% 
figure(3)
plot(linspace(0,5,5001),a_ms(1:5001)/g)
title('Acceleration for Multi-Stage Coilgun','fontsize',15)
xlabel('distance from start [sections]')
ylabel('acceleration [g]')
grid on
% end
