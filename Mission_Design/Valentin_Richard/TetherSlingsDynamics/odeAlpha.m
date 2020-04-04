function D2alpha = odeAlpha(u)
% Alpha Differential equation
%   u(1) = beta
%   u(2) = d/dt (beta)
%   u(3) = alpha 
%   u(4) = d/dt (alpha)

D2alpha = -2*u(2)*tan(u(1))*(Dtheta-u(4)) 
- r_hub*Dtheta^2*sin(u(3))/lt/cos(u(1))
+ 2*omega*cos(phi)*u(2)*(sin(Dtheta*t)*sin(u(3)) * cos(Dtheta*t)*cos(u(3)))
- 2*omega*sin(phi)*u(2)*tan(u(1))
- 2*r_hub*Dtheta*omega*sin(phi)*sin(u(3))/lt/cos(u(1));

end
