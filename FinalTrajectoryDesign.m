%AAE 450 Week 2
%0029310180
%01/30/2020
clc
close all
clear all
format long 
%% Mars Simulations Constants
r_mars = 3389.5; %Radius (km)
mu_mars = 0.042828e6; %mu Mars (km3/s2) 
r_phobos = 11.267; %Radius (km) 
mu_phobos =  0.7127*10^(-3); %mu Phobos (km3/s2)  
%% Phobos Orbit Definition
orbit_time_phobos = 8*60*60 + 150;
phobos_r = [9517 0 0];
phobos_v = [0 2.138 0];
IC_phobos      = [phobos_r phobos_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_phobos, phobos_info]  = ode113(@dynamics, [0:0.1:orbit_time_phobos] , IC_phobos, options, mu_mars);
%% Payload Orbit Definition
orbit_time_pay = 9*60*60;
pay_r = [-2183 -2325 1148];
ra = norm([1.347e4 701.4 0]);
rp = norm(pay_r);
a = 0.5*(ra + rp);
e = -1*(rp/a - 1);
n = sqrt(mu_mars / a^3);
time_req = (pi - e*(sin(pi))) / n;
v = sqrt(mu_mars*(2/rp - 1/a)) +0.2
dirt = [-2554+2212, -1956+2316,1068-975];
unit_dir = dirt ./ norm(dirt);
pay_v = -unit_dir .* v
IC_pay = [pay_r pay_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_pay, pay_info]  = ode113(@dynamics, [0:0.1:2.2218e+04] , IC_pay, options, mu_mars);
ren_v = [-0.426304632839510,0.535422180154929,0.105530229536948];
ren_v = ren_v * 1.38;
ren_v(3) = ren_v(3)-0.4;
ren_r = [14910.9282549041,15731.7925962762,-7823.51035209936];
IC_ren = [ren_r ren_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_ren, ren_info]  = ode113(@dynamics, [0:0.1:3.0664e+04] , IC_ren, options, mu_mars);
fin_r = [-9575.08790759931,2028.88687231301,0.0272664185445564]
fin_v = [-0.437342549917996,-2.02575249756956,0]
IC_fin = [fin_r fin_v];
options = odeset('Reltol',2.22045e-14,'AbsTol',1e-15);
[tt_fin, fin_info]  = ode113(@dynamics, [0:0.1:round(orbit_time_pay/2)] , IC_fin, options, mu_mars);
%% Plotting
set(groot,'defaultLineLineWidth',2.0)
plot3(phobos_info(:,1), phobos_info(:,2), phobos_info(:,3))
hold on
plot3(pay_info(:,1), pay_info(:,2), pay_info(:,3),'m')
plot3(ren_info(:,1), ren_info(:,2), ren_info(:,3))
plot3(fin_info(:,1), fin_info(:,2), fin_info(:,3),'-.')
legend('Phobos Orbit','Launch','Burn 1','Burn 2')

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

first_burn = norm([-0.426304632839510,0.535422180154929,0.105530229536948]) - norm(ren_v);
second_burn = norm([0.515285070895321,-2.22639213962209,0.876798988166995]) - norm(fin_v);
total_delta_v = norm(first_burn) + norm(second_burn)
total_time = (2.2218e+04+3.0664e+04)/3600