%%%%%
% AAE 450: Spacecraft Design
%
% Determine during which periods the Sun may interfere with optical
% communications between Earth, Mars, and the Sun-Mars L4 and L5 Lagrange
% points.
%
% Author: Jordan Mayer (Mission Design)
% Created: 01/27/2020
% Last Modified: 02/19/2020
%%%%%

%% Preliminary setup
clear all; close all; format compact;
addpath('General Helper Functions/');
AU_to_km = 149597870.7;  % astronomical unit

% Set constants and body parameters (from NASA Fact Sheets)

% Gravitational parameters (GM), km^3/s^2
mu_Sun = 132712e6;
mu_Earth = 0.39860e6;
mu_Mars = 0.042828e6;

% Semimajor axes, km
a_Earth = 149.60e6;
a_Mars = 227.92e6;

% Eccentricities, dimensionless
e_Earth = 0.0167;
e_Mars = 0.0935;

% Mean motions, rad/s
n_Earth = sqrt(mu_Sun/a_Earth^3);
n_Mars = sqrt(mu_Sun/a_Mars^3);

% Longitudes of ascending nodes (J2000), deg
OMEGA_Earth = -11.26064;
OMEGA_Mars = 49.57853;

% Longitudes of perihelion (J2000), deg
omega_bar_Earth = 102.94719;
omega_bar_Mars = 336.04084;

% Arguments of perihelion (J2000), deg
omega_Earth = omega_bar_Earth - OMEGA_Earth;
omega_Mars = omega_bar_Mars - OMEGA_Mars;

% Initial mean anomalies (JD 2459031, 06/30/2020), deg
M_0_Earth = 1.771280647464939e2;
M_0_Mars = 3.422533057517022e2;

%% Generate position data

