%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Colin Miller
%
% Class: AAE450
%
% HW/Project: Calculates max distance from sun to cycler
%
% Description: 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('Trajectory_Information.mat') % import more info
pos = Trajectory.Vehicle1.position;

for ii = 1:length(pos)
    posmag(ii) = norm(pos(ii,:)); % get magnitude of each position vector
end
maxd = max(posmag); % get max distance (AU because Rob Potter)