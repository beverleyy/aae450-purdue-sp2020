format long
clc

%% Set up data
load Trajectory_Information.mat
cycler1_time = Trajectory.Vehicle1.julian_date;
cycler2_time = Trajectory.Vehicle2.julian_date;
cycler3_time = Trajectory.Vehicle3.julian_date;
cycler4_time = Trajectory.Vehicle4.julian_date;

cycler1_pos_x = Trajectory.Vehicle1.position(:, 1);
cycler2_pos_x = Trajectory.Vehicle2.position(:, 1);
cycler3_pos_x = Trajectory.Vehicle3.position(:, 1);
cycler4_pos_x = Trajectory.Vehicle4.position(:, 1);

cycler1_pos_y = Trajectory.Vehicle1.position(:, 2);
cycler2_pos_y = Trajectory.Vehicle2.position(:, 2);
cycler3_pos_y = Trajectory.Vehicle3.position(:, 2);
cycler4_pos_y = Trajectory.Vehicle4.position(:, 2);

cycler1_pos_z = Trajectory.Vehicle1.position(:, 3);
cycler2_pos_z = Trajectory.Vehicle2.position(:, 3);
cycler3_pos_z = Trajectory.Vehicle3.position(:, 3);
cycler4_pos_z = Trajectory.Vehicle4.position(:, 3);

index = [1 (2:2:49) 50];

cycler1_encounter_pos_x = Trajectory.Vehicle1.body_encounters(index, 1);
cycler2_encounter_pos_x = Trajectory.Vehicle2.body_encounters(index, 1);
cycler3_encounter_pos_x = Trajectory.Vehicle3.body_encounters(index, 1);
cycler4_encounter_pos_x = Trajectory.Vehicle4.body_encounters(index, 1);

cycler1_encounter_pos_y = Trajectory.Vehicle1.body_encounters(index, 2);
cycler2_encounter_pos_y = Trajectory.Vehicle2.body_encounters(index, 2);
cycler3_encounter_pos_y = Trajectory.Vehicle3.body_encounters(index, 2);
cycler4_encounter_pos_y = Trajectory.Vehicle4.body_encounters(index, 2);

cycler1_encounter_pos_z = Trajectory.Vehicle1.body_encounters(index, 3);
cycler2_encounter_pos_z = Trajectory.Vehicle2.body_encounters(index, 3);
cycler3_encounter_pos_z = Trajectory.Vehicle3.body_encounters(index, 3);
cycler4_encounter_pos_z = Trajectory.Vehicle4.body_encounters(index, 3);

cycler1_thrust_pos_x_all = Trajectory.Vehicle1.thrust(:, 1);
cycler2_thrust_pos_x_all = Trajectory.Vehicle2.thrust(:, 1);
cycler3_thrust_pos_x_all = Trajectory.Vehicle3.thrust(:, 1);
cycler4_thrust_pos_x_all = Trajectory.Vehicle4.thrust(:, 1);

cycler1_thrust_pos_y_all = Trajectory.Vehicle1.thrust(:, 2);
cycler2_thrust_pos_y_all = Trajectory.Vehicle2.thrust(:, 2);
cycler3_thrust_pos_y_all = Trajectory.Vehicle3.thrust(:, 2);
cycler4_thrust_pos_y_all = Trajectory.Vehicle4.thrust(:, 2);

cycler1_thrust_pos_z_all = Trajectory.Vehicle1.thrust(:, 3);
cycler2_thrust_pos_z_all = Trajectory.Vehicle2.thrust(:, 3);
cycler3_thrust_pos_z_all = Trajectory.Vehicle3.thrust(:, 3);
cycler4_thrust_pos_z_all = Trajectory.Vehicle4.thrust(:, 3);

cycler1_thrust_power_x_all = Trajectory.Vehicle1.thrust(:, 4)*149597870;
cycler2_thrust_power_x_all = Trajectory.Vehicle2.thrust(:, 4)*149597870;
cycler3_thrust_power_x_all = Trajectory.Vehicle3.thrust(:, 4)*149597870;
cycler4_thrust_power_x_all = Trajectory.Vehicle4.thrust(:, 4)*149597870;

cycler1_thrust_power_y_all = Trajectory.Vehicle1.thrust(:, 5)*149597870;
cycler2_thrust_power_y_all = Trajectory.Vehicle2.thrust(:, 5)*149597870;
cycler3_thrust_power_y_all = Trajectory.Vehicle3.thrust(:, 5)*149597870;
cycler4_thrust_power_y_all = Trajectory.Vehicle4.thrust(:, 5)*149597870;

