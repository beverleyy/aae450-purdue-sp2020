clearvars
clc

TOF = 3*24*3600;    %seconds
mu_earth = 398600.4415; %(km^3/s^2) gravitational parameter of Earth
mu_mars = 42828.3143;   %(km^3/s^2) gravitational parameter of Mars
r_earth = 6378.136;     %(km) mean equatorial radius of Earth
r_mars = 3397.00;       %(km) mean equatorial radius of Mars
alt_LEO = 1000;         %(km) altitude of low Earth orbit
alt_LMO = 1000;         %(km) altitude of low Mars orbit

%max_v_inf_earth = 6;    %(km/s) maximum v_infinity of all cyclers flyby of Earth
max_v_inf_earth = 5.27; %this value is used for average scenario
%max_v_inf_mars = 5;     %(km/s) maximum v_infinity of all cyclers flyby of Mars
max_v_inf_mars = 3.94;  %this value is used for average scenario

r_LEO = alt_LEO + r_earth;  %(km) r of LEO
r_LMO = alt_LMO + r_mars;   %(km) r of LMO

v_LEO = (mu_earth/r_LEO)^.5;    %(km/s) velocity of taxi in LEO
v_LMO = (mu_mars/r_LMO)^.5;     %(km/s) velocity of taxi in LMO

v_p_earth = (2*(max_v_inf_earth^2/2 + mu_earth/r_LEO))^.5;  %(km/s) velocity of taxi at periapsis on intercept hyperbola near Earth
v_p_mars = (2*(max_v_inf_mars^2/2 + mu_mars/r_LMO))^.5;     %(km/s) velocity of taxi at periapsis on intercept hyperbola near Mars

%% outbound delta v 
r_p_min_mars_cycler = 1000 + r_mars;    %(km) periapsis radius to use for hyperbolic anomaly calculation of cycler orbit
outbound_dv_earth = v_p_earth - v_LEO;  %(km/s) delta v spent near earth on outgoing taxi

abs_a_mars_cycler = mu_mars/max_v_inf_mars^2;   %(km)
ecc_mars_cycler = r_p_min_mars_cycler/abs_a_mars_cycler + 1;    %(unitless)
N_mars_cycler = (mu_mars/abs_a_mars_cycler^3)^.5 * TOF;

%{
H_plot = linspace(0, 2*pi, 3601);
N_plot = ecc_mars_cycler*sinh(H_plot) - H_plot;
figure(1)
plot(N_plot, H_plot)
xlabel('Mean Anomaly')
ylabel('Hyperbolic Anomaly')
title('Figure 1: Graphical Solution of Hyperbolic Anomaly, Jennifer Bergeson')
%}
H_start = 6.0584;
[H_mars_cycler, iter] = hyperbolic_fcn(H_start, N_mars_cycler, 1e-5, ecc_mars_cycler);
r_guess_mars = abs_a_mars_cycler*(ecc_mars_cycler*cosh(H_mars_cycler) - 1); %(km) starting point for separation r near Mars
%r_guess_mars = 1.3088e+6;   %used for maximum v_inf scenario
r_guess_mars = .9730e+6;   %used for average v_inf scenario

v_cycler_mars = (2*(max_v_inf_mars^2 / 2 + mu_mars/r_guess_mars))^.5;
v_transfer_mars = v_cycler_mars - 1;
abs_a_transfer_mars = mu_mars/(v_transfer_mars^2 - 2*mu_mars/r_guess_mars);
ecc_transfer_mars = r_p_min_mars_cycler/abs_a_transfer_mars + 1;
H_transfer_mars = acosh((r_guess_mars/abs_a_transfer_mars + 1)/ecc_transfer_mars);
TOF_mars = ((ecc_transfer_mars*sinh(H_transfer_mars) - H_transfer_mars)/(mu_mars/abs_a_transfer_mars^3)^.5)/(3600*24)

v_p_transfer_mars = (2*(mu_mars/(2*abs_a_transfer_mars) + mu_mars/r_p_min_mars_cycler))^.5;
outbound_dv2_mars = v_p_transfer_mars - v_LMO;
outbound_dv_mars = outbound_dv2_mars + 1;

%% inbound delta v
TOF = 3*24*3600;    %seconds
r_p_min_earth_cycler = 1000 + r_earth;
inbound_dv_mars = v_p_mars - v_LMO;    %(km/s) delta v spent near mars on incoming taxi

abs_a_earth_cycler = mu_earth/max_v_inf_earth^2;
ecc_earth_cycler = r_p_min_earth_cycler/abs_a_earth_cycler + 1;
N_earth_cycler = (mu_earth/abs_a_earth_cycler^3)^.5*TOF;

ecc_earth_cycler = r_p_min_earth_cycler/abs_a_earth_cycler + 1;    %(unitless)
N_earth_cycler = (mu_earth/abs_a_earth_cycler^3)^.5 * TOF;

%{
H_plot = linspace(0, 2*pi, 3601);
N_plot = ecc_earth_cycler*sinh(H_plot) - H_plot;
figure(2)
plot(N_plot, H_plot)
xlabel('Mean Anomaly')
ylabel('Hyperbolic Anomaly')
title('Figure 2: Graphical Solution of Hyperbolic Anomaly, Jennifer Bergeson')
%}
H_start = 5.164;
[H_earth_cycler, iter] = hyperbolic_fcn(H_start, N_earth_cycler, 1e-5, ecc_earth_cycler);
r_guess_earth = abs_a_earth_cycler*(ecc_earth_cycler*cosh(H_earth_cycler) - 1); %(km) starting point for separation r near Earth
%r_guess_earth = 1.6814e+6;  %used for maximum v_inf scenario
r_guess_earth = 1.4594e+6;  %used for average v_inf scenario

v_cycler_earth = (2*(max_v_inf_earth^2 / 2 + mu_earth/r_guess_earth))^.5;
v_transfer_earth = v_cycler_earth - 1;
abs_a_transfer_earth = mu_earth/(v_transfer_earth^2 - 2*mu_earth/r_guess_earth);
ecc_transfer_earth = r_p_min_earth_cycler/abs_a_transfer_earth + 1;
H_transfer_earth = acosh((r_guess_earth/abs_a_transfer_earth + 1)/ecc_transfer_earth);
TOF_earth = ((ecc_transfer_earth*sinh(H_transfer_earth) - H_transfer_earth)/(mu_earth/abs_a_transfer_earth^3)^.5)/(3600*24)

v_p_transfer_earth = (2*(mu_earth/(2*abs_a_transfer_earth) + mu_earth/r_p_min_earth_cycler))^.5;
inbound_dv2_earth = v_p_transfer_earth - v_LEO;
inbound_dv_earth = inbound_dv2_earth + 1;