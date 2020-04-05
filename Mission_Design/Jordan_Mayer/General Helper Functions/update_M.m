%%%%%
% AAE 450: Spacecraft Design
%
% Compute mean anomaly from time change.
%
% Inputs:
%   M_0: initial mean anomaly, deg
%   n: mean motion, rad/s
%   delta_t: time since M_0, sec
%
% Outputs:
%   M: current mean anomaly, deg
%
% Author: Jordan Mayer (Mission Design)
% Created: 01/27/2020
% Last Modified: 01/27/2020
%%%%%

function [M] = update_M(M_0, n, delta_t)
  M = M_0 + rad2deg(n*delta_t);
end