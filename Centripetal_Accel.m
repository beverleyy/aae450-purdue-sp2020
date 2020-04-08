clc
clear

%% Total Acceleration

% Luna tether length and tip speed
length_tether = 2706000; % m
tipSpeed = 5153; % m/s

% convert to angular velocity in rad/sec
% (same regardless of dist from center)
angleSpeed = tipSpeed/length_tether;

% compute the velocity as you go out toward the
% end of the tether, in m/s
distance = 0:length_tether;
locSpeed = angleSpeed .* distance;

% compute the centripetal acceleration as you go out
% toward the end of the tether, in m/s^2
accel = (locSpeed.^2)./distance;

% predetermined acceleration of the gondola, m/s^2
gond_accel = [(-0.01*ones(1,200000)) zeros(1,2306001) (0.01*ones(1,200000))];

% sum centripetal acceleration with translational acceleration
tot_accel_ms = accel + gond_accel; % in m/s^2
tot_accel_g = tot_accel_ms./9.81; % in g's

% plot
subplot(2, 1, 2)
plot(distance./1000, tot_accel_g, 'LineWidth', 3)
title('Acceleration Parallel to Direction of Motion', 'FontSize',18)
xlabel('Distance from Hub (km)','FontSize',16)
ylabel('Acceleration (g)','FontSize',16)
ax = gca;
ax.FontSize = 14;
grid

%% Velocity

% integrate the gondola's acceleration (not centripetal)
vel = cumtrapz(-gond_accel);
vel = vel./1000; % km/s
 
% Plot the translational velocity down the tether
subplot(2, 1, 1)
plot(distance./1000, vel, 'LineWidth', 3)
title('Velocity of Luna Gondola (Outbound Trip)','FontSize',18)
ylabel('Velocity (km/s)','FontSize',16)
ax = gca;
ax.FontSize = 14;
grid

time = 2706/mean(vel);
fprintf('Transit time is %.2f minutes.\n', time/60)
fprintf('Max velocity is %.2f km/s.\n', max(vel))