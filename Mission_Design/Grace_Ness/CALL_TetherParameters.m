%%%%%%%%%%%%%%%%%%%%%%%%Part One - From Research Paper%%%%%%%%%%%%%%%%%%%%%
%%%                           Author: Grace Ness                        %%%
%%%                      FINDtether calling function                    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%Material: Kevlar                    
%%%%Transfer: Phobos to Earth/Cycler/Mars 
%%%%Spin-up Time: 10 days               
%%%%Maximum Acceleration: 5 G's  
%I. Parameters
v1 = linspace(0,5,1000);    %velocity [km/s]
rho1 = 1450;                %density of the tether [kg/m^3]
UTS1 = 2800;                %ultimate strength of tether material [kN/m^2]
Isp1 = 300;                 %specific impulse [s]
a_max1 = 5;                 %maximum acceleration [g's]
PA1 = 26;                   %solar cell power per area for Phobos [W/m^2]
mp1 = 11.2;                 %taxi mass [Mg]
t1 = 10*86400;              %spin-up time [s]
%II. Call Function
[v_c1,v_non1,MRprop1,MRteth1,ER1,Amp1,A1,L1,P1] = FIND_TetherParameters(v1,rho1,UTS1,Isp1,a_max1,PA1,mp1,t1);

%%%%%%%%%%%%%%%%%%%%%%%%Part Two - Max Acceleration%%%%%%%%%%%%%%%%%%%%%%%%

a_max2 = 2.5; %maximum acceleration [g's]
[~,~,~,~,~,~,~,L2,~] = FIND_TetherParameters(v1,rho1,UTS1,Isp1,a_max2,PA1,mp1,t1);
a_max3 = 1; %maximum acceleration [g's]
[~,~,~,~,~,~,~,L3,~] = FIND_TetherParameters(v1,rho1,UTS1,Isp1,a_max3,PA1,mp1,t1);

%%%%%%%%%%%%%%%%%%%%%%%%Part Three - Spin-up Time%%%%%%%%%%%%%%%%%%%%%%%%%%

v2 = 1.88;
t2 = 86400.*linspace(0,20,1000);
[~,~,~,~,~,Amp2,~,~,~] = FIND_TetherParameters(v2,rho1,UTS1,Isp1,a_max1,PA1,mp1,t2);
v3 = 3.12;
[~,~,~,~,~,Amp3,~,~,~] = FIND_TetherParameters(v3,rho1,UTS1,Isp1,a_max1,PA1,mp1,t2);
v4 = 4.31;
[~,~,~,~,~,Amp4,~,~,~] = FIND_TetherParameters(v4,rho1,UTS1,Isp1,a_max1,PA1,mp1,t2);

%RESULTS
%I. Plots

figure(1)
plot(v1,L1)
hold on
plot(v1,L2)
hold on
plot(v1,L3)
title('Tether Length vs. Velocity')
xlabel('End Point Velocity [km/s]')
ylabel('Length of Tether [km]')
grid on
grid minor
legend('Max Acceleration = 5 G''s','Max Acceleration = 2.5 G''s','Max Acceleration = 1 G')
axis([0 5 0 2000])

figure(2)
plot(t2./86400,Amp2)
hold on
plot(t2./86400,Amp3)
hold on
plot(t2./86400,Amp4)
title('Solar Aray Area per kg of Payload vs. Spin-up Time')
xlabel('Spin-up Time [days]')
ylabel('Solar Aray Area per kg of Payload [m^2/kg]')
grid on
grid minor
legend('v = 1.88 km/s','v = 3.12 km/s','v = 4.31 km/s')
axis([0 12 0 60])


