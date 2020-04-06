%%%%%
% Determine angle between two vectors, with quadrant checks!
%
% Inputs:
%   r1, r2: two 3-element vectors (column or row, but must be consistent)
%
% Outputs:
%   theta: angle between r1 and r2 vectors, deg
%%%%%

function [theta] = angle_between(r1, r2)
  r1_dot_r2 = dot(r1, r2);
  r1_r2 = norm(r1)*norm(r2);
  r1_cross_r2 = norm(cross(r1, r2));
  
  theta1 = acosd(r1_dot_r2/r1_r2);
  theta2 = -theta1;  % cos(x) = cos(-x)
  theta3 = asind(r1_cross_r2/r1_r2);
  theta4 = 180 - theta3;  % sin(x) = sin(180 - x)
  
  theta1 = bound_180(theta1);
  theta2 = bound_180(theta2);
  theta3 = bound_180(theta3);
  theta4 = bound_180(theta4);
  
  wiggle = 0.00001;
  if abs(theta1 - theta3) < wiggle || abs(theta1 - theta4) < wiggle
    theta = theta1;
  elseif abs(theta2 - theta3) < wiggle || abs(theta2 - theta4) < wiggle
    theta = theta2;
  else
    fprintf('\ntheta1 = %.4f\n', theta1);
    fprintf('theta2 = %.4f\n', theta2);
    fprintf('theta3 = %.4f\n', theta3);
    fprintf('theta4 = %.4f\n', theta4);
    error('no consistent theta');
  end
end