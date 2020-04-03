%% THIS CODE WAS WRITTEN BY JOSHUA SCHMEIDLER - POWER & THERMAL SUBTEAM

%% Mass Driver Trajectory
  h = 21287.4:0.1:100e3;
  V = 5152.1;
  
%% Constants
  a = 1;
  K = 1.896e-8;
  R_n = 2.5;
  while a <= length(h)
    %% Density Model
    if h(a) < 7000
      T(a) = -31-0.000998*h(a);
    else
      T(a) = -23.4-0.00222*h(a);
    end
    p(a) = 0.699*exp(-0.00009*h(a));
    rho(a) = p(a)/(0.1921*(T(a)+273.1));
    %% Convective Heating Rate
    qc_dot(a) = real(K*sqrt(rho(a)/R_n)*(V^3));
    a = a+1;
  end
  
%% Total Heating Rate
  q_dot = qc_dot;
  figure(1)
  plot(h*(10^-3),q_dot)
  grid on
  xlabel('Altitude (km)')
  ylabel('$\dot{q} (W/cm^2)$','Interpreter','latex')
  title('Total Heating Rate - Mass Driver Launch')