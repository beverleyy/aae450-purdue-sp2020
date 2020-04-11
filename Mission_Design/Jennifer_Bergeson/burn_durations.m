format long
clc

%% Set up data
t_t_w = .01;    % (N/Mg) Thrust to weight ratio of the cycler
load Trajectory_Information.mat
cycler1_time = Trajectory.Vehicle1.julian_date;
cycler2_time = Trajectory.Vehicle2.julian_date;
cycler3_time = Trajectory.Vehicle3.julian_date;
cycler4_time = Trajectory.Vehicle4.julian_date;
% Time vectors that correspond to position vectors for each cycler

cycler1_pos_x = Trajectory.Vehicle1.position(:, 1);
cycler2_pos_x = Trajectory.Vehicle2.position(:, 1);
cycler3_pos_x = Trajectory.Vehicle3.position(:, 1);
cycler4_pos_x = Trajectory.Vehicle4.position(:, 1);
% x component of position vectors for each cycler

cycler1_pos_y = Trajectory.Vehicle1.position(:, 2);
cycler2_pos_y = Trajectory.Vehicle2.position(:, 2);
cycler3_pos_y = Trajectory.Vehicle3.position(:, 2);
cycler4_pos_y = Trajectory.Vehicle4.position(:, 2);
% y component of position vectors for each cycler

cycler1_pos_z = Trajectory.Vehicle1.position(:, 3);
cycler2_pos_z = Trajectory.Vehicle2.position(:, 3);
cycler3_pos_z = Trajectory.Vehicle3.position(:, 3);
cycler4_pos_z = Trajectory.Vehicle4.position(:, 3);
% x component of position vectors for each cycler

cycler1_pos = [cycler1_pos_x, cycler1_pos_y, cycler1_pos_z];
cycler2_pos = [cycler2_pos_x, cycler2_pos_y, cycler2_pos_z];
cycler3_pos = [cycler3_pos_x, cycler3_pos_y, cycler3_pos_z];
cycler4_pos = [cycler4_pos_x, cycler4_pos_y, cycler4_pos_z];
% combined position vectors for each cycler

cycler1_thrust_pos_x_all = Trajectory.Vehicle1.thrust(:, 1);
cycler2_thrust_pos_x_all = Trajectory.Vehicle2.thrust(:, 1);
cycler3_thrust_pos_x_all = Trajectory.Vehicle3.thrust(:, 1);
cycler4_thrust_pos_x_all = Trajectory.Vehicle4.thrust(:, 1);
% full (unfiltered) x components of position at thrust for each cycler

cycler1_thrust_pos_y_all = Trajectory.Vehicle1.thrust(:, 2);
cycler2_thrust_pos_y_all = Trajectory.Vehicle2.thrust(:, 2);
cycler3_thrust_pos_y_all = Trajectory.Vehicle3.thrust(:, 2);
cycler4_thrust_pos_y_all = Trajectory.Vehicle4.thrust(:, 2);
% full (unfiltered) y components of position at thrust for each cycler

cycler1_thrust_pos_z_all = Trajectory.Vehicle1.thrust(:, 3);
cycler2_thrust_pos_z_all = Trajectory.Vehicle2.thrust(:, 3);
cycler3_thrust_pos_z_all = Trajectory.Vehicle3.thrust(:, 3);
cycler4_thrust_pos_z_all = Trajectory.Vehicle4.thrust(:, 3);
% full (unfiltered) z components of position at thrust for each cycler

cycler1_thrust_power_x_all = Trajectory.Vehicle1.thrust(:, 4)*149597870;
cycler2_thrust_power_x_all = Trajectory.Vehicle2.thrust(:, 4)*149597870;
cycler3_thrust_power_x_all = Trajectory.Vehicle3.thrust(:, 4)*149597870;
cycler4_thrust_power_x_all = Trajectory.Vehicle4.thrust(:, 4)*149597870;
% full (unfiltered) x components of thrust vector for each cycler (0-1
% scale)

