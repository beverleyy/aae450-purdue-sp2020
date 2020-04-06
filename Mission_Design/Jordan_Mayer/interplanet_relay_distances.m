%%%%%
% AAE 450: Spacecraft Design
%
% Determine distances between Earth, Mars, and four possible interplanetary
% relay satellite locations (Sun-Earth L4 and L5, and Sun-Mars L4 and L5).
%
% Author: Jordan Mayer (Mission Design)
% Created: 02/04/2020
% Last Modified: 02/05/2020
%%%%%

%% Preliminary setup
format compact;
addpath('General Helper Functions/');
AU_to_km = 149597870.700;  % Astronomical Units to km

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
% (source: JPL HORIZONS Web-Interface)
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
t_list = linspace(0.0,t_f,n_data).';

% Allocate position arrays, km (only relative coords matter for now)
% (keep it 2-D for now)
r_list_Earth = zeros(n_data, 2);  % Earth position
r_list_Mars = zeros(n_data, 2);  % Mars position
r_list_ML4 = zeros(n_data, 2);  % Mars L4 position
r_list_ML5 = zeros(n_data, 2);  % Mars L5 position
r_list_EL4 = zeros(n_data, 2);  % Earth L4 position
r_list_EL5 = zeros(n_data, 2);  % Earth L5 position

% Allocate distance arrays, AU
dist_list_Earth_Mars = zeros(n_data, 1);
dist_list_Earth_ML4 = zeros(n_data, 1);
dist_list_Earth_ML5 = zeros(n_data, 1);
dist_list_Mars_EL4 = zeros(n_data, 1);
dist_list_Mars_EL5 = zeros(n_data, 1);
dist_list_EL4_ML4 = zeros(n_data, 1);
dist_list_EL4_ML5 = zeros(n_data, 1);
dist_list_EL5_ML4 = zeros(n_data, 1);
dist_list_EL5_ML5 = zeros(n_data, 1);

% Prepare Keplerian element arrays
% [semimajor axis (km), eccentricity, inclination (deg), longitude of
%  ascending node (deg), argument of periapsis (deg), mean anomaly (deg)]
kep_Earth = [a_Earth, e_Earth, 0.0, OMEGA_Earth, omega_Earth, M_0_Earth];
kep_Mars = [a_Mars, e_Mars, 0.0, OMEGA_Mars, omega_Mars, M_0_Mars];

% Get that data!
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
  
  % Get 3-D position vectors, km
  r_Earth = car_Earth(1:3);
  r_Mars = car_Mars(1:3);
  r_ML4 = rot_mat_3(deg2rad(60)) * r_Mars;
  r_ML5 = rot_mat_3(deg2rad(-60)) * r_Mars;
  r_EL4 = rot_mat_3(deg2rad(60)) * r_Earth;
  r_EL5 = rot_mat_3(deg2rad(-60)) * r_Earth;
  
  % Store 2-D positions
  r_list_Earth(k,:) = r_Earth(1:2);
  r_list_Mars(k,:) = r_Mars(1:2);
  r_list_ML4(k,:) = r_ML4(1:2);
  r_list_ML5(k,:) = r_ML5(1:2);
  r_list_EL4(k,:) = r_EL4(1:2);
  r_list_EL5(k,:) = r_EL5(1:2);
  
  % Compute distances, AU
  dist_list_Earth_Mars(k) = norm(r_Mars - r_Earth)/AU_to_km;
  dist_list_Earth_ML4(k) = norm(r_ML4 - r_Earth)/AU_to_km;
  dist_list_Earth_ML5(k) = norm(r_ML5 - r_Earth)/AU_to_km;
  dist_list_Mars_EL4(k) = norm(r_EL4 - r_Mars)/AU_to_km;
  dist_list_Mars_EL5(k) = norm(r_EL5 - r_Mars)/AU_to_km;
  dist_list_EL4_ML4(k) = norm(r_ML4 - r_EL4)/AU_to_km;
  dist_list_EL4_ML5(k) = norm(r_ML5 - r_EL4)/AU_to_km;
  dist_list_EL5_ML4(k) = norm(r_ML4 - r_EL5)/AU_to_km;
  dist_list_EL5_ML5(k) = norm(r_ML5 - r_EL5)/AU_to_km;
end

%% Plot results
close all;

yr_list = t_list ./ yr_to_sec;

