%% Minimum Radius
% Eli Sitchin
% February 2020
% AAE 45000-001
% Purdue University
% This function provides an estimate of the surface area of the cycler
% vehicle.
function A = SurfaceArea(theta,t_wall)

theta = theta*pi/180;

r_ceil = 400; % Habitation Ceiling Radius (m)
r_floor = 402.5; % Habitation Floor Radius (m)
w_floor = 6; % Floor Width (m)
r_elev = 2.5;
w_truss = 1;
h_truss = 1;
r_super = 10;
l_super = 65;
theta_stat = theta;
w_stat = 50.4;

r_i = r_ceil-t_wall;
r_o = r_floor+t_wall;
w_hab = w_floor+2*t_wall;

A_super = 2*pi*r_super*l_super + 2*pi*r_super^2;
A_hab = theta*(r_o^2-r_i^2) + 2*w_hab*(r_o-r_i) + w_hab*r_i*theta + ...
    w_hab*r_o*theta;
A_elev = 2*pi*r_elev*(r_i-r_super);
A_truss = 2*(w_truss+h_truss)*(r_i-r_super);
A_stat = 2*w_stat*(r_o-r_i) + w_stat*r_i*theta_stat + ...
    w_stat*r_o*theta_stat;
A_solar = 2*13440;
A = A_super + 4*A_hab + 4*A_elev + 8*A_truss + 2*A_stat + A_solar;