cycler1_thrust_power_y_all = Trajectory.Vehicle1.thrust(:, 5)*149597870;
cycler2_thrust_power_y_all = Trajectory.Vehicle2.thrust(:, 5)*149597870;
cycler3_thrust_power_y_all = Trajectory.Vehicle3.thrust(:, 5)*149597870;
cycler4_thrust_power_y_all = Trajectory.Vehicle4.thrust(:, 5)*149597870;
% full (unfiltered) y components of thrust vector for each cycler (0-1
% scale)

cycler1_thrust_power_z_all = Trajectory.Vehicle1.thrust(:, 6)*149597870;
cycler2_thrust_power_z_all = Trajectory.Vehicle2.thrust(:, 6)*149597870;
cycler3_thrust_power_z_all = Trajectory.Vehicle3.thrust(:, 6)*149597870;
cycler4_thrust_power_z_all = Trajectory.Vehicle4.thrust(:, 6)*149597870;
% full (unfiltered) z components of thrust vector for each cycler (0-1
% scale)

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


cycler1_thrust_power = [transpose(cycler1_thrust_power_x) transpose(cycler1_thrust_power_y) transpose(cycler1_thrust_power_z)];
cycler2_thrust_power = [transpose(cycler2_thrust_power_x) transpose(cycler2_thrust_power_y) transpose(cycler2_thrust_power_z)];
cycler3_thrust_power = [transpose(cycler3_thrust_power_x) transpose(cycler3_thrust_power_y) transpose(cycler3_thrust_power_z)];
cycler4_thrust_power = [transpose(cycler4_thrust_power_x) transpose(cycler4_thrust_power_y) transpose(cycler4_thrust_power_z)];

cycler1_thrust_pos = [transpose(cycler1_thrust_pos_x) transpose(cycler1_thrust_pos_y) transpose(cycler1_thrust_pos_z)];
cycler2_thrust_pos = [transpose(cycler2_thrust_pos_x) transpose(cycler2_thrust_pos_y) transpose(cycler2_thrust_pos_z)];
cycler3_thrust_pos = [transpose(cycler3_thrust_pos_x) transpose(cycler3_thrust_pos_y) transpose(cycler3_thrust_pos_z)];
cycler4_thrust_pos = [transpose(cycler4_thrust_pos_x) transpose(cycler4_thrust_pos_y) transpose(cycler4_thrust_pos_z)];

cycler1 = xlsread('Hybrid_S1L1_v1.xlsx');
cycler1_encounter_time = cycler1(:, 17);
cycler2 = xlsread('Hybrid_S1L1_v2.xlsx');
cycler2_encounter_time = cycler2(:, 17);
cycler3 = xlsread('Hybrid_S1L1_v3.xlsx');
cycler3_encounter_time = cycler3(:, 17);
cycler4 = xlsread('Hybrid_S1L1_v4.xlsx');
cycler4_encounter_time = cycler4(:, 17);

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
cycler1_encounter_pos = [cycler1_encounter_pos_x cycler1_encounter_pos_y cycler1_encounter_pos_z];
cycler2_encounter_pos = [cycler2_encounter_pos_x cycler2_encounter_pos_y cycler2_encounter_pos_z];
cycler3_encounter_pos = [cycler3_encounter_pos_x cycler3_encounter_pos_y cycler3_encounter_pos_z];
cycler4_encounter_pos = [cycler4_encounter_pos_x cycler4_encounter_pos_y cycler4_encounter_pos_z];
%% Get Start and Stop Time Vectors of Burn
[cycler1_true cycler1_thrust_indices] = ismember(cycler1_thrust_pos, cycler1_pos, 'rows');
cycler1_thrust_start_time = cycler1_time(cycler1_thrust_indices);
cycler1_thrust_stop_time = cycler1_time(cycler1_thrust_indices + 1);

[cycler2_true cycler2_thrust_indices] = ismember(cycler2_thrust_pos, cycler2_pos, 'rows');
cycler2_thrust_start_time = cycler2_time(cycler2_thrust_indices);
cycler2_thrust_stop_time = cycler2_time(cycler2_thrust_indices +1);

[cycler3_true cycler3_thrust_indices] = ismember(cycler3_thrust_pos, cycler3_pos, 'rows');
cycler3_thrust_start_time = cycler3_time(cycler3_thrust_indices);
cycler3_thrust_stop_time = cycler3_time(cycler3_thrust_indices + 1);

