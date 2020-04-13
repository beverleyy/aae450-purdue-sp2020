%%%%%%%%%%%%%%%%%%%%%%% Spin-up/down Times function %%%%%%%%%%%%%%%%%%%%%%%
%   INPUTS:                                                               %
%   v = velocity [km/s]                                                   %
%   rho = tether material density [kg/m^3]                                %
%   UTS = tether material ultimate strength [kN/m^2]                      %
%   t = time [seconds]                                                    %
%   mp = Mass of Payload (Taxi Vehicle) [kg]                              %
%                                                                         %
%   OUTPUTS:                                                              %
%   P = Power [Watts]                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [P] = FIND_Power(v,rho,UTS,mp,t)

v_c = sqrt((2.*UTS)./rho);                              %characteristic velocity [km/s]
v_non = v./v_c;                                         %non-dimensional velcotiy
MRteth = sqrt(pi).*v_non.*exp(v_non.^2).*erf(v_non);    %mass ratio of tether to payload
ER = MRteth./4;                                         %energy ratio
P = (ER.*((v_c.*(10^3)).^2).*(mp))./t; 

end