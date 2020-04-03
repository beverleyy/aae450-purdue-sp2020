%% Purdue University AAE 450 Spacecraft Design, Spring 2020
%  Pertubation Torques - Gravity Gradient Calculations
%  Beverley Yeo (U1721040H)
%  Nanyang Technological University, Singapore

clear all;
clc;

%% Constants

% Standardized gravitational constant
mu_sun = 1.32712440018e+20;
mu_earth = 3.986004418e+14;
mu_mars = 4.282837e+13;

% Distances
Rs_min = 1.282e+8;
Rs_avg = 1.845e+8;
Re = 7378e+3;
Rm = 3697e+3;

% Moment of inertia
Iy = 7.048e+12;
Iz = 7.047e+12;

% Angle
theta = deg2rad(0.1);

%% Calculate each torque component

% Torque from sun = interplanetary torque (neglect Earth, Mars)
Ts_min = (1.5*mu_sun/Rs_min^3)*(Iy-Iz)*sin(2*theta);
Ts_avg = (1.5*mu_sun/Rs_avg^3)*(Iy-Iz)*sin(2*theta);

% Near-Earth
Te = (1.5*mu_earth/Re^3)*(Iy-Iz)*sin(2*theta) + Ts_avg;

% Near-Mars
Tm = (1.5*mu_mars/Rm^3)*(Iy-Iz)*sin(2*theta) + Ts_avg;