[cycler4_true cycler4_thrust_indices] = ismember(cycler4_thrust_pos, cycler4_pos, 'rows');
cycler4_thrust_start_time = cycler4_time(cycler4_thrust_indices);
cycler4_thrust_stop_time = cycler4_time(cycler4_thrust_indices + 1);

%% Get Burn Durations
cycler1_thrust_duration = cycler1_thrust_stop_time - cycler1_thrust_start_time;
cycler2_thrust_duration = cycler2_thrust_stop_time - cycler2_thrust_start_time;
cycler3_thrust_duration = cycler3_thrust_stop_time - cycler3_thrust_start_time;
cycler4_thrust_duration = cycler4_thrust_stop_time - cycler4_thrust_start_time;

%% Get Burn Magnitudes
cycler1_thrust_power_mag = (cycler1_thrust_power_x.^2 + cycler1_thrust_power_y.^2 + cycler1_thrust_power_z.^2).^.5;
cycler2_thrust_power_mag = (cycler2_thrust_power_x.^2 + cycler2_thrust_power_y.^2 + cycler2_thrust_power_z.^2).^.5;
cycler3_thrust_power_mag = (cycler3_thrust_power_x.^2 + cycler3_thrust_power_y.^2 + cycler3_thrust_power_z.^2).^.5;
cycler4_thrust_power_mag = (cycler4_thrust_power_x.^2 + cycler4_thrust_power_y.^2 + cycler4_thrust_power_z.^2).^.5;

%% Get Full Thrust Equivalent Durations
cycler1_thrust_time_eq = transpose(cycler1_thrust_power_mag).*cycler1_thrust_duration;
cycler2_thrust_time_eq = transpose(cycler2_thrust_power_mag).*cycler2_thrust_duration;
cycler3_thrust_time_eq = transpose(cycler3_thrust_power_mag).*cycler3_thrust_duration;
cycler4_thrust_time_eq = transpose(cycler4_thrust_power_mag).*cycler4_thrust_duration;

%% Get Full Thrust Equivalent Durations Between Refueling Assuming Refuel Every Earth Flyby
cycler1_burn_indices = [];  %Empty array that will be filled with the indices in the time array for encounters that corresponds with the encounter occuring immediately after the burn
cycler2_burn_indices = [];  %Empty array that will be filled with the indices in the time array for encounters that corresponds with the encounter occuring immediately after the burn
cycler3_burn_indices = [];  %Empty array that will be filled with the indices in the time array for encounters that corresponds with the encounter occuring immediately after the burn
cycler4_burn_indices = [];  %Empty array that will be filled with the indices in the time array for encounters that corresponds with the encounter occuring immediately after the burn

i = 1;  %loop counter
for time = transpose(cycler1_thrust_start_time) %start time of each burn
    cycler1_burn_index = 1; %index in the encounter time vector for the encounter that occurs directly after the burn
    while time > cycler1_encounter_time(cycler1_burn_index) %steps through encounter time vector to find encounter immediately following burn
        cycler1_burn_index = cycler1_burn_index + 1; %This is the index of the time in the encounter_time vector that corresponds
        % to the flyby directly after the burn is executed.
    end
    cycler1_burn_indices(i) = cycler1_burn_index;   %Filled array described above in initialization
    i = i + 1;  %update counter
end

i = 1;  %loop counter
for time = transpose(cycler2_thrust_start_time) %start time of each burn
    cycler2_burn_index = 1; %index in the encounter time vector for the encounter that occurs directly after the burn
    while time > cycler2_encounter_time(cycler2_burn_index) %steps through encounter time vector to find encounter immediately following burn
        cycler2_burn_index = cycler2_burn_index + 1; %This is the index of the time in the encounter_time vector that corresponds
        % to the flyby directly after the burn is executed.
    end
    cycler2_burn_indices(i) = cycler2_burn_index;   %Filled array described above in initialization
    i = i + 1;  %update counter
end

