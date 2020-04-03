%% Floor Space Calculations
function [theta,A_floor,t_wall] = FloorSpace
% Eli Sitchin
% January 2020
% AAE 45000-001
% Purdue University
% This function calculates the arc (theta), floor area (A_floor), and
% minimum distance between the interior and exterior of the habitation
% module (t_wall), based on the given volumes and radii listed from lines
% 14-18. Calculations Assume that the habitation module will be separated 
% into four parts.

% All r variables are measured from the axis of rotation
r_ceil = 400; % Habitation Ceiling Radius (m)
r_floor = 402.5; % Habitation Floor Radius (m)
V_p = 10710; % Pressurized Volume (m^3)
V_hab = 4550; % Habitation Volume (m^3)
w_floor = 6; % Floor Width (m)

% Along-Track Habitation Cross-Sectional Area (m^2)
A_cross_hab = w_floor*(r_floor-r_ceil);
length_hab = (V_hab/4)/A_cross_hab; % Habitation Midpoint Length (m)
theta_hab = length_hab/((r_floor+r_ceil)/2);
% Floor Area for All Four Compartments(m^2)
A_floor = w_floor*4*(length_hab+(r_floor-r_ceil)/2*theta_hab); 

% Possible Distances Between Habitation Wall and Cycler Exterior (m)
t = 0:0.1:3; 
% Possible Angle Taken by the Cycler (rad)
theta = (length_hab+2*t)./r_floor;
% Along-Track Cross-Sectional Area (m^2)
A_cross = (w_floor+2*t).*((r_floor+t)-(r_ceil-t));
length = length_hab + 2*t; % Cycler Length (m)
V = length.*A_cross; % Total Possible Pressurized Volume per Module (m^3)
for i = 1:size(t,2)
    if V(i) >= V_p/4
        % Minimum Possible Distance Between Habitation Wall and Cycler
        % Exterior (m) Times Safety Factor 1.2
        t_wall = t(i)*1.2; 
        % Angle Taken by the Cycler (deg)
        theta = (length_hab+2*t_wall)./r_floor*180/pi; 
        break;
    end
end