cycler1_thrust_power_z_all = Trajectory.Vehicle1.thrust(:, 6)*149597870;
cycler2_thrust_power_z_all = Trajectory.Vehicle2.thrust(:, 6)*149597870;
cycler3_thrust_power_z_all = Trajectory.Vehicle3.thrust(:, 6)*149597870;
cycler4_thrust_power_z_all = Trajectory.Vehicle4.thrust(:, 6)*149597870;
int = 1;
j1 = 1;
cycler1_thrust_power_x = [];
cycler1_thrust_power_y = [];
cycler1_thrust_power_z = [];
cycler1_thrust_pos_x = [];
cycler1_thrust_pos_y = [];
cycler1_thrust_pos_z = [];
j2 = 1;
cycler2_thrust_power_x = [];
cycler2_thrust_power_y = [];
cycler2_thrust_power_z = [];
cycler2_thrust_pos_x = [];
cycler2_thrust_pos_y = [];
cycler2_thrust_pos_z = [];
j3 = 1;
cycler3_thrust_power_x = [];
cycler3_thrust_power_y = [];
cycler3_thrust_power_z = [];
cycler3_thrust_pos_x = [];
cycler3_thrust_pos_y = [];
cycler3_thrust_pos_z = [];
j4 = 1;
cycler4_thrust_power_x = [];
cycler4_thrust_power_y = [];
cycler4_thrust_power_z = [];
cycler4_thrust_pos_x = [];
cycler4_thrust_pos_y = [];
cycler4_thrust_pos_z = [];
for power = transpose(cycler1_thrust_power_x_all)
    if (cycler1_thrust_power_x_all(int) > 10^(-3)) | (cycler1_thrust_power_y_all(int) > 10^(-3)) | (cycler1_thrust_power_z_all(int) > 10^(-3)) 
        cycler1_thrust_power_x(j1) = cycler1_thrust_power_x_all(int);
        cycler1_thrust_power_y(j1) = cycler1_thrust_power_y_all(int);
        cycler1_thrust_power_z(j1) = cycler1_thrust_power_z_all(int);
        cycler1_thrust_pos_x(j1) = cycler1_thrust_pos_x_all(int);
        cycler1_thrust_pos_y(j1) = cycler1_thrust_pos_y_all(int);
        cycler1_thrust_pos_z(j1) = cycler1_thrust_pos_z_all(int);
        j1 = j1 + 1;
    end
    int = int + 1;
end
int = 1;
for power = transpose(cycler2_thrust_power_x_all)
    if (cycler2_thrust_power_x_all(int) > 10^(-3)) | (cycler2_thrust_power_y_all(int) > 10^(-3)) | (cycler2_thrust_power_z_all(int) > 10^(-3))
        cycler2_thrust_power_x(j2) = cycler2_thrust_power_x_all(int);
        cycler2_thrust_power_y(j2) = cycler2_thrust_power_y_all(int);
        cycler2_thrust_power_z(j2) = cycler2_thrust_power_z_all(int);
        cycler2_thrust_pos_x(j2) = cycler2_thrust_pos_x_all(int);
        cycler2_thrust_pos_y(j2) = cycler2_thrust_pos_y_all(int);
        cycler2_thrust_pos_z(j2) = cycler2_thrust_pos_z_all(int);
        j2 = j2 + 1;
    end
    int = int + 1;
end
int = 1;
for power = transpose(cycler3_thrust_power_x_all)
    if (cycler3_thrust_power_x_all(int) > 10^(-3)) | (cycler3_thrust_power_y_all(int) > 10^(-3)) | (cycler3_thrust_power_z_all(int) > 10^(-3))
        cycler3_thrust_power_x(j3) = cycler3_thrust_power_x_all(int);
        cycler3_thrust_power_y(j3) = cycler3_thrust_power_y_all(int);
        cycler3_thrust_power_z(j3) = cycler3_thrust_power_z_all(int);
        cycler3_thrust_pos_x(j3) = cycler3_thrust_pos_x_all(int);
        cycler3_thrust_pos_y(j3) = cycler3_thrust_pos_y_all(int);
        cycler3_thrust_pos_z(j3) = cycler3_thrust_pos_z_all(int);
        j3 = j3 + 1;
    end
    int = int + 1;
