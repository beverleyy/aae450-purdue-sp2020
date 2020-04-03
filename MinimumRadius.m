%% Minimum Radius
% Eli Sitchin
% January 2020
% AAE 45000-001
% Purdue University
% This script determines the minimum acceptable radius at the ceiling for a
% rotating habitation module designed to provide 1 g of acceleration.

r = 1:0.1:500; % Radius (m)
a = 9.80665; % g (m/s^2)
v = sqrt(a*r); % Rotational Velocity (m/s)
dadr = v.^2./r.^2; % Delta Acceleration per Delta Radial Distance (1/s^2)
omega = v./(2*pi*r); % Rotation Rate (rev/s)

figure
plot(r,dadr,'r-')
grid on
hold on
plot(r,0.2942*ones(1,size(r,2)),'b-')
xlabel('Ceiling Radius (m)')
ylabel('Change in Gravity per Meter (1/s^2)')
title('Cycler Radius: Delta Gravity Considerations')
figure
plot(r,omega,'r-')
grid on
hold on
plot(r,0.05*ones(1,size(r,2)),'b-')
xlabel('Ceiling Radius (m)')
ylabel('Rotational Velocity (rps)')
title('Cycler Radius: Rotational Kinematics Considerations')