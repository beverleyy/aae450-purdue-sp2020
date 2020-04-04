function D2beta = odeBeta(u)
% Beta Differential equation 
%   u(1) = beta
%   u(2) = d/dt (beta)
%   u(3) = alpha 
%   u(4) = d/dt (alpha)

D2beta = -sin(u(1))*cos(u(1))*(Dtheta - u(4))^2 
-r_hub*Dtheta^2*cos(u(3))*sin(u(1))/lt 
-g_mars*cos(u(1))/lt
+2*omega*cos(phi)*cos(u(1))^2*(Dtheta-u(4))*(sin(Dtheta*t)*sin(u(3))+cos(Dtheta*t)*cos(u(3)))
-2*omega*sin(phi)*sin(u(1))*cos(u(1))*(Dtheta-u(4))
+2*r_hub*omega*Dtheta*cos(Dtheta*t)*cos(phi)*cos(u(1))/lt
-2*r_hub*omega*Dtheta*sin(phi)*cos(u(3))*sin(u(1))/lt;

end

