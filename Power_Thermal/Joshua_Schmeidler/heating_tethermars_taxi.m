%% THIS CODE WAS WRITTEN BY JOSHUA SCHMEIDLER - POWER & THERMAL SUBTEAM

%% Tether Sling Trajectory
  time = 0:0.1:7200;
  h = -2.9566*time+21287.4;
  V = -0.5556*time+4000;
  
%% Constants
  a = 1;
  K = 1.896e-8;
  R_n = 2.5;
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
  title('Total Heating Rate - Mars Tether Sling Spin-Down')
  
%% Total Heating Load
  Q = trapz(time_interp,q_dot);
  f_tps = 0.091*Q^0.51575;
  
%% TPS Sizing
 m_main = 3067.91*(1-(25/564.8));
 density = 144.16;
 t_main = 0.0635;
 w = 0.1524;
 l = 0.1524;
 V_sing_main = t_main*w*l;
 m_sing_main = density*V_sing_main;
 n_main = m_main/m_sing_main;
 m_bottom = 3067.91*(25/564.8);
 t_bottom = 0.03;
 V_sing_bottom = t_bottom*w*l;
 m_sing_bottom = density*V_sing_bottom;
 n_bottom = m_bottom/m_sing_bottom;
 n = n_bottom+n_main;
 V_tot = (V_sing_bottom*n_bottom)+(V_sing_main*n_main);
