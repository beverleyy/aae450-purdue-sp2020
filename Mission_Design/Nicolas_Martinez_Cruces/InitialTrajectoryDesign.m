%AAE 450 Week 2
%0029310180
%01/30/2020
clc
close all
clear all
            
%% Mars Simulations Constants
r_mars = 3389.5; %Radius (km)
mu_mars = 0.042828e6; %mu Mars (km3/s2) 
r_phobos = 11.267; %Radius (km) 
mu_phobos =  0.7127*10^(-3); %mu Phobos (km3/s2)  source:https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2009GL041829

%% Phobos Orbit Definition
orbit_time_phobos = 8*60*60 + 150;
phobos_r = [9517 0 0];
phobos_v = [0 2.138 0];
IC_phobos      = [phobos_r phobos_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_phobos, phobos_info]  = ode113(@dynamics, [0:0.1:orbit_time_phobos] , IC_phobos, options, mu_mars);

%% Payload Orbit Definition
orbit_time_pay = 3.5*60*60 + 1000;
pay_r = [-2183 -2325 1148];
ra = norm([5812 7612 0]);
rp = norm(pay_r);

a = 0.5*(ra + rp);
e = -1*(rp/a - 1);
n = sqrt(mu_mars / a^3);
time_req = (pi - e*(sin(pi))) / n;
v = sqrt(mu_mars*(2/rp - 1/a)) +0.2;
% dirt = [-2325+2075, -2183+2508, 0] % 1148-945.6]
% dirt = [-2484, -2055, 1047]
dirt = [-2554+2212, -1956+2316,1068-1175];
unit_dir = dirt ./ norm(dirt);
% angle_launch = acos(unit_dir(2)/unit_dir(1)) + 5*pi/180;
% unit_dir = [cos(angle_launch) sin(angle_launch) 0];
pay_v = -unit_dir .* v;

IC_pay = [pay_r pay_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_pay, pay_info]  = ode113(@dynamics, [0:0.1:4.0721e+03] , IC_pay, options, mu_mars);

distances =  pay_info(:,1:3);
ii_max = length(distances);
jj = 1;
for ii = 1:1:ii_max 
    mag_dist(ii) = norm(distances(ii,:));
    if (mag_dist(ii) >= 9515) && (mag_dist(ii) <= 9517)
        important_dist(jj) = mag_dist(ii);
        jj = jj + 1;
        burn_index = ii;
        time_burn = tt_pay(ii);
    end
end

phase1 = [tt_pay, pay_info];

pay_burn_v = pay_info(end,4:6);
phobos_burn_v = phobos_info(100,4:6);

burn_dir = [0.5533, 2.064, 0] - pay_burn_v;

ren_r = pay_info(end,1:3);
ren_v = pay_burn_v + burn_dir;
IC_ren = [ren_r ren_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_ren, ren_info]  = ode113(@dynamics, [0:0.1:orbit_time_pay] , IC_ren, options, mu_mars);


%% Plotting
set(groot,'defaultLineLineWidth',2.0)
plot3(phobos_info(:,1), phobos_info(:,2), phobos_info(:,3))
hold on
plot3(pay_info(:,1), pay_info(:,2), pay_info(:,3))
plot3(ren_info(:,1), ren_info(:,2), ren_info(:,3))
legend('Phobos Orbit','Payload Trajectory','After Burn Trajectory')

npts = 1000;
GMST0 = 0;
cdata = imread('martop.jpg');
RE_eq = 3389.5;
RE_pol = 3389.5;
[Earthx, Earthy, Earthz] = ellipsoid(0,0,0,RE_eq, RE_eq, RE_pol,npts);
C = [cosd(GMST0), -sind(GMST0), 0; sind(GMST0), cosd(GMST0), 0; 0,0,1];
Rotated = C*[Earthx(:)'; Earthy(:)'; Earthz(:)'];
Earthx = reshape(Rotated(1,:), npts+1, npts+1);
Earthy = reshape(Rotated(2,:), npts+1, npts+1);
Earthz = reshape(Rotated(3,:), npts+1, npts+1);
Gh = surf(Earthx, Earthy, -Earthz, 'FaceColor','texturemap', 'CData', cdata, 'EdgeColor','none');
cdata = imread('phobostop.jpg');
RE_eq = 11.267;
RE_pol = 11.267;
[Earthx, Earthy, Earthz] = ellipsoid(9517,0,0,RE_eq, RE_eq, RE_pol,npts);
C = [cosd(GMST0), -sind(GMST0), 0; sind(GMST0), cosd(GMST0), 0; 0,0,1];
Rotated = C*[Earthx(:)'; Earthy(:)'; Earthz(:)'];
Earthx = reshape(Rotated(1,:), npts+1, npts+1);
Earthy = reshape(Rotated(2,:), npts+1, npts+1);
Earthz = reshape(Rotated(3,:), npts+1, npts+1);


Gh = surf(Earthx, Earthy, -Earthz, 'FaceColor','texturemap', 'CData', cdata, 'EdgeColor','none');
axis equal
rotate3d on
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')


