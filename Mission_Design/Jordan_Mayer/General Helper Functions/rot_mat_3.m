%%%%%
% Generate rotation matrix for rotation about 3rd (z) axis.
%
% Inputs:
%   theta: rotation angle, rad
%
% Outputs:
%   R3: rotation matrix, to be used in the format of
%       r_prime = R3*r, where r is a 3-element column vector
%
% Author: Jordan Mayer
% Created: 10/01/2019
% Last Modified: 01/29/2020
%%%%%

function R3 = rot_mat_3(theta)
  R3 = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
end