i = 1;  %loop counter
for time = transpose(cycler3_thrust_start_time) %start time of each burn
    cycler3_burn_index = 1; %index in the encounter time vector for the encounter that occurs directly after the burn
    while time > cycler3_encounter_time(cycler3_burn_index) %steps through encounter time vector to find encounter immediately following burn
        cycler3_burn_index = cycler3_burn_index + 1; %This is the index of the time in the encounter_time vector that corresponds
        % to the flyby directly after the burn is executed.
    end
    cycler3_burn_indices(i) = cycler3_burn_index;   %Filled array described above in initialization
    i = i + 1;  %update counter
end

i = 1;  %loop counter
for time = transpose(cycler4_thrust_start_time) %start time of each burn
    cycler4_burn_index = 1; %index in the encounter time vector for the encounter that occurs directly after the burn
    while time > cycler4_encounter_time(cycler4_burn_index) %steps through encounter time vector to find encounter immediately following burn
        cycler4_burn_index = cycler4_burn_index + 1; %This is the index of the time in the encounter_time vector that corresponds
        % to the flyby directly after the burn is executed.
    end
    cycler4_burn_indices(i) = cycler4_burn_index;   %Filled array described above in initialization
    i = i + 1;  %update counter
end

earth_encounter_indices_ee = [1 3 4 6 7 9 10 12 13 15 16 18 19 21 22 24 25];   %indices in encounter time array where the encounter is an earth encounter
segment_burn_durations_1_ee = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_2_ee = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_3_ee = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_4_ee = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
% A segment is defined as the time between the previous earth encounter and
% the current earth encounter as set by the index.

duration_index = 1; %Loop index
for cycler1_burn_index = cycler1_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_encounter_indices_ee == cycler1_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_1_ee(cycler1_burn_index) = segment_burn_durations_1_ee(cycler1_burn_index) + cycler1_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_1_ee(cycler1_burn_index + 1) = segment_burn_durations_1_ee(cycler1_burn_index + 1) + cycler1_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler2_burn_index = cycler2_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_encounter_indices_ee == cycler2_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_2_ee(cycler2_burn_index) = segment_burn_durations_2_ee(cycler2_burn_index) + cycler2_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_2_ee(cycler2_burn_index + 1) = segment_burn_durations_2_ee(cycler2_burn_index + 1) + cycler2_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler3_burn_index = cycler3_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_encounter_indices_ee == cycler3_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_3_ee(cycler3_burn_index) = segment_burn_durations_3_ee(cycler3_burn_index) + cycler3_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_3_ee(cycler3_burn_index + 1) = segment_burn_durations_3_ee(cycler3_burn_index + 1) + cycler3_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler4_burn_index = cycler4_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_encounter_indices_ee == cycler4_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_4_ee(cycler4_burn_index) = segment_burn_durations_4_ee(cycler4_burn_index) + cycler4_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_4_ee(cycler4_burn_index + 1) = segment_burn_durations_4_ee(cycler4_burn_index + 1) + cycler4_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

