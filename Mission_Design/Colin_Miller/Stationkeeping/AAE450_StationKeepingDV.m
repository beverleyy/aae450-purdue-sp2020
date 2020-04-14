%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Colin Miller
%
% Class: AAE450
%
% HW/Project: Comm Sats
%
% Description: Stationkeeping Catch-Up Maneuver
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [DV,a,aManeuver,orbvel,vApoManeuver, catchUpTime] = AAE450_StationKeepingDV(mu, day, longMargin);

% takes in  gravitationaly parameter of body and length of
% day of body, and longitudinal bounding in one direction, retuns deltaV in
% km/s, SMA in km before maneuve, SMA in km during maneuver

% code written with km, s, kg, and degrees

a = (mu*day^2/(4*pi^2))^(1/3) % semi-major axis
orbvel = sqrt(mu/a) % orbital velocity

catchUpTime = (2*pi - 2*longMargin*pi/180)/(2*pi/day)
aManeuver = (catchUpTime^2*mu/(4*pi^2))^(1/3)
energyManeuver = -mu/(2*aManeuver)
vApoManeuver = sqrt(2*mu/a+2*energyManeuver)
DV = orbvel-vApoManeuver;