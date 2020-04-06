%%%%%
% Bound angle between -180 and 180 degrees.
%
% Inputs:
%   theta: the angle, deg
%
% Outputs:
%   theta_bounded: the same angle, but now between -180 and 180 degrees
%%%%%

function [theta_bounded] = bound_180(theta)
  theta_bounded = theta;

  while theta_bounded > 180
    theta_bounded = theta_bounded - 360;
  end
  
  while theta_bounded < -180
    theta_bounded = theta_bounded + 360;
  end
end