%% Get Full Thrust Equivalent Durations Between Refueling Assuming Refuel Every Boarding Earth Flyby
earth_boarding_indices_e = [1 4 7 10 13 16 19 22 25];   %indices in encounter time array where the encounter is an earth encounter
earth_disembarking_indices_e = [3 6 9 12 15 18 21 24];
segment_burn_durations_1_e = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_2_e = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_3_e = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_4_e = zeros(25, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
% A segment is defined as the time between the previous earth encounter and
% the current earth encounter as set by the index.

duration_index = 1; %Loop index
for cycler1_burn_index = cycler1_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_boarding_indices_e == cycler1_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_1_e(cycler1_burn_index) = segment_burn_durations_1_e(cycler1_burn_index) + cycler1_thrust_time_eq(duration_index);   %Adds the burn to the segment
    elseif find(earth_boarding_indices_e == (cycler1_burn_index + 1))
        segment_burn_durations_1_e(cycler1_burn_index + 1) = segment_burn_durations_1_e(cycler1_burn_index + 1) + cycler1_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_1_e(cycler1_burn_index + 2) = segment_burn_durations_1_e(cycler1_burn_index + 2) + cycler1_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler2_burn_index = cycler2_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_boarding_indices_e == cycler2_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_2_e(cycler2_burn_index) = segment_burn_durations_2_e(cycler2_burn_index) + cycler2_thrust_time_eq(duration_index);   %Adds the burn to the segment
    elseif find(earth_boarding_indices_e == (cycler2_burn_index + 1))
        segment_burn_durations_2_e(cycler2_burn_index + 1) = segment_burn_durations_2_e(cycler2_burn_index + 1) + cycler2_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_2_e(cycler2_burn_index + 2) = segment_burn_durations_2_e(cycler2_burn_index + 2) + cycler2_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler3_burn_index = cycler3_burn_indices(1:35)   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_disembarking_indices_e == cycler3_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_3_e(cycler3_burn_index) = segment_burn_durations_3_e(cycler3_burn_index) + cycler3_thrust_time_eq(duration_index);   %Adds the burn to the segment
    elseif find(earth_disembarking_indices_e == (cycler3_burn_index + 1))
        segment_burn_durations_3_e(cycler3_burn_index + 1) = segment_burn_durations_3_e(cycler3_burn_index + 1) + cycler3_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_3_e(cycler3_burn_index + 2) = segment_burn_durations_3_e(cycler3_burn_index + 2) + cycler3_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler4_burn_index = cycler4_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    if find(earth_disembarking_indices_e == cycler4_burn_index)  %Runs following line if the burn_index is an earth encounter index
        segment_burn_durations_4_e(cycler4_burn_index) = segment_burn_durations_4_e(cycler4_burn_index) + cycler4_thrust_time_eq(duration_index);   %Adds the burn to the segment
    elseif find(earth_disembarking_indices_e == (cycler4_burn_index + 1))
        segment_burn_durations_4_e(cycler4_burn_index + 1) = segment_burn_durations_4_e(cycler4_burn_index + 1) + cycler4_thrust_time_eq(duration_index);   %Adds the burn to the segment
    else
        segment_burn_durations_4_e(cycler4_burn_index + 2) = segment_burn_durations_4_e(cycler4_burn_index + 2) + cycler4_thrust_time_eq(duration_index);   %Adds the burn to the segment
    end
    duration_index = duration_index + 1;    %Updates the loop index
end

%% Get Full Thrust Equivalent durations between every flyby
encounter_indices = [1:26];   %indices in encounter time array 
segment_burn_durations_1_eem = zeros(26, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_2_eem = zeros(26, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_3_eem = zeros(26, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
segment_burn_durations_4_eem = zeros(26, 1);  %Zero array that will be filled with equivalent full burn durations for each segment
% A segment is defined as the time between encounters

duration_index = 1; %Loop index
for cycler1_burn_index = cycler1_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    segment_burn_durations_1_eem(cycler1_burn_index) = segment_burn_durations_1_eem(cycler1_burn_index) + cycler1_thrust_time_eq(duration_index);   %Adds the burn to the segment
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler2_burn_index = cycler2_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    segment_burn_durations_2_eem(cycler2_burn_index) = segment_burn_durations_2_eem(cycler2_burn_index) + cycler2_thrust_time_eq(duration_index);   %Adds the burn to the segment
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler3_burn_index = cycler3_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    segment_burn_durations_3_eem(cycler3_burn_index) = segment_burn_durations_3_eem(cycler3_burn_index) + cycler3_thrust_time_eq(duration_index);   %Adds the burn to the segment
    duration_index = duration_index + 1;    %Updates the loop index
end

duration_index = 1; %Loop index
for cycler4_burn_index = cycler4_burn_indices   %Index in the encounter time vector for the encounter that occurs directly after the burn
    segment_burn_durations_4_eem(cycler4_burn_index) = segment_burn_durations_4_eem(cycler4_burn_index) + cycler4_thrust_time_eq(duration_index);   %Adds the burn to the segment
    duration_index = duration_index + 1;    %Updates the loop index
end

%% Find Maximum Burn Time for Each leg
EE_segments = [4 7 10 13 16 19 22 25];
EM_segments = [2 5 8 11 14 17 20 23 26];
ME_segments = [3 6 9 12 15 18 21 24];
EE_burns_cycler1 = segment_burn_durations_1_eem(EE_segments);
EE_burns_cycler2 = segment_burn_durations_2_eem(EE_segments);
EE_burns_cycler3 = segment_burn_durations_3_eem(EE_segments);
EE_burns_cycler4 = segment_burn_durations_4_eem(EE_segments);
EM_burns_cycler1 = segment_burn_durations_1_eem(EM_segments);
EM_burns_cycler2 = segment_burn_durations_2_eem(EM_segments);
EM_burns_cycler3 = segment_burn_durations_3_eem(EM_segments);
EM_burns_cycler4 = segment_burn_durations_4_eem(EM_segments);
ME_burns_cycler1 = segment_burn_durations_1_eem(ME_segments);
ME_burns_cycler2 = segment_burn_durations_2_eem(ME_segments);
ME_burns_cycler3 = segment_burn_durations_3_eem(ME_segments);
ME_burns_cycler4 = segment_burn_durations_4_eem(ME_segments);
max_EE_cycler1 = max(EE_burns_cycler1);
max_EE_cycler2 = max(EE_burns_cycler2);
max_EE_cycler3 = max(EE_burns_cycler3);
max_EE_cycler4 = max(EE_burns_cycler4);
max_EM_cycler1 = max(EM_burns_cycler1);
max_EM_cycler2 = max(EM_burns_cycler2);
max_EM_cycler3 = max(EM_burns_cycler3);
max_EM_cycler4 = max(EM_burns_cycler4);
max_ME_cycler1 = max(ME_burns_cycler1);
max_ME_cycler2 = max(ME_burns_cycler2);
max_ME_cycler3 = max(ME_burns_cycler3);
max_ME_cycler4 = max(ME_burns_cycler4);

fileID = fopen('burn_data.txt', 'wt');
fprintf(fileID, 'Cycler \t Max Earth to Earth burn time (days) \t Max Earth to Mars burn time (days) \t Max Mars to Earth burn time (days)');
fprintf(fileID, '\n%.0f \t %f \t\t\t\t %f \t\t\t\t %f', 1, max_EE_cycler1, max_EM_cycler1, max_ME_cycler1);
fprintf(fileID, '\n%.0f \t %f \t\t\t\t %f \t\t\t\t %f', 2, max_EE_cycler2, max_EM_cycler2, max_ME_cycler2);
fprintf(fileID, '\n%.0f \t %f \t\t\t\t %f \t\t\t\t %f', 3, max_EE_cycler3, max_EM_cycler3, max_ME_cycler3);
fprintf(fileID, '\n%.0f \t %f \t\t\t\t %f \t\t\t\t %f', 4, max_EE_cycler4, max_EM_cycler4, max_ME_cycler4);
fclose(fileID);

%
%% Generate Relevant Plots
% Cycler 1 equivalent burn times with refueling every Earth flyby
figure(1)
x1_ee = {};
E = 'E';
cnt = 1;
for element = find(segment_burn_durations_1_ee)
    x1_ee{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_1_ee(find(segment_burn_durations_1_ee)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_1_ee)), 'xticklabel', x1_ee)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn Time (days)')
title('Cycler 1 Burn Times Refueling Every Earth Flyby')

% Cycler 2 equivalent burn times with refueling every Earth flyby
figure(2)
x2_ee = {};
cnt = 1;
for element = find(segment_burn_durations_2_ee)
    x2_ee{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_2_ee(find(segment_burn_durations_2_ee)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_2_ee)), 'xticklabel', x2_ee)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn Time (days)')
title('Cycler 2 Burn Times Refueling Every Earth Flyby')

% Cycler 3 equivalent burn times with refueling every Earth flyby
figure(3)
x3_ee = {};
cnt = 1;
for element = find(segment_burn_durations_3_ee)
    x3_ee{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_3_ee(find(segment_burn_durations_3_ee)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_3_ee)), 'xticklabel', x3_ee)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn Time (days)')
title('Cycler 3 Burn Times Refueling Every Earth Flyby')

% Cycler 4 equivalent burn times with refueling every Earth flyby
figure(4)
x4_ee = {};
cnt = 1;
for element = find(segment_burn_durations_4_ee)
    x4_ee{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_4_ee(find(segment_burn_durations_4_ee)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_4_ee)), 'xticklabel', x4_ee)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn Time (days)')
