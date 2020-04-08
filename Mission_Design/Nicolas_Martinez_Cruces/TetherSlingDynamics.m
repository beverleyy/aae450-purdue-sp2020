clc 
close all
clear all

%% Mars
%Initial Parameters 
l = 1400e3; %m (radius)
circ = 2*pi*l;
v = 5e3; %m/s
time = circ / v;

time_mars_elev = (l/150) / 3600

r = [0:0.1:l];
c_r = 2.*pi.*r;
v_r = c_r./time;

figure(1)
plot(r./1000,v_r./1000);
xlabel('Radius [km]')
ylabel('Velocity [km/s]')
title('R vs Velocity for Tether Sling')
grid on
grid minor

m = 10e3; %kg
F_r = m .* (v_r.^2) ./ r;

Gs = F_r ./ (m * 9.80556);

figure(3)
plot(r./1000,Gs);
xlabel('Radius [km]')
ylabel('G_s')
title('R vs G_s for Tether Sling')
grid on
grid minor

%% Moon
%Initial Parameters 
l = 1353e3; %m (radius)
circ = 2*pi*l;
v = 2.0e3; %m/s
time = circ / v;

time_moon_elev = (l/150) / 3600

r = [0:0.1:l];
c_r = 2.*pi.*r;
v_r = c_r./time;

figure(1)
hold on
plot(r./1000,v_r./1000);
legend('Mars',' Moon','Location','southeast')

m = 10e3; %kg
F_r = m .* (v_r.^2) ./ r;

Gs = F_r ./ (m * 9.80556);

figure(3)
hold on
plot(r./1000,Gs);
legend('Mars',' Moon','Location','southeast')

