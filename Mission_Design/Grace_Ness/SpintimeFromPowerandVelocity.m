%%%Testing Power Supplied%%%
rho = 1560;  %[Spectra Zylon Kevlar HIM7]
UTS = 5800; %[Spectra Zylon Kevlar HIM7

P = [20 40 60 80 100];       %Power [GW]
v = linspace(0,5,1000);      %velocity [km/s]
Isp = 300;                   %specific impulse [s]
a_max = 1;                   %maximum acceleration [g's]
PA = 26;                     %solar cell power per area for Phobos [W/m^2]
mp = 188;                    %taxi mass [Mg]

g = 0.00981;                 %gravitational acceleration [km/s^2]
v_c = sqrt((2.*UTS)./rho);   %characteristic velocity [km/s]
v_non = v./v_c;              %non-dimensional velocities
MRteth = sqrt(pi).*v_non.*exp(v_non.^2).*erf(v_non); 
ER = MRteth./4;

t1 = (ER.*((v_c.*1000).^2).*(1000.*mp))./(P(1)*1000000);
t2 = (ER.*((v_c.*1000).^2).*(1000.*mp))./(P(2)*1000000);
t3 = (ER.*((v_c.*1000).^2).*(1000.*mp))./(P(3)*1000000);
t4 = (ER.*((v_c.*1000).^2).*(1000.*mp))./(P(4)*1000000);
t5 = (ER.*((v_c.*1000).^2).*(1000.*mp))./(P(5)*1000000);

%Velocity vs. Spin-up Time%
p1 = plot(t1./86400,v);
hold on
p2 = plot(t2./86400,v);
hold on
p3 = plot(t3./86400,v);
hold on
p4 = plot(t4./86400,v);
hold on
p5 = plot(t5./86400,v);
hold on
v1 = plot(t5,1.88*linspace(1,1,1000),'--');
hold on
v2 = plot(t5,3.12*linspace(1,1,1000),'--');
hold on
v3 = plot(t5,4.31*linspace(1,1,1000),'--');
title({'{\bf Velocity vs. Spin-up Time}';'{Material Used: Zylon}';'{Mass of Payload: 188 Mg}'},'FontWeight','Normal')
xlabel('Spin-up Time [days]')
ylabel('Velocity [km/s]')
grid on
grid minor
legend('P = 20 MW','P = 40 MW','P = 60 MW','P = 80 MW','P = 100 MW')
axis([0 2.5 0 5])




