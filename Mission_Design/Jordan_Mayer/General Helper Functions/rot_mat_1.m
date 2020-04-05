%%%%%
% Generate rotation matrix for rotation about 1st (x) axis.
%
% Inputs:
%   theta: rotation angle, rad
%
% Outputs:
%   R1: rotation matrix, to be used in the format of
%       r_prime = R1*r, where r is a 3-element column vector
%
% Author: Jordan Mayer
% Created: 10/01/2019
% Last Modified: 01/29/2020
%%%%%

function R1 = rot_mat_1(theta)
  R1 = [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];
end