end
int = 1;
for power = transpose(cycler4_thrust_power_x_all)
    if (cycler4_thrust_power_x_all(int) > 10^(-3)) | (cycler4_thrust_power_y_all(int) > 10^(-3)) | (cycler4_thrust_power_z_all(int) > 10^(-3))
        cycler4_thrust_power_x(j4) = cycler4_thrust_power_x_all(int);
        cycler4_thrust_power_y(j4) = cycler4_thrust_power_y_all(int);
        cycler4_thrust_power_z(j4) = cycler4_thrust_power_z_all(int);
        cycler4_thrust_pos_x(j4) = cycler4_thrust_pos_x_all(int);
        cycler4_thrust_pos_y(j4) = cycler4_thrust_pos_y_all(int);
        cycler4_thrust_pos_z(j4) = cycler4_thrust_pos_z_all(int);
        j4 = j4 + 1;
    end
    int = int + 1;
end
cycler1 = xlsread('Hybrid_S1L1_v1.xlsx');
cycler1_encounter_time = cycler1(:, 17);

cycler2 = xlsread('Hybrid_S1L1_v2.xlsx');
cycler2_encounter_time = cycler2(:, 17);

cycler3 = xlsread('Hybrid_S1L1_v3.xlsx');
cycler3_encounter_time = cycler3(:, 17);

cycler4 = xlsread('Hybrid_S1L1_v4.xlsx');
cycler4_encounter_time = cycler4(:, 17);

%% Compute Max TOF if Mars is Missed
cycler1_EE_TOF1 = cycler1_encounter_time(3) - cycler1_encounter_time(1);
cycler1_EE_TOF2 = cycler1_encounter_time(6) - cycler1_encounter_time(4);
cycler1_EE_TOF3 = cycler1_encounter_time(9) - cycler1_encounter_time(7);
cycler1_EE_TOF4 = cycler1_encounter_time(12) - cycler1_encounter_time(10);
cycler1_EE_TOF5 = cycler1_encounter_time(15) - cycler1_encounter_time(13);
cycler1_EE_TOF6 = cycler1_encounter_time(18) - cycler1_encounter_time(16);
cycler1_EE_TOF7 = cycler1_encounter_time(21) - cycler1_encounter_time(19);
cycler1_EE_TOF8 = cycler1_encounter_time(24) - cycler1_encounter_time(22);
cycler1_EE_TOF = [cycler1_EE_TOF1 cycler1_EE_TOF2 cycler1_EE_TOF3 cycler1_EE_TOF4 cycler1_EE_TOF5 cycler1_EE_TOF6 cycler1_EE_TOF7 cycler1_EE_TOF8];
cycler1_max_miss_TOF = max(cycler1_EE_TOF);
%The above line is the maximum time before Earth encounter if something
%goes wrong and cycler 1 misses Mars. (The time is in days.)

cycler2_EE_TOF1 = cycler2_encounter_time(3) - cycler2_encounter_time(1);
cycler2_EE_TOF2 = cycler2_encounter_time(6) - cycler2_encounter_time(4);
cycler2_EE_TOF3 = cycler2_encounter_time(9) - cycler2_encounter_time(7);
cycler2_EE_TOF4 = cycler2_encounter_time(12) - cycler2_encounter_time(10);
cycler2_EE_TOF5 = cycler2_encounter_time(15) - cycler2_encounter_time(13);
cycler2_EE_TOF6 = cycler2_encounter_time(18) - cycler2_encounter_time(16);
cycler2_EE_TOF7 = cycler2_encounter_time(21) - cycler2_encounter_time(19);
cycler2_EE_TOF8 = cycler2_encounter_time(24) - cycler2_encounter_time(22);
cycler2_EE_TOF = [cycler2_EE_TOF1 cycler2_EE_TOF2 cycler2_EE_TOF3 cycler2_EE_TOF4 cycler2_EE_TOF5 cycler2_EE_TOF6 cycler2_EE_TOF7 cycler2_EE_TOF8];
cycler2_max_miss_TOF = max(cycler2_EE_TOF);
%The above line is the maximum time before Earth encounter if something
%goes wrong and cycler 1 misses Mars. (The time is in days.)

