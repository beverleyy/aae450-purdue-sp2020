%%%%%
% AAE 450: Spacecraft Design
%
% Compute true anomaly based on mean anomaly and orbit eccentricity.
%
% Inputs:
%   e: orbit eccentricity, dimensionless
%   M: mean anomaly,deg
%
% Outputs:
%   nu: true anomaly,deg
%
% Author: Jordan Mayer (Mission Design)
% Created: 01/27/2020
% Last Modified: 01/27/2020
%%%%%

function [nu] = nu_from_M(e, M)
  % Solve iteratively for eccentric anomaly
  E_candidates = 0.0:0.01:360;
    % candidates for eccentric anomaly, deg
  E = -1;  % to hold actual eccentric anomaly, deg
  for E_cand = E_candidates
    M_cand = E_cand - e*sind(E_cand);
      % mean anomaly resulting from E = E_cand
    if abs(M_cand - M) < 0.01  % if M_cand close to M
      E = E_cand;
      break;
    end
  end
  if E == -1  % no eccentric anomalyfound
    error('\nNo eccentric anomaly found\n');
  end
  
  tau_E = tand(E/2);
  tau_nu = sqrt((1+e)/(1-e))*tau_E;
  nu = 2*atand(tau_nu);  % true anomaly, deg
end