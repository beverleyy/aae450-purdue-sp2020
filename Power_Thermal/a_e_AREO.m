sigma = 5.67*10^-8; %Stefan-Boltzmann Constant (W.m^-2.K^-4)
H_light = 604.2534; %W/m^2
H_dark = 0; %W/m^2
Input_Power = 3053.9;%Watts
Q_dot_diss = 0.75*Input_Power; %Watts
Q_heater = 0.0546*Input_Power
As_GEO = 6*3*3; %m^2

Tu = 45+273;
a_e_u_1 = Tu^4 * 2 * sigma / H_light

Tl = -10+273;
a_e_u_2 = Tl^4 * 2 * sigma / H_light

a_e = mean([a_e_u_1 a_e_u_2]);
epsilon = 0.18;
alpha = epsilon * a_e;


T_upper = (((H_light * alpha * As_GEO/2) + Q_dot_diss) / (sigma * epsilon * As_GEO))^(1/4)
T_lower = (((H_dark * alpha * As_GEO/2) + Q_dot_diss + Q_heater) / (sigma * epsilon * As_GEO))^(1/4)





t = linspace(1,24,480);
Flux = [H_light * ones(1,57),H_dark * ones(1,23), H_light * ones(1,400)];
figure(1)
plot(t,Flux)
title('Heat Flux due to Solar Incidence')
xlabel('Orbit Time (Hours)')
ylabel('Heat Flux (W/m^2)')

Temps = [T_upper * ones(1,57),T_lower * ones(1,23), T_upper * ones(1,400)];
xerooo = 273*ones(1,480);
figure(1)
plot(t,Temps)
hold on
plot(t,xerooo)
title('Temperature of the body at GEO')
xlabel('Orbit Time (Hours)')
ylabel('Temperature (K)')