cycler3_MEE_TOF1 = cycler3_encounter_time(4) - cycler3_encounter_time(2);
cycler3_MEE_TOF2 = cycler3_encounter_time(7) - cycler3_encounter_time(5);
cycler3_MEE_TOF3 = cycler3_encounter_time(10) - cycler3_encounter_time(8);
cycler3_MEE_TOF4 = cycler3_encounter_time(13) - cycler3_encounter_time(11);
cycler3_MEE_TOF5 = cycler3_encounter_time(16) - cycler3_encounter_time(14);
cycler3_MEE_TOF6 = cycler3_encounter_time(19) - cycler3_encounter_time(17);
cycler3_MEE_TOF7 = cycler3_encounter_time(22) - cycler3_encounter_time(20);
cycler3_MEE_TOF8 = cycler3_encounter_time(25) - cycler3_encounter_time(23);
cycler3_MEE_TOF = [cycler3_MEE_TOF1 cycler3_MEE_TOF2 cycler3_MEE_TOF3 cycler3_MEE_TOF4 cycler3_MEE_TOF5 cycler3_MEE_TOF6 cycler3_MEE_TOF7 cycler3_MEE_TOF8];
cycler3_max_miss_TOF = max(cycler3_MEE_TOF);
%The above line is the maximum time before Earth encounter if something
%goes wrong and cycler 1 misses Mars. (The time is in days.)

cycler4_MEE_TOF1 = cycler4_encounter_time(4) - cycler4_encounter_time(2);
cycler4_MEE_TOF2 = cycler4_encounter_time(7) - cycler4_encounter_time(5);
cycler4_MEE_TOF3 = cycler4_encounter_time(10) - cycler4_encounter_time(8);
cycler4_MEE_TOF4 = cycler4_encounter_time(13) - cycler4_encounter_time(11);
cycler4_MEE_TOF5 = cycler4_encounter_time(16) - cycler4_encounter_time(14);
cycler4_MEE_TOF6 = cycler4_encounter_time(19) - cycler4_encounter_time(17);
cycler4_MEE_TOF7 = cycler4_encounter_time(22) - cycler4_encounter_time(20);
cycler4_MEE_TOF8 = cycler4_encounter_time(25) - cycler4_encounter_time(23);
cycler4_MEE_TOF = [cycler4_MEE_TOF1 cycler4_MEE_TOF2 cycler4_MEE_TOF3 cycler4_MEE_TOF4 cycler4_MEE_TOF5 cycler4_MEE_TOF6 cycler4_MEE_TOF7 cycler4_MEE_TOF8];
cycler4_max_miss_TOF = max(cycler4_MEE_TOF);
%The above line is the maximum time before Earth encounter if something
%goes wrong and cycler 1 misses Mars. (The time is in days.)
combined_maxes = [cycler1_max_miss_TOF cycler2_max_miss_TOF cycler3_max_miss_TOF cycler4_max_miss_TOF];
overall_max_miss_TOF = max(combined_maxes); %Longest TOF people might have to be on any cycler if Mars is missed

%% Compute TOFs Assuming Mars is Sucessfully Intercepted
cycler1_EM_TOF1 = cycler1_encounter_time(2) - cycler1_encounter_time(1);
cycler1_EM_TOF2 = cycler1_encounter_time(5) - cycler1_encounter_time(4);
cycler1_EM_TOF3 = cycler1_encounter_time(8) - cycler1_encounter_time(7);
cycler1_EM_TOF4 = cycler1_encounter_time(11) - cycler1_encounter_time(10);
cycler1_EM_TOF5 = cycler1_encounter_time(14) - cycler1_encounter_time(13);
cycler1_EM_TOF6 = cycler1_encounter_time(17) - cycler1_encounter_time(16);
cycler1_EM_TOF7 = cycler1_encounter_time(20) - cycler1_encounter_time(19);
cycler1_EM_TOF8 = cycler1_encounter_time(23) - cycler1_encounter_time(22);
cycler1_EM_TOF9 = cycler1_encounter_time(26) - cycler1_encounter_time(25);
cycler1_EM_TOF = [cycler1_EM_TOF1 cycler1_EM_TOF2 cycler1_EM_TOF3 cycler1_EM_TOF4 cycler1_EM_TOF5 cycler1_EM_TOF6 cycler1_EM_TOF7 cycler1_EM_TOF8 cycler1_EM_TOF9];
cycler1_max_intended_TOF = max(cycler1_EM_TOF);

