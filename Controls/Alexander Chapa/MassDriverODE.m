function output = MassDriverODE(t,y)

fy = y(1);
fz = y(2);
I = y(3);

angle = 75;
mu_0 = 4*pi()*10^(-7);
Mag_den = .2*pi();
angle = 75;
length = 25;

mass = 31207*10^3+100*10^6;
dvneed = 4.77*10^3;
time = 4*60+14;
force = mass*dvneed/time;
%B = mu*I/(2pi())

dI = cos(2*pi()*t)*(force-fy)/force;
df = (force-fy)./force.*2.*length.*dI.*mu_0.*I./Mag_den.*[sind(angle),cos(angle)];
dfy = df(2);
dfz = df(1);
output = [dfy,dfz,dI]';






