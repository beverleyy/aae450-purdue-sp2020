%%%%%
% AAE 450: Spacecraft Design
%
% Compute orbital radius using orbit elements and true anomaly.
%
% Inputs:
%   p: semilatus rectum, km
%   e: eccentricity, dimensionliess
%   nu: true anomaly, deg
%
% Outputs:
%   r: orbital radius, km
%
% Author: Jordan Mayer (Mission Design)
% Created: 01/27/2020
% Last Modified: 01/27/2020
%%%%%

function [r] = r_from_nu(p, e, nu)
  r = p/(1 + e*cosd(nu));
end