cycler2_EM_TOF1 = cycler2_encounter_time(2) - cycler2_encounter_time(1);
cycler2_EM_TOF2 = cycler2_encounter_time(5) - cycler2_encounter_time(4);
cycler2_EM_TOF3 = cycler2_encounter_time(8) - cycler2_encounter_time(7);
cycler2_EM_TOF4 = cycler2_encounter_time(11) - cycler2_encounter_time(10);
cycler2_EM_TOF5 = cycler2_encounter_time(14) - cycler2_encounter_time(13);
cycler2_EM_TOF6 = cycler2_encounter_time(17) - cycler2_encounter_time(16);
cycler2_EM_TOF7 = cycler2_encounter_time(20) - cycler2_encounter_time(19);
cycler2_EM_TOF8 = cycler2_encounter_time(23) - cycler2_encounter_time(22);
cycler2_EM_TOF9 = cycler2_encounter_time(26) - cycler2_encounter_time(25);
cycler2_EM_TOF = [cycler2_EM_TOF1 cycler2_EM_TOF2 cycler2_EM_TOF3 cycler2_EM_TOF4 cycler2_EM_TOF5 cycler2_EM_TOF6 cycler2_EM_TOF7 cycler2_EM_TOF8 cycler2_EM_TOF9];
cycler2_max_intended_TOF = max(cycler2_EM_TOF);

cycler3_ME_TOF1 = cycler3_encounter_time(3) - cycler3_encounter_time(2);
cycler3_ME_TOF2 = cycler3_encounter_time(6) - cycler3_encounter_time(5);
cycler3_ME_TOF3 = cycler3_encounter_time(9) - cycler3_encounter_time(8);
cycler3_ME_TOF4 = cycler3_encounter_time(12) - cycler3_encounter_time(11);
cycler3_ME_TOF5 = cycler3_encounter_time(15) - cycler3_encounter_time(14);
cycler3_ME_TOF6 = cycler3_encounter_time(18) - cycler3_encounter_time(17);
cycler3_ME_TOF7 = cycler3_encounter_time(21) - cycler3_encounter_time(20);
cycler3_ME_TOF8 = cycler3_encounter_time(24) - cycler3_encounter_time(23);
cycler3_ME_TOF = [cycler3_ME_TOF1 cycler3_ME_TOF2 cycler3_ME_TOF3 cycler3_ME_TOF4 cycler3_ME_TOF5 cycler3_ME_TOF6 cycler3_ME_TOF7 cycler3_ME_TOF8];
cycler3_max_intended_TOF = max(cycler3_ME_TOF);

cycler4_ME_TOF1 = cycler4_encounter_time(3) - cycler4_encounter_time(2);
cycler4_ME_TOF2 = cycler4_encounter_time(6) - cycler4_encounter_time(5);
cycler4_ME_TOF3 = cycler4_encounter_time(9) - cycler4_encounter_time(8);
cycler4_ME_TOF4 = cycler4_encounter_time(12) - cycler4_encounter_time(11);
cycler4_ME_TOF5 = cycler4_encounter_time(15) - cycler4_encounter_time(14);
cycler4_ME_TOF6 = cycler4_encounter_time(18) - cycler4_encounter_time(17);
cycler4_ME_TOF7 = cycler4_encounter_time(21) - cycler4_encounter_time(20);
cycler4_ME_TOF8 = cycler4_encounter_time(24) - cycler4_encounter_time(23);
cycler4_ME_TOF = [cycler4_ME_TOF1 cycler4_ME_TOF2 cycler4_ME_TOF3 cycler4_ME_TOF4 cycler4_ME_TOF5 cycler4_ME_TOF6 cycler4_ME_TOF7 cycler4_ME_TOF8];
cycler4_max_intended_TOF = max(cycler4_ME_TOF);

combined_intended_maxes = [cycler1_max_intended_TOF cycler2_max_intended_TOF cycler3_max_intended_TOF cycler4_max_intended_TOF];
overall_max_intended_TOF = max(combined_intended_maxes);

cyclers_to_Mars = [1:1:9];
cyclers_round_trip = [1:1:8];
cyclers_to_Earth = [1:1:8];
%{
figure(1)
plot(cyclers_to_Mars, cycler1_EM_TOF)
xlabel('Cycler 1 Trip to Mars')
ylabel('TOF (days)')
title('TOFs for Cycler 1 Assuming Standard Trip')

figure(2)
plot(cyclers_to_Mars, cycler2_EM_TOF)
xlabel('Cycler 2 Trip to Mars')
ylabel('TOF (days)')
title('TOFs for Cycler 2 Assuming Standard Trip')

figure(3)
plot(cyclers_to_Earth, cycler3_ME_TOF)
xlabel('Cycler 3 Trip to Earth')
ylabel('TOF (days)')
title('TOFs for Cycler 3 Assuming Standard Trip')

figure(4)
plot(cyclers_to_Earth, cycler4_ME_TOF)
xlabel('Cycler 4 Trip to Earth')
ylabel('TOF (days)')
title('TOFs for Cycler 4 Assuming Standard Trip')
%}
%% Generate Visualizations

