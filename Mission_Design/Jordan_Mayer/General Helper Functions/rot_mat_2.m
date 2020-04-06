%%%%%
% Generate rotation matrix for rotation about 2nd (y) axis.
%
% Inputs:
%   theta: rotation angle, rad
%
% Outputs:
%   R2: rotation matrix, to be used in the format of
%       r_prime = R2*r, where r is a 3-element column vector
%
% Author: Jordan Mayer
% Created: 10/01/2019
% Last Modified: 01/29/2020
%%%%%

function R2 = rot_mat_2(theta)
  R2 = [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];
end