%%%%%
% AAE 450: Spacecraft Design
%
% Determine distances between cycler vehicles and communication points
% (Earth, Mars, and 4 interplanetary relays), as well as any blackout
% periods.
%
% Author: Jordan Mayer (Mission Design)
% Created: 02/21/2020
% Last Modified: 02/21/2020
%%%%%

%% Preliminary setup
format compact;
addpath('General Helper Functions/');
AU_to_km = 149597870.700;  % Astronomical Units to km

% Extract cycler data
Trajectory = load('Data/Trajectory_Information.mat');
Trajectory = Trajectory.Trajectory;
cyclers = [Trajectory.Vehicle1; Trajectory.Vehicle2; ...
           Trajectory.Vehicle3; Trajectory.Vehicle4];

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

%% Conduct analysis

for v = 1:4  % for each cycler vehicle
  % Extract cycler data
  cycler = cyclers(v);
  JD_list = cycler.julian_date;  % Julian Dates for data
  n_data = length(JD_list);  % number of data points
  r_list_cycler = cycler.position(:,1:2) * AU_to_km;
    % position vectors, 2-D, km
  
  % Create time list in seconds
  yr_to_day = 365;
  day_to_hr = 24;
  hr_to_sec = 60*60;
  day_to_sec = day_to_hr*hr_to_sec;
  yr_to_sec = yr_to_day*day_to_sec;
  t_list = (JD_list - JD_list(1))*day_to_sec ;
    % relative time (since JD_0) for each data point, sec
  
  if v == 1
    % Initial mean anomalies (JD 2459031, 06/30/2020), deg
    % (source: JPL HORIZONS Web-Interface)
    M_0_Earth = 1.771280647464939e2;
    M_0_Mars = 3.422533057517022e2;
  else
    break;  % TODO: implement for other cyclers
  end
  
  % Allocate position arrays, km (only relative coords matter for now)
  % (keep it 2-D for now)
  r_list_Earth = zeros(n_data, 2);  % Earth position
  r_list_Mars = zeros(n_data, 2);  % Mars position
  r_list_ML4 = zeros(n_data, 2);  % Mars L4 position
  r_list_ML5 = zeros(n_data, 2);  % Mars L5 position
  r_list_EL4 = zeros(n_data, 2);  % Earth L4 position
  r_list_EL5 = zeros(n_data, 2);  % Earth L5 position

  % Allocate distance arrays, AU
  dist_list_Earth = zeros(n_data, 1);
  dist_list_Mars = zeros(n_data, 1);
  dist_list_EL4 = zeros(n_data, 1);
  dist_list_EL5 = zeros(n_data, 1);
  dist_list_ML4 = zeros(n_data, 1);
  dist_list_ML5 = zeros(n_data, 1);
  
  % Allocate visibility arrays
  Earth_block_list = zeros(n_data, 1);
  Mars_block_list = zeros(n_data, 1);
  EL4_block_list = zeros(n_data, 1);
  EL5_block_list = zeros(n_data, 1);
  ML4_block_list = zeros(n_data, 1);
  ML5_block_list = zeros(n_data, 1);
  
  % Allocate minimum distance array
  min_dist_vis = zeros(n_data, 1);
  
  % Prepare Keplerian element arrays
  % [semimajor axis (km), eccentricity, inclination (deg), longitude of
  %  ascending node (deg), argument of periapsis (deg), mean anomaly (deg)]
  kep_Earth = [a_Earth, e_Earth, 0.0, OMEGA_Earth, omega_Earth, M_0_Earth];
  kep_Mars = [a_Mars, e_Mars, 0.0, OMEGA_Mars, omega_Mars, M_0_Mars];
  
  % Compute Earth/Mars/relay position data
  for k = 1:n_data
    delta_t = t_list(k);
    
    % Get cycler position
    r_cycler = [r_list_cycler(k,:), 0];  % km
    
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
    
    % Rotate them all to be rows I guess
    r_Earth = r_Earth.';
    r_Mars = r_Mars.';
    r_ML4 = r_ML4.';
    r_ML5 = r_ML5.';
    r_EL4 = r_EL4.';
    r_EL5 = r_EL5.';
    
    % Store 2-D positions, km
    r_list_Earth(k,:) = r_Earth(1:2);
    r_list_Mars(k,:) = r_Mars(1:2);
    r_list_ML4(k,:) = r_ML4(1:2);
    r_list_ML5(k,:) = r_ML5(1:2);
    r_list_EL4(k,:) = r_EL4(1:2);
    r_list_EL5(k,:) = r_EL5(1:2);
    
    % Compute distances, AU
    dist_list_Earth(k) = norm(r_Earth - r_cycler)/AU_to_km;
    dist_list_Mars(k) = norm(r_Mars - r_cycler)/AU_to_km;
    dist_list_EL4(k) = norm(r_EL4 - r_cycler)/AU_to_km;
    dist_list_EL5(k) = norm(r_EL5 - r_cycler)/AU_to_km;
    dist_list_ML4(k) = norm(r_ML4 - r_cycler)/AU_to_km;
    dist_list_ML5(k) = norm(r_ML5 - r_cycler)/AU_to_km;
    
    % Determine angles to Sun, as viewed from cycler
    r_cyc_Sun = -r_cycler;
    r_cyc_Earth = r_Earth - r_cycler;
    r_cyc_Mars = r_Mars - r_cycler;
    r_cyc_EL4 = r_EL4 - r_cycler;
    r_cyc_EL5 = r_EL5 - r_cycler;
    r_cyc_ML4 = r_ML4 - r_cycler;
    r_cyc_ML5 = r_ML5 - r_cycler;
    theta_Earth = angle_between(r_cyc_Sun, r_cyc_Earth);
    theta_Mars = angle_between(r_cyc_Sun, r_cyc_Mars);
    theta_EL4 = angle_between(r_cyc_Sun, r_cyc_EL4);
    theta_EL5 = angle_between(r_cyc_Sun, r_cyc_EL5);
    theta_ML4 = angle_between(r_cyc_Sun, r_cyc_ML4);
    theta_ML5 = angle_between(r_cyc_Sun, r_cyc_ML5);
    
    % Determine if "blackout" occurs
    num_vis = (theta_Earth > 3) + (theta_Mars > 3) + (theta_EL4 > 3) + ...
              (theta_EL5 > 3) + (theta_ML4 > 3) + (theta_ML5 > 3);
    if num_vis == 0
      print('\nTotal blackout\n');
    elseif num_vis < 2
      print('\nPartial blackout\n');
    end
  end
  
  % Plot positions!
  close all;
  figure(1);
  plot(r_list_Earth(:,1), r_list_Earth(:,2), '.b'); hold on;
  plot(r_list_Mars(:,1), r_list_Mars(:,2), '.r');
  plot(r_list_EL4(:,1), r_list_EL4(:,2), '.c');
  plot(r_list_EL5(:,1), r_list_EL5(:,2), '.g');
  plot(r_list_ML4(:,1), r_list_ML4(:,2), '.m');
  plot(r_list_ML5(:,1), r_list_ML5(:,2), '.y');
  plot(r_list_cycler(:,1), r_list_cycler(:,2), '.k');
  axis equal; grid on;
  xlabel('x, km'); ylabel('y, km');
  legend('Earth', 'Mars', 'EL4', 'EL5', 'ML4', 'ML5', 'Cycler');
  
  % Plot distances!
  figure(2);
  plot(t_list/yr_to_sec, dist_list_Earth, '-b'); hold on;
  plot(t_list/yr_to_sec, dist_list_Mars, '-r');
  plot(t_list/yr_to_sec, dist_list_EL4, '-c');
  plot(t_list/yr_to_sec, dist_list_EL5, '-g');
  plot(t_list/yr_to_sec, dist_list_ML4, '-m');
  plot(t_list/yr_to_sec, dist_list_ML5, '-y');
  grid on;
  title('Distances for Cycler Communication');
  xlabel('time, years'); ylabel('distance, AU');
  legend('Earth', 'Mars', 'EL4', 'EL5', 'ML4', 'ML5');
  
  % Determine max communication distances
  dist_closest = zeros(n_data, 1);
  dist_2nd_closest = zeros(n_data, 1);
  for k = 1:n_data
    dists = sort([dist_list_Earth(k), dist_list_Mars(k), ...
                  dist_list_EL4(k), dist_list_EL5(k), ...
                  dist_list_ML4(k), dist_list_ML5(k)]);
    dist_closest(k) = dists(1);
    dist_2nd_closest(k) = dists(2);
  end
  
  figure(3);
  plot(t_list/yr_to_sec, dist_closest, '-b'); hold on;
  plot(t_list/yr_to_sec, dist_2nd_closest, '-r');
  title('Closest Distances for Cycler Communication');
  grid on; xlabel('Time, years'); ylabel('Distance, AU');
  legend('Closest', '2nd Closest');
  
  fprintf('\nMax "closest" distances:\n\n');
  max_dist_closest = max(dist_closest)
  max_dist_2nd_closest = max(dist_2nd_closest)
end