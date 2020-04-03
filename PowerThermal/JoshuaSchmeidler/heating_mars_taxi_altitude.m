%% THIS CODE WAS WRITTEN BY JOSHUA SCHMEIDLER - POWER & THERMAL SUBTEAM

%% Varying Altitude
  
  %% Constants
    K = 1.896e-8;
    R_n = 2.5;
    h = 0:100e3;
  %% Calculations
    a = 1;
    qc_dot = zeros(10,100001);
    for V = 1000:1000:10000
      b = 1;
      while b <= length(h)
        %% Density Model
        if h(b) < 7000
          T(b) = -31-0.000998*h(b);
        else
          T(b) = -23.4-0.00222*h(b);
        end
        p(b) = 0.699*exp(-0.00009*h(b));
        rho(b) = p(b)/(0.1921*(T(b)+273.1));
        b = b+1;
      end
      %% Convective Heating Rate
      qc_dot(a,:) = real(K*sqrt(rho./R_n)*(V.^3));
      a = a+1;
    end
    
  %% Total Heating Rate
    q_dot = qc_dot;
    figure(1)
    plot(h*(10^-3),q_dot(1,:))
    grid on
    hold on
    plot(h*(10^-3),q_dot(2,:))
    plot(h*(10^-3),q_dot(3,:))
    plot(h*(10^-3),q_dot(4,:))
    plot(h*(10^-3),q_dot(5,:))
    plot(h*(10^-3),q_dot(6,:))
    plot(h*(10^-3),q_dot(7,:))
    plot(h*(10^-3),q_dot(8,:))
    plot(h*(10^-3),q_dot(9,:))
    plot(h*(10^-3),q_dot(10,:))
    xlabel('Altitude (km)')
    ylabel('$\dot{q} (W/cm^2)$','Interpreter','latex')
    title('Total Heating Rate - Function of Altitude')
    legend('V = 1 km/s','V = 2 km/s','V = 3 km/s','V = 4 km/s','V = 5 km/s','V = 6 km/s','V = 7 km/s','V = 8 km/s','V = 9 km/s','V = 10 km/s','Location','Best')
