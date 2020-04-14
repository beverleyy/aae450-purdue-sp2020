clear all
AAE450_ConstantInit;

day = Earth.Side

longMargin = 5;

[DV,a,aManeuver,orbvel,vApoManeuver,catchUpTime] = AAE450_StationKeepingDV(Earth.GM, day,longMargin)

DCM = [cosd(2*longMargin), sind(2*longMargin), 0; -sind(2*longMargin), cosd(2*longMargin), 0;0,0,1];

r1_targ = [a,0,0]*DCM
v1_targ = [0, orbvel, 0]*DCM

r1 = [aManeuver, 0,0];
v1 = [0 vApoManeuver, 0];

t = [0, catchUpTime];
opts = odeset('RelTol', 1e-10, 'AbsTol', 1e-10)
[t, z1] = ode45('cartgravity', t, [r1(1) v1(1) r1(2) v1(2) r1(3) v1(3)],opts);
[t_targ, z1_targ] = ode45('cartgravity', t, [r1_targ(1) v1_targ(1) r1_targ(2) v1_targ(2) r1_targ(3) v1_targ(3)],opts);

figure
plot_Earth(100, 1200)
hold on
plot3(z1(:,1),z1(:,3),z1(:,5))
plot3(z1_targ(:,1),z1_targ(:,3),z1_targ(:,5))
axis([-50000 50000 -50000 50000 -10000 10000])
title('Catch-Up Maneuver')
xlabel('[km]')
ylabel('[km]')
zlabel('[km]')
