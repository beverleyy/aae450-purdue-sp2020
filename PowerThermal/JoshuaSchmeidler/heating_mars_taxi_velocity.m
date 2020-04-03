%% THIS CODE WAS WRITTEN BY JOSHUA SCHMEIDLER - POWER & THERMAL SUBTEAM

%% Varying Velocity
  
  %% Constants
    K = 1.896e-8;
    R_n = 2.5;
    h = 21287.4;
    V = 0:10000;
  %% Density Model
    if h < 7000
      T = -31-0.000998*h;
    else
      T = -23.4-0.00222*h;
    end
    p = 0.699*exp(-0.00009*h);
    rho = p/(0.1921*(T+273.1));
    
  %% Convective Heating Rate
    qc_dot = real(K*sqrt(rho/R_n)*(V.^3));
    
  %% Total Heating Rate
    q_dot = qc_dot;
    figure(1)
    plot(V*(10^-3),q_dot)
    grid on
    xlabel('Velocity (km/s)')
    ylabel('$\dot{q} (W/cm^2)$','Interpreter','latex')
    title('Total Heating Rate - Function of Velocity')
