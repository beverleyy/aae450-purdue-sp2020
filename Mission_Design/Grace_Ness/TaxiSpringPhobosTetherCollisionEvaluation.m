
%Constants
v = 3.7051;                     %velocity [km/s]
rho = 970;                      %density of the tether [kg/m^3]
UTS = 3325;                     %ultimate strength of tether material [kN/m^2]
a_max = 2;                      %maximum acceleration [g's]
g = 0.00980665;                 %gravitaional constanst [km/s^2]
m_taxi = 100*1000;              %taxi mass [kg]

%Function FINDteth
[v_c,v_non,~,MRteth,ER,~,~,L_OG,~] = FINDtether(v,rho,UTS,1,a_max,1,m_taxi,1);

%Case A. Pre-spun up
m_teth = MRteth*m_taxi;         %Mass of tether based on mass ratio [Mg]
M = m_taxi + m_teth;            %Mass of tether and taxi connected [Mg]
deltaV = v;                     %Max delta V [km/s]
v_taxi = 0;                     %Initial velocity of the taxi [km/s]
v_teth = (M*deltaV - (m_taxi*v_taxi))/m_teth; %Initial v of tether [km/s]
L = v_teth^2/(a_max*g);         %Reqired Tether length [km]

%Spring
F_spring = m_taxi*(g);          %Force of the spring with 1 g acc [kN]
KE = (0.5*m_teth*((v_teth*1000)^2)); %Tether kinetic energy [J]
KE_collision = 0.5*(m_teth+m_taxi)*((deltaV*1000)^2); %Total kinetic energy [J]
E_sp = KE - KE_collision;       %Spring Potential energy
x = ((2*E_sp)/F_spring);        %Spring Displacement [m]
k = F_spring/x;                 %Spring Constant [N/m]

%Case B. Comparison
XL = (x/1000)/L;                %Displacement to tether length ratio
P = 60;                         %Power provided on Phobos [GW]
t = (ER.*((v_c.*1000).^2).*(m_taxi))./(P*10^9); %Spin-up Time [s]
Spinup = t/3600;                %[hours]

