function [dX] = dynamics(t,X,mu)
rx = X(1);
ry = X(2);
rz = X(3);
vx = X(4);
vy = X(5);
vz = X(6);
r  = sqrt(rx.^2+ry.^2+rz.^2);
dX(1,1) = vx;
dX(2,1) = vy;
dX(3,1) = vz;
dX(4,1) = -mu*rx/r.^3;
dX(5,1) = -mu*ry/r.^3;
dX(6,1) = -mu*rz/r.^3;
end