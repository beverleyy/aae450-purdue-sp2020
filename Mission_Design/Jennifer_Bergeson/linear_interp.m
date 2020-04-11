function [x_vec, y_vec, z_vec, t_vec] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, initial_encounter, final_encounter, initial_rev_add, final_rev_add)

R1 = (encounter_pos_x(initial_encounter)^2 + encounter_pos_y(initial_encounter)^2 + encounter_pos_z(initial_encounter)^2)^.5;
R2 = (encounter_pos_x(final_encounter)^2 + encounter_pos_y(final_encounter)^2 + encounter_pos_z(final_encounter)^2)^.5;

theta1_nominal = atan(encounter_pos_y(initial_encounter)/encounter_pos_x(initial_encounter));
if theta1_nominal < 0 %deals with angle in fourth quadrant
    theta1_nominal = 2*pi + theta1_nominal;
end
if encounter_pos_y(initial_encounter)<0 & encounter_pos_x(initial_encounter)<0 %deals with angle in third quadrant
    theta1_nominal = theta1_nominal + pi;
end
if encounter_pos_x(initial_encounter)<0 & encounter_pos_y(initial_encounter)>0 %deals with angle in second quadrant
    theta1_nominal = theta1_nominal + pi;
end
theta1 = theta1_nominal + initial_rev_add*2*pi;
theta2_nominal = atan(encounter_pos_y(final_encounter)/encounter_pos_x(final_encounter));
if theta2_nominal < 0
    theta2_nominal = theta2_nominal + 2*pi;
end
if encounter_pos_y(final_encounter)<0 & encounter_pos_x(final_encounter)<0 %deals with angle in third quadrant
    theta2_nominal = theta2_nominal + pi;
end
if encounter_pos_x(final_encounter)<0 & encounter_pos_y(final_encounter)>0 %deals with angle in second quadrant
    theta2_nominal = theta2_nominal + pi;
end
theta2 = theta2_nominal + 2*pi*final_rev_add;

R_vec = linspace(R1, R2, 10000);
theta_vec = linspace(theta1, theta2, 10000);
x_vec = R_vec.*cos(theta_vec);
y_vec = R_vec.*sin(theta_vec);
z_vec = linspace(encounter_pos_z(initial_encounter), encounter_pos_z(final_encounter), 10000);
t_vec = linspace(encounter_time(initial_encounter), encounter_time(final_encounter), 10000);
end