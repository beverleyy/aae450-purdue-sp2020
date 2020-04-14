%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Colin Miller
%
% Class: AAE450
%
% HW/Project: Comm Sats
%
% Description: Calculates eclipse lengths at stationary orbit for given
% radisu of planet, gravitational parameter of planet, and length of day of
% planet
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [time] = AAE450_EclipseLengthStat(r, mu, day);

% takes in radius of body, gravitationaly parameter of body and length of
% day of body and returns time in eclipse

% code written with km, s, kg, and radians

a = (mu*day^2/(4*pi^2))^(1/3) % semi-major axis
halftheta = asin(r/a); % angles in radians
theta = 2*halftheta;
orbvel = sqrt(mu/a); % orbital velocity
arclength = a*theta; % length of curve in eclipse
time = arclength/orbvel;