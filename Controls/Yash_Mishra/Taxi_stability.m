clc
clear
tspan = [0:0.01:2];

gamma0 = 8;
spin = 50;
w10 = 0;
w20 = spin;
w30 = 0;
e10 = sind(gamma0/2);
e20 = 0;
e30 = 0;
e40 = cosd(gamma0/2);
K_0 = 1;

vec = [w10,w20,w30,e10,e20,e30,e40];
[v,vecdot] = ode45(@EoMs,tspan,vec);

w1 = vecdot(:,1);
w2 = vecdot(:,2);
w3 = vecdot(:,3);
e1 = vecdot(:,4);
e2 = vecdot(:,5);
e3 = vecdot(:,6);
e4 = vecdot(:,7);
K = (e1.^2 + e2.^2 + e3.^2 + e4.^2).^0.5;
dK = K - K_0;
gamma = acosd(1-2*e3.^2-2*e1.^2);

figure(1)
plot(v,gamma)
xlabel("v (Number of revolutions)")
ylabel("\gamma (deg)")
title("Time(v) history of nutation angle")