% Plot Earth distances
figure(1);
plot(yr_list, dist_list_Earth_Mars, '-r'); hold on;
plot(yr_list, dist_list_Earth_ML4, '-c');
plot(yr_list, dist_list_Earth_ML5, '-m');
title('Distances from Earth'); grid on;
legend('Mars', 'Sun-Mars L4', 'Sun-Mars L5');
xlabel('Time, years'); ylabel('Distance, AU');

% Plot Mars distances
figure(2);
plot(yr_list, dist_list_Earth_Mars, '-b'); hold on;
plot(yr_list, dist_list_Mars_EL4, '-c');
plot(yr_list, dist_list_Mars_EL5, '-m');
title('Distances from Mars'); grid on;
legend('Earth', 'Sun-Earth L4', 'Sun-Earth L5');
xlabel('Time, years'); ylabel('Distance, AU');

% Plot Lagrange point distances
figure(3);
plot(yr_list, dist_list_EL4_ML4, '-b'); hold on;
plot(yr_list, dist_list_EL4_ML5, '-c');
plot(yr_list, dist_list_EL5_ML4, '-r');
plot(yr_list, dist_list_EL5_ML5, '-m');
title('Distances between Lagrange Points'); grid on;
legend('EL4 to ML4', 'EL4 to ML5', 'EL5 to ML4', 'EL5 to ML5');
xlabel('Time, years'); ylabel('Distance, AU');

%% Output max distances, AU

% Earth distances
fprintf('\nMax Earth distances:\n\n');
max_dist_Earth_Mars = max(dist_list_Earth_Mars)
max_dist_Earth_ML4 = max(dist_list_Earth_ML4)
max_dist_Earth_ML5 = max(dist_list_Earth_ML5)
min_dist_list_Earth = zeros(n_data,1);
for k=1:n_data
    min_dist_list_Earth(k) = min([dist_list_Earth_Mars(k), ...
                                  dist_list_Earth_ML4(k), ...
                                  dist_list_Earth_ML5(k)]);
end
max_dist_Earth_any = max(min_dist_list_Earth)

% Mars distances
fprintf('\nMax Mars distances:\n\n');
max_dist_Mars_EL4 = max(dist_list_Mars_EL4)
max_dist_Mars_EL5 = max(dist_list_Mars_EL5)
min_dist_list_Mars = zeros(n_data,1);
for k=1:n_data
    min_dist_list_Mars(k) = min([dist_list_Earth_Mars(k), ...
                                 dist_list_Mars_EL4(k), ...
                                 dist_list_Mars_EL5(k)]);
end
max_dist_Mars_any = max(min_dist_list_Mars)

% Lagrange point distances
fprintf('\nMax Lagrange point distances:\n\n');
max_dist_EL4_ML4 = max(dist_list_EL4_ML4)
max_dist_EL4_ML5 = max(dist_list_EL4_ML5)
max_dist_EL5_ML4 = max(dist_list_EL5_ML4)
max_dist_EL5_ML5 = max(dist_list_EL5_ML5)
min_dist_list_Earth_4 = zeros(n_data,1);
min_dist_list_Mars_4 = zeros(n_data,1);

%% Compute and plot/output "closest relay" distances
% Here, "closest" is how far a relay satellite at a Sun-Earth L4 or L5
% point would have to communicate to reach a Sun-Mars L4 or L5 point
% satellite. The "2nd closest" distance is also computed in an attempt to
% assess the redundancy of the system.

dist_closest = zeros(n_data, 1);
dist_2nd_closest = zeros(n_data, 1);
for k = 1:n_data
    relay_dists = sort([a_Mars, a_Earth, dist_list_Earth_Mars(k), ...
                        dist_list_EL4_ML4(k), dist_list_EL4_ML5(k), ...
                        dist_list_EL5_ML4(k), dist_list_EL5_ML5(k)]);
    dist_closest(k) = relay_dists(1);
    dist_2nd_closest(k) = relay_dists(2);
end

figure(4);
plot(yr_list, dist_closest, '-b'); hold on;
plot(yr_list, dist_2nd_closest, '-r'); hold on;
title('Closest Distances between Earth L4/L5 and Mars L4/L5');
grid on; xlabel('Time, years'); ylabel('Distance, AU');
legend('Closest', '2nd Closest');

fprintf('\nMax "closest relay" distances:\n\n');
max_dist_closest = max(dist_closest)
max_dist_2nd_closest = max(dist_2nd_closest)