title('Cycler 4 Burn Times Refueling Every Earth Flyby')

% Max equivalent burn time with refueling every Earth flyby for all cyclers
figure(5)
max_ee = [max(segment_burn_durations_1_ee), max(segment_burn_durations_2_ee), max(segment_burn_durations_3_ee), max(segment_burn_durations_4_ee)];
bar(max_ee)
xlabel('Cycler Number')
ylabel('Equivalent Full Power Burn Time (days)')
title('Maxumum Burn Time for Each Cycler Refueling Every Earth Flyby')

% Cycler 1 equivalent burn times with refueling every embarking Earth flyby
figure(6)
x1_e = {};
cnt = 1;
for element = find(segment_burn_durations_1_e)
    x1_e{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_1_e(find(segment_burn_durations_1_e)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_1_e)), 'xticklabel', x1_e)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn time (days)')
title('Cycler 1 Burn Times Refueling Each Crewed Flyby')

% Cycler 2 equivalent burn times with refueling every embarking Earth flyby
figure(7)
x2_e = {};
cnt = 1;
for element = find(segment_burn_durations_2_e)
    x2_e{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_2_e(find(segment_burn_durations_2_e)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_2_e)), 'xticklabel', x2_e)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn time (days)')
title('Cycler 2 Burn Times Refueling Each Crewed Flyby')

