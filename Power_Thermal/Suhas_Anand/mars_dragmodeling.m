%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AAE 450 Program Description 
%	This script loads the Mars Entry Data and calculates the density for
%	re-entry, mass driver acceleration and the tether sling spin up. The
%	mass driver model uses a kinematics approach to model the drag on the
%	taxi. 
%
%   
%
% Author Information
%	Author:             Suhas Anand, anand24@purdue.edu
%  	Team :              Power and Thermal
%  	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Entry Data
  data = load('marsentrydata.txt');
  time = data(:,1);
  h = data(:,2)*1000;
  V = data(:,3)*1000;
%% Constants
  a = 1;
  K = 1.896e-8;
  R_n = 2.25;
  K1 = 3.33e-34;
  K2 = 1.22e-16;
  K3 = 3.07e-48;
  while a <= length(time)
    %% Density Model
    if h(a) < 7000
      T(a) = -31-0.000998*h(a);
    else
      T(a) = -23.4-0.00222*h(a);
    end
    p(a) = 0.699*exp(-0.00009*h(a));
    rho(a) = p(a)/(0.1921*(T(a)+273.1));
    %% Convective Heating Rate
    qc_dot(a) = real(K*sqrt(rho(a)/R_n)*(V(a)^3));
    a = a+1;
  end
%% Total Heating Rate
  q_dot = qc_dot;
  figure(1)
  plot(time,q_dot)
  grid on
  xlabel('Time (s)')
  ylabel('$\dot{q} (W/cm^2)$','Interpreter','latex')
  title('Total Heating Rate')
  cd = 0.295;
  D = cd.*rho.*0.5.*V'.^2*78.5398163397;
  a2 = 19.62;
  t = linspace(0,254.8419979613,1000);
  V2 = a2*t;  
  x = 0.5*a2.*t.^2;
  h2 = x*tan(deg2rad(3));
  i =1;
  while i <=length(t)
   if h2(i) < 7000
      T2(i) = -31-0.000998*h2(i);
   else
      T2(i) = -23.4-0.00222*h2(i);
   end
    p2(i) = 0.699*exp(-0.00009*h2(i));
    rho2(i) = p2(i)/(0.1921*(T2(i)+273.1));
  i = i+1;
  end
 
  D2 = cd.*rho2.*0.5.*V2.^2*78.5398163397;
%% Total Heating Load
  Q = trapz(time,q_dot);
  f_tps = 0.091*Q^0.51575;
  figure(2)
  plot(V,q_dot)
  xlabel('Velocity (m/s)')
  ylabel('$\dot{q} (W/cm^2)$','Interpreter','latex')
  
  figure(3)
  plot(h2,rho2)
  xlabel('Altitude')
  ylabel('Density')
  figure(4)
  plot(h2,V2)
  xlabel('Altitude')
  ylabel('Velocity')
  figure(5)
  plot(h2,D2)
  xlabel('Altitude')
  ylabel('Drag')
  
  x3 = linspace(0,700000,1000);
  A = 100e6/3.325e9 * 4000^2/700000 *exp(4000^2*0.0025/2/3.325e9*(1-x3.^2./(700000)^2));
  omega = 4000/700000;
  D3 = A.*0.5.*(omega.*x3).^2*0.0025*0.03;
  torque_D = D3.*x3;
  qc_dot = real(K*sqrt(0.0025/R_n)*((omega.*x3).^3));
  
  
