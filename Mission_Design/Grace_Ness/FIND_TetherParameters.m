%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Tether Sling%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 Code by: Grace Ness
%   Equations Source: Puig-Suari, J., Longuski, J. M., and Tragressor, S. G., "A Tether Sling for 
%   Lunar and Interplanetary Exploration," Acta Astronautica, Vol. 36, No. 6, 1995, pp. 291-296.
%
%   The goal of this function is to return design characteristics of a tapered
%   tether based on the given parameters...
%
%   INPUTS:
%   v = velocity [km/s]
%   rho = tether material density [kg/m^3]
%   UTS = tether material ultimate strength [kN/m^2]
%   Isp = Specific Impulse of rocket fuel for comparison [s]
%   a_max = maximum tip acceleration [g's]
%   PA = solar cell power per area [W/m^2]
%   mp = Mass of Payload (Taxi Vehicle) [Mg]
%   t = Spin-up Time [seconds]
%
%   OUTPUTS:
%   v_c = characteristic velocity [km/s]
%   v_non = non-dimensional velocity
%   MRprop = Mass ratio of propellant to payload
%   MRteth = Mass ratio of tether to payload
%   ER = Energy ratio
%   Amp = solar aray area per kg of payload [m^2/kg]
%   A = Solar cell aray area [km^2]
%   L = Length of the tether [km]
%   P = Power required [GW]
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [v_c,v_non,MRprop,MRteth,ER,Amp,A,L,P] = FIND_TetherParameters(v,rho,UTS,Isp,a_max,PA,mp,t)

g = 0.00980665;                                         %gravitational acceleration [km/s^2]
v_c = sqrt((2.*UTS)./rho);                              %characteristic velocity [km/s]
v_non = v./v_c;                                         %non-dimensional velcotiy
n = v_c./(Isp.*g);                                      %no physcial meaning
MRprop = exp(n.*v_non) - 1;                             %mass ratio of propellant mass to payload
MRteth = sqrt(pi).*v_non.*exp(v_non.^2).*erf(v_non);    %mass ratio of tether mass to payload
ER = MRteth./4;                                         %energy ratio
At_mp = ER.*(v_c.*1000).^2./PA;                         %intermediate term [m^2s/kg]
Amp = At_mp./t;                                         %solar aray area per kg of payload [m^2/kg]
A = Amp.*(mp.*1000);                                    %solar aray area [km^2] 
L = v.^2./(a_max.*g);                                   %tether length [km]
P = (ER.*((v_c.*1000).^2).*(1000.*mp))./(t*(10^9));     %Power required for spin-up [GW]

end