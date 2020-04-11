% coilgun_verify
% Author: Arch Pleumpanya
% Description: This script verifies coilgun acceleration profile outlined
% by K. Matsugata in "Hyper velocity acceleration by a pulsed coilgun using
% traveling magnetic field".
clear
clc
close all
set(0,'defaultlinelinewidth',1.5);
set(0,'defaultaxesfontsize',12);
set(0,'defaulttextinterpreter','latex');
% 
%% Initialization
R1 = 0.02; % tube radius [m]
R2 = 0.016; % projectile radius [m]
W1 = 0.04; % tube width [m]
W2 = 0.008; % projectile width [m]
N1 = 24; % number of coils along tube
N2 = 1; % number of coils along projectile
mu = 0.5*4e-7*pi; % magnetic permeability [H/m]
n = 1001; % number of points along section
x = linspace(0,W1,n); % distance from coil center [m]
I_c = 40e3; % coil current [A]
dt = 0.00001; % time step [s]
%
%% Calculations
coef = mu*pi*R1^2*R2^2*N1*N2/(2*W1); % multiplication coefficient
L1 = x - W1*ones(size(x))/2; % distance from coil center to projectile aft edge [m]
L2 = x + W1*ones(size(x))/2; % distance from coil center to projectile forward edge [m]
d1 = sqrt(L1.^2+R1^2*ones(size(x))); % distance for calculation [m]
d2 = sqrt(L2.^2+R1^2*ones(size(x))); % distance for calculation [m]
M = coef*(2/R1^2*(L2./d2 - L1./d1) - R2^2/4*(3-W2^2/R2^2)*(L1/d1.^5-L2./d2.^5)); % mutual inductance [H]
lambda = 0.37; % Nagaoka's coefficient
L_p = lambda*1e-7*(2*pi*R2*N2)^2/W2; % self-inductance of projectile
dM_dx = zeros(1,size(x,2)); % discrete differentiation of M wrt to x
F = zeros(1,size(x,2)); % induced force [N]
for i = 2:size(x,2)
    dM_dx(i) =(M(i) - M(i-1))/(W1/(n-1));
    if M(i)*dM_dx(i)<0
        F(i) = -I_c^2/L_p*M(i)*dM_dx(i);
    else
        F(i) = 0;
    end
end
% 
%% Plots
figure(1)
plot(x*100,F)
title('Force on Projectile Produced by Coilgun Section','fontsize',15)
xlabel('distance from coil center [cm]')
ylabel('force [N]')
grid on
% end
