T_n_l = -210; %Lowest temp for N2
A_base = 580 * 10^-4;
A_tip = 110 * 10^-4;
r_base = sqrt(A_base/pi);
r_tip = sqrt(A_tip/pi);
r_mean = mean([r_base,r_tip]);

%% 100 meter-squared section
A = 100;
S_Heat_Flux = 1367.9;
Al = 420;
ir = 220;
Heat = (0.09*S_Heat_Flux + Al + ir) * A; %W
Tmax = 0;
T = -210;
c = 1.04; %J/gK
L = 2792.8; %J/mol
L = L/28.014;%J/g

m_dot = Heat/(c*(Tmax-T)+L); %g
m_dot = m_dot/1000000; %Mg

Surface_Area = 208000; %m^2 on One side
Total_m_dot = Surface_Area*m_dot/100 %Mg

M_needed = Total_m_dot * 1.72*3600 * 0.33; %Mg