% Set up time steps
yr_to_day = 365;
day_to_hr = 24;
hr_to_sec = 60*60;
yr_to_sec = yr_to_day*day_to_hr*hr_to_sec;
t_f = 15*yr_to_sec;
  % simulate for 15 years (from Byrnes, Longuski, and Aldrin: "The inertial
  % geometry repeats every 15 years")
n_data = 10000;  % number of data points
t_list = linspace(0.0,t_f,n_data).';  % all times, sec

% Allocate data arrays

% 2-D position arrays
r_list_Earth = zeros(n_data, 2);
r_list_Mars = zeros(n_data, 2);
r_list_ML4 = zeros(n_data, 2);
r_list_ML5 = zeros(n_data, 2);
r_list_EL4 = zeros(n_data, 2);
r_list_EL5 = zeros(n_data, 2);

% Visibility arrays (0 if visible, 1 if not)
% ML: Mars-Sun Lagrange point
% EL: Earth-Sun Lagrange point
ML4_block_list = zeros(n_data, 1);
ML5_block_list = zeros(n_data, 1);
Mars_block_list = zeros(n_data, 1);
EL4_block_list = zeros(n_data, 1);
EL5_block_list = zeros(n_data, 1);

% Minimum distance arrays
min_dist_Earth_ML = zeros(n_data, 1);  % Earth to closest ML4/ML5
min_dist_Mars_EL = zeros(n_data, 1);  % Mars to closest EL4/EL5
min_dist_EL_ML = zeros(n_data, 1);
  % Shortest distance between EL4/EL5 and ML4/ML5

% Prepare Keplerian element arrays
% [semimajor axis (km), eccentricity, inclination (deg), longitude of
%  ascending node (deg), argument of periapsis (deg), mean anomaly (deg)]
kep_Earth = [a_Earth, e_Earth, 0.0, OMEGA_Earth, omega_Earth, M_0_Earth];
kep_Mars = [a_Mars, e_Mars, 0.0, OMEGA_Mars, omega_Mars, M_0_Mars];

% Compute position data
for k = 1:n_data
	delta_t = t_list(k);
  
  % Compute mean anomalies, deg
  M_Earth = M_0_Earth + rad2deg(n_Earth*delta_t);
  M_Mars = M_0_Mars + rad2deg(n_Mars*delta_t);
  
  % Update Keplerian element arrays
  kep_Earth(6) = M_Earth;
  kep_Mars(6) = M_Mars;
  
  % Compute Cartesian vectors [position (km), velocity (km)]
  car_Earth = kep2car(kep_Earth, mu_Sun, 'deg');
  car_Mars = kep2car(kep_Mars, mu_Sun, 'deg');
  if car_Earth(3) > 0 || car_Mars(3) > 0
    error('3-D?');
  end
  
  % Get 3-D position vectors
  r_Earth = car_Earth(1:3);
  r_Mars = car_Mars(1:3);
  r_ML4 = rot_mat_3(deg2rad(60)) * r_Mars;
  r_ML5 = rot_mat_3(deg2rad(-60)) * r_Mars;
  r_EL4 = rot_mat_3(deg2rad(60)) * r_Earth;
  r_EL5 = rot_mat_3(deg2rad(-60)) * r_Earth;
  
  % Compute angles to Sun, as viewed from Earth
  r_Earth_Sun = -r_Earth;
  r_Earth_ML4 = r_ML4 - r_Earth;
  r_Earth_Mars = r_Mars - r_Earth;
  r_Earth_ML5 = r_ML5 - r_Earth;
  r_Earth_EL4 = r_EL4 - r_Earth;
  r_Earth_EL5 = r_EL5 - r_Earth;
  theta_ML4_Earth = angle_between(r_Earth_Sun, r_Earth_ML4);
  theta_ML5_Earth = angle_between(r_Earth_Sun, r_Earth_ML5);
  theta_Mars = angle_between(r_Earth_Sun, r_Earth_Mars);
  theta_EL4_Earth = angle_between(r_Earth_Sun, r_Earth_EL4);
  theta_EL5_Earth = angle_between(r_Earth_Sun, r_Earth_EL5);
  
  % Compute angles to Sun, as viewed from Mars
  r_Mars_Sun = -r_Mars;
  r_Mars_ML4 = r_ML4 - r_Mars;
  r_Mars_Earth = -r_Earth_Mars;
  r_Mars_ML5 = r_ML5 - r_Mars;
  r_Mars_EL4 = r_EL4 - r_Mars;
  r_Mars_EL5 = r_EL5 - r_Mars;
  theta_ML4_Mars = angle_between(r_Mars_Sun, r_Mars_ML4);
  theta_ML5_Mars = angle_between(r_Mars_Sun, r_Mars_ML5);
  theta_Earth = angle_between(r_Mars_Sun, r_Mars_Earth);
  theta_EL4_Mars = angle_between(r_Mars_Sun, r_Mars_EL4);
  theta_EL5_Mars = angle_between(r_Mars_Sun, r_Mars_EL5);

  % Store 2-D positions
  r_list_Earth(k,:) = r_Earth(1:2);
  r_list_Mars(k,:) = r_Mars(1:2);
  r_list_ML4(k,:) = r_ML4(1:2);
  r_list_ML5(k,:) = r_ML5(1:2);
  r_list_EL4(k,:) = r_EL4(1:2);
  r_list_EL5(k,:) = r_EL5(1:2);
  
  % Determine if any communications are blocked by the Sun
  if theta_ML4_Earth <= 3 || theta_ML4_Mars <= 3
    ML4_block_list(k) = 1;
  end
  if theta_ML5_Earth <= 3 || theta_ML5_Mars <= 3
    ML5_block_list(k) = 2;
  end
  if theta_Mars <= 3 || theta_Earth <= 3
    Mars_block_list(k) = 3;
  end
  if theta_EL4_Earth <= 3 || theta_EL4_Mars <= 3
    EL4_block_list(k) = 1;
  end
  if theta_EL5_Earth <= 3 || theta_EL5_Mars <= 3
    EL5_block_list(k) = 2;
  end
  if (ML4_block_list(k) == 1) && (ML5_block_list(k) == 2)
    fprintf('Uh oh! Both Mars Lagrange points blocked!');
  end
  if (EL4_block_list(k) == 1) && (EL5_block_list(k) == 2)
    fprintf('Uh oh! Both Earth Lagrange points blocked!');
  end
  if ((ML4_block_list(k) == 1) + (ML5_block_list(k) == 2) + ...
      (EL4_block_list(k) == 1) + (EL5_block_list(k) == 2) >= 3)
    fprintf('Uh oh! Only one visible relay!');
  end
  
  % Compute and store closest distances
  dist_Earth_ML4 = norm(r_Earth_ML4);
  dist_Earth_ML5 = norm(r_Earth_ML5);
  dist_Mars_EL4 = norm(r_Mars_EL4);
  dist_Mars_EL5 = norm(r_Mars_EL5);
  dist_EL4_ML4 = norm(r_ML4 - r_EL4);
  dist_EL4_ML5 = norm(r_ML5 - r_EL4);
  dist_EL5_ML4 = norm(r_ML4 - r_EL5);
  dist_EL5_ML5 = norm(r_ML5 - r_EL5);
  min_dist_Earth_ML(k) = min([dist_Earth_ML4, dist_Earth_ML5]);
  min_dist_Mars_EL(k) = min([dist_Mars_EL4, dist_Mars_EL5]);
  min_dist_EL_ML(k) = min([dist_EL4_ML4, dist_EL4_ML5, ...
                           dist_EL5_ML4, dist_EL5_ML5]);
end

%% Plot results
close all;
yr_list = t_list ./ yr_to_sec;

% Plot visibility of Lagrange points
figure(2);
subplot(2,1,1);
msize = 4;
plot(yr_list, ML4_block_list, 'sc', 'MarkerFaceColor', 'c', ...
     'MarkerSize', msize); hold on;
plot(yr_list, ML5_block_list, 'sg', 'MarkerFaceColor', 'g', ...
     'MarkerSize', msize);
plot(yr_list, Mars_block_list, 'sr', 'MarkerFaceColor', 'r', ...
     'MarkerSize', msize);
ylim([0.5, 3.5]);
yticks([1, 2, 3]);
yticklabels({'ML4 Blocked', 'ML5 Blocked', 'Mars Blocked'});
xlabel('time, yrs');
grid on;
title('Visibility of Mars Lagrange Points');
subplot(2,1,2);
plot(yr_list, EL4_block_list, 'sc', 'MarkerFaceColor', 'c', ...
     'MarkerSize', msize); hold on;
plot(yr_list, EL5_block_list, 'sg', 'MarkerFaceColor', 'g', ...
     'MarkerSize', msize);
plot(yr_list, Mars_block_list, 'sr', 'MarkerFaceColor', 'r', ...
     'MarkerSize', msize);
ylim([0.5, 3.5]);
yticks([1, 2, 3]);
yticklabels({'EL4 Blocked', 'EL5 Blocked', 'Mars Blocked'});
xlabel('time, yrs');
grid on;
title('Visibility of Earth Lagrange Points');

%% Compute Lagrange point visibility percentages

percent_ML4 = sum(ML4_block_list == 0)/n_data * 100
percent_ML5 = sum(ML5_block_list == 0)/n_data * 100
percent_ML_both = sum(ML4_block_list == 0 & ML5_block_list == 0)/n_data * 100
percent_EL4 = sum(EL4_block_list == 0)/n_data * 100
percent_EL5 = sum(EL5_block_list == 0)/n_data * 100
percent_EL_both = sum(EL4_block_list == 0 & EL5_block_list == 0)/n_data * 100