% Cycler 3 equivalent burn times with refueling every embarking Earth flyby
figure(8)
x3_e = {};
cnt = 1;
for element = find(segment_burn_durations_3_e)
    x3_e{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_3_e(find(segment_burn_durations_3_e)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_3_e)), 'xticklabel', x3_e)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn time (days)')
title('Cycler 3 Burn Times Refueling Each Crewed Flyby')

% Cycler 1 equivalent burn times with refueling every embarking Earth flyby
figure(9)
x4_e = {};
cnt = 1;
for element = find(segment_burn_durations_4_e)
    x4_e{cnt} = strcat(E, string(element));
    cnt = cnt + 1;
end
bar(segment_burn_durations_4_e(find(segment_burn_durations_4_e)))
set(gca, 'xtick', 1:length(find(segment_burn_durations_4_e)), 'xticklabel', x4_e)
xlabel('Encounter Name')
ylabel('Equivalent Full Power Burn time (days)')
title('Cycler 4 Burn Times Refueling Each Crewed Flyby')

% Max equivalent burn time with refueling every crewed Earth flyby for all cyclers
figure(10)
max_e = [max(segment_burn_durations_1_e), max(segment_burn_durations_2_e), max(segment_burn_durations_3_e), max(segment_burn_durations_4_e)];
bar(max_e)
set(gca, 'FontSize', 20);
xlabel('Cycler Number', 'FontSize', 25)
ylabel('Equivalent Full Power Burn Time (days)', 'FontSize', 25)
title('Maximum Burn Time for Each Cycler Refueling Every Crewed Earth Flyby', 'FontSize', 30)

figure(11)
bar(segment_burn_durations_1_eem(find(segment_burn_durations_1_eem)))
xlabel('Encounter')
ylabel('Equivalent Full Power Burn Time (days)')
title('Burn Time for Cycler 1 Refueling Every Planetary Flyby')

figure(12)
bar(segment_burn_durations_2_eem(find(segment_burn_durations_2_eem)))
xlabel('Encounter')
ylabel('Equivalent Full Power Burn Time (days)')
title('Burn Time for Cycler 2 Refueling Every Planetary Flyby')

figure(13)
bar(segment_burn_durations_3_eem(find(segment_burn_durations_3_eem)))
xlabel('Encounter')
ylabel('Equivalent Full Power Burn Time (days)')
title('Burn Time for Cycler 3 Refueling Every Planetary Flyby')

figure(14)
bar(segment_burn_durations_4_eem(find(segment_burn_durations_4_eem)))
xlabel('Encounter')
ylabel('Equivalent Full Power Burn Time (days)')
title('Burn Time for Cycler 4 Refueling Every Planetary Flyby')
%}