start1 = [cycler1_encounter_pos_x(1) cycler1_encounter_pos_y(1) cycler1_encounter_pos_z(1)];
stop1 = [cycler1_encounter_pos_x(26) cycler1_encounter_pos_y(26) cycler1_encounter_pos_z(26)];
figure(1) %Plot of cycler 1 orbit in 3D with planetary encounters
plot3(cycler1_pos_x, cycler1_pos_y, cycler1_pos_z, 'LineWidth', 1)
hold on
plot3(cycler1_encounter_pos_x, cycler1_encounter_pos_y, cycler1_encounter_pos_z, 'r.', 'MarkerSize', 30)
plot3(0, 0, 0, 'y.', 'MarkerSize', 80)
axis equal
xlabel('Ecliptic Plane (AU)', 'FontSize', 24)
ylabel('Ecliptic Plane (AU)', 'FontSize', 24)
zlabel('Out of Plane Direction (AU)', 'FontSize', 24)
text(start1(1), start1(2), start1(3), 'E-1', 'FontSize', 24, 'FontWeight', 'bold')
text(stop1(1), stop1(2), stop1(3), 'M-26', 'FontSize', 24, 'FontWeight', 'bold')
title('Cycler 1 Trajectory (outbound)', 'FontSize', 30)
lgd1 = legend('Cycler 1 Path', 'Planetary Encounter', 'Sun');
lgd1.FontSize = 24;

start2 = [cycler2_encounter_pos_x(1) cycler2_encounter_pos_y(1) cycler2_encounter_pos_z(1)];
stop2 = [cycler2_encounter_pos_x(26) cycler2_encounter_pos_y(26) cycler2_encounter_pos_z(26)];
figure(2) %Plot of cycler 2 orbit in 3D with planetary encounters
plot3(cycler2_pos_x, cycler2_pos_y, cycler2_pos_z, 'LineWidth', 1)
hold on
plot3(cycler2_encounter_pos_x, cycler2_encounter_pos_y, cycler2_encounter_pos_z, 'r.', 'MarkerSize', 30)
plot3(0, 0, 0, 'y.', 'MarkerSize', 80)
axis equal
xlabel('Ecliptic Plane (AU)', 'FontSize', 24)
ylabel('Ecliptic Plane (AU)', 'FontSize', 24)
zlabel('Out of Plane Direction (AU)', 'FontSize', 24)
text(start2(1) + .05, start2(2), start2(3), 'E-1', 'FontSize', 24, 'FontWeight', 'bold')
text(stop2(1), stop2(2), stop2(3), 'M-26', 'FontSize', 24, 'FontWeight', 'bold')
title('Cycler 2 Trajectory (outbound)', 'FontSize', 30)
lgd2 = legend('Cycler 2 Path', 'Planetary Encounter', 'Sun');
lgd2.FontSize = 24;

start3 = [cycler3_encounter_pos_x(1) cycler3_encounter_pos_y(1) cycler3_encounter_pos_z(1)];
stop3 = [cycler3_encounter_pos_x(26) cycler3_encounter_pos_y(26) cycler3_encounter_pos_z(26)];
figure(3) %Plot of cycler 3 orbit in 3D with planetary encounters
plot3(cycler3_pos_x, cycler3_pos_y, cycler3_pos_z, 'LineWidth', 1)
hold on
plot3(cycler3_encounter_pos_x, cycler3_encounter_pos_y, cycler3_encounter_pos_z, 'r.', 'MarkerSize', 30)
plot3(0, 0, 0, 'y.', 'MarkerSize', 80)
axis equal
xlabel('Ecliptic Plane (AU)', 'FontSize', 24)
ylabel('Ecliptic Plane (AU)', 'FontSize', 24)
zlabel('Out of Plane Direction (AU)', 'FontSize', 24)
text(start3(1)- .06, start3(2), start3(3), 'E-1', 'FontSize', 24, 'FontWeight', 'bold')
text(stop3(1) + .04, stop3(2), stop3(3), 'M-26', 'FontSize', 24, 'FontWeight', 'bold')
title('Cycler 3 Trajectory (inbound)', 'FontSize', 30)
lgd3 = legend('Cycler 3 Path', 'Planetary Encounter', 'Sun');
lgd3.FontSize = 24;

start4 = [cycler4_encounter_pos_x(1) cycler4_encounter_pos_y(1) cycler4_encounter_pos_z(1)];
stop4 = [cycler4_encounter_pos_x(26) cycler4_encounter_pos_y(26) cycler4_encounter_pos_z(26)];
figure(4) %Plot of cycler 4 orbit in 3D with planetary encounters
plot3(cycler4_pos_x, cycler4_pos_y, cycler4_pos_z, 'LineWidth', 1)
hold on
plot3(cycler4_encounter_pos_x, cycler4_encounter_pos_y, cycler4_encounter_pos_z, 'r.', 'MarkerSize', 30)
plot3(0, 0, 0, 'y.', 'MarkerSize', 80)
axis equal
xlabel('Ecliptic Plane (AU)', 'FontSize', 24)
ylabel('Ecliptic Plane (AU)', 'FontSize', 24)
zlabel('Out of Plane Direction (AU)', 'FontSize', 24)
text(start4(1), start4(2) - .05, start4(3), 'E-1', 'FontSize', 24, 'FontWeight', 'bold')
text(stop4(1), stop4(2), stop4(3), 'M-26', 'FontSize', 24, 'FontWeight', 'bold')
title('Cycler 4 Trajectory (inbound)', 'FontSize', 30)
lgd4 = legend('Cycler 4 Path', 'Planetary Encounter', 'Sun');
lgd4.FontSize = 24;

