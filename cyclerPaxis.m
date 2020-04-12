function [x_dot] = cyclerPaxis(t,x,M,I)
%eulerPaxis puts Euler's equations for principal axis in state variable
%form
Ix = I(1,1);
Iy = I(2,2);
Iz = I(3,3);
x_dot(1) = M(1)/Ix-(Iz-Iy)/Ix*x(2)*x(3);
x_dot(2) = M(2)/Iy-(Ix-Iz)/Iy*x(1)*x(3);
x_dot(3) = M(3)/Iz-(Iy-Ix)/Iz*x(1)*x(2);
x_dot = x_dot';

end