%{
figure(5) %Plot of cycler 1 orbit in 3D with burn locations
plot3(cycler1_pos_x, cycler1_pos_y, cycler1_pos_z)
hold on
plot3(cycler1_thrust_pos_x, cycler1_thrust_pos_y, cycler1_thrust_pos_z, 'r.', 'MarkerSize', 15)
plot3(0, 0, 0, 'y.', 'MarkerSize', 60)
axis equal
xlabel('X position (AU')
ylabel('Y position (AU)')
zlabel('Z position (AU)')
title('Locations of Thrust Burns for Cycler 1')
legend('Cycler 1 Path', 'Thrust Locations')

figure(6) %Plot of cycler 2 orbit in 3D with burn locations
plot3(cycler2_pos_x, cycler2_pos_y, cycler2_pos_z)
hold on
plot3(cycler2_thrust_pos_x, cycler2_thrust_pos_y, cycler2_thrust_pos_z, 'r.', 'MarkerSize', 15)
plot3(0, 0, 0, 'y.', 'MarkerSize', 60)
axis equal
xlabel('X position (AU')
ylabel('Y position (AU)')
zlabel('Z position (AU)')
title('Locations of Thrust Burns for Cycler 2')
legend('Cycler 2 Path', 'Thrust Locations')

figure(7) %Plot of cycler 3 orbit in 3D with burn locations
plot3(cycler3_pos_x, cycler3_pos_y, cycler3_pos_z)
hold on
plot3(cycler3_thrust_pos_x, cycler3_thrust_pos_y, cycler3_thrust_pos_z, 'r.', 'MarkerSize', 15)
plot3(0, 0, 0, 'y.', 'MarkerSize', 60)
axis equal
xlabel('X position (AU')
ylabel('Y position (AU)')
zlabel('Z position (AU)')
title('Locations of Thrust Burns for Cycler 3')
legend('Cycler 3 Path', 'Thrust Locations')

figure(8) %Plot of cycler 4 orbit in 3D with burn locations
plot3(cycler4_pos_x, cycler4_pos_y, cycler4_pos_z)
hold on
plot3(cycler4_thrust_pos_x, cycler4_thrust_pos_y, cycler4_thrust_pos_z, 'r.', 'MarkerSize', 15)
plot3(0, 0, 0, 'y.', 'MarkerSize', 60)
axis equal
xlabel('X position (AU')
ylabel('Y position (AU)')
zlabel('Z position (AU)')
title('Locations of Thrust Burns for Cycler 4')
legend('Cycler 4 Path', 'Thrust Locations')


figure(9) %Plot of out of plane component of cycler 1 path
plot(cycler1_time, cycler1_pos_z)
xlabel('Time (Julian Days)')
ylabel('Out of Plane Component (AU)')
title('Out of Plane Component of Cycler 1 Orbit')

figure(10) %Plot of out of plane component of cycler 2 path
plot(cycler2_time, cycler2_pos_z)
xlabel('Time (Julian Days)')
ylabel('Out of Plane Component (AU)')
title('Out of Plane Component of Cycler 2 Orbit')

figure(11) %Plot of out of plane component of cycler 3 path
plot(cycler3_time, cycler3_pos_z)
xlabel('Time (Julian Days)')
ylabel('Out of Plane Component (AU)')
title('Out of Plane Component of Cycler 3 Orbit')

figure(12) %Plot of out of plane component of cycler 4 path
plot(cycler4_time, cycler4_pos_z)
xlabel('Time (Julian Days)')
ylabel('Out of Plane Component (AU)')
title('Out of Plane Component of Cycler 4 Orbit')

figure(13) %Plot of the TOFs to Mars and back to Earth if Mars is missed for cycler 1
plot(cyclers_to_Mars, cycler1_EM_TOF)
hold on
plot(cyclers_round_trip, cycler1_EE_TOF)
xlabel('Cycler 1 Trip to Mars')
ylabel('TOF (days)')
title('TOFs for Cycler 1')
legend('Standard Trip', 'Time to Earth Return', 'location', 'best')

figure(14) %Plot of the TOFs to Mars and back to Earth is Mars is missed for cycler 2
plot(cyclers_to_Mars, cycler2_EM_TOF)
hold on
plot(cyclers_round_trip, cycler2_EE_TOF)
xlabel('Cycler 2 Trip to Mars')
ylabel('TOF (days)')
title('TOFs for Cycler 2')
legend('Standard Trip', 'Time to Earth Return', 'location', 'best')

figure(15) %Plot of the TOFs to Mars and back to Earth is Mars is missed for cycler 3
plot(cyclers_to_Earth, cycler3_ME_TOF)
hold on
plot(cyclers_round_trip, cycler3_MEE_TOF)
xlabel('Cycler 3 Trip to Mars')
ylabel('TOF (days)')
title('TOFs for Cycler 3')
legend('Standard Trip', 'Time to Second Earth Encounter', 'location', 'best')

figure(16) %Plot of the TOFs to Mars and back to Earth is Mars is missed for cycler 4
plot(cyclers_to_Earth, cycler4_ME_TOF)
hold on
plot(cyclers_round_trip, cycler4_MEE_TOF)
xlabel('Cycler 4 Trip to Mars')
ylabel('TOF (days)')
title('TOFs for Cycler 4')
legend('Standard Trip', 'Time to Second Earth Encounter', 'location', 'best')
%}
%{
figure(3)
plot(cycler4_encounter_pos_x, cycler4_encounter_pos_y, 'r.', 'MarkerSize', 15)

figure(2)
plot(cycler2_pos_x(1:3000), cycler2_pos_y(1:3000))
hold on
plot(cycler2_encounter_pos_x(1), cycler2_encounter_pos_y(1), 'g.', 'MarkerSize', 15)
plot(cycler2_encounter_pos_x(2:26), cycler2_encounter_pos_y(2:26), 'r.', 'MarkerSize', 15)
axis equal
xlabel('Distance (AU)')
ylabel('Distance (AU)')
title('North Pole View of Cycler 2 (outbound)')

figure(3)
plot(cycler3_pos_x(1:4000), cycler3_pos_y(1:4000))
hold on
plot(cycler3_encounter_pos_x(1:15), cycler3_encounter_pos_y(1:15), 'r.', 'MarkerSize', 15)
axis equal
xlabel('Distance (AU)')
ylabel('Distance (AU)')
title('North Pole View of Cycler 3 (inbound)')

figure(4)
plot3(cycler4_pos_x(1:4000), cycler4_pos_y(1:4000), cycler4_pos_z(1:4000))
hold on
plot3(cycler4_encounter_pos_x(1:15), cycler4_encounter_pos_y(1:15), cycler4_encounter_pos_z(1:15), 'r.', 'MarkerSize', 15)
plot3(0, 0, 0, 'y.', 'MarkerSize', 60)
axis equal
xlabel('Distance (AU)')
ylabel('Distance (AU)')
zlabel('Out of Plane Distance (AU)')
title('North Pole View of Cycler 4 (inbound)')
%}