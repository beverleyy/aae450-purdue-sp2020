clearvars
clc

%% Set up data
load Trajectory_Information.mat

index = [1 (2:2:49) 50];

encounter_pos_x = Trajectory.Vehicle1.body_encounters(index, 1);

encounter_pos_y = Trajectory.Vehicle1.body_encounters(index, 2);

encounter_pos_z = Trajectory.Vehicle1.body_encounters(index, 3);

encounter_pos = [encounter_pos_x, encounter_pos_y, encounter_pos_z];

cycler1 = xlsread('Hybrid_S1L1_v1.xlsx');
encounter_time = cycler1(:, 17);

%% Generate Earth Position
[x13, y13, z13, t13] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 1, 3, 0, 2);
[x34, y34, z34, t34] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 3, 4, 2, 4);
[x46, y46, z46, t46] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 4, 6, 4, 7);
[x67, y67, z67, t67] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 6, 7, 7, 8);
[x79, y79, z79, t79] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 7, 9, 8, 12);
[x910, y910, z910, t910] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 9, 10, 12, 12);
[x1012, y1012, z1012, t1012] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 10, 12, 12, 16);
[x1213, y1213, z1213, t1213] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 12, 13, 16, 17);
[x1315, y1315, z1315, t1315] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 13, 15, 17, 19);
[x1516, y1516, z1516, t1516] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 15, 16, 19, 21);
[x1618, y1618, z1618, t1618] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 16, 18, 21, 24);
[x1819, y1819, z1819, t1819] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 18, 19, 24, 25);
[x1921, y1921, z1921, t1921] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 19, 21, 25, 29);
[x2122, y2122, z2122, t2122] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 21, 22, 29, 29);
[x2224, y2224, z2224, t2224] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 22, 24, 29, 33);
[x2425, y2425, z2425, t2425] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 24, 25, 33, 34);

x_Earth = [x13, x34, x46, x67, x79, x910, x1012, x1213, x1315, x1516, x1618, x1819, x1921, x2122, x2224, x2425];
y_Earth = [y13, y34, y46, y67, y79, y910, y1012, y1213, y1315, y1516, y1618, y1819, y1921, y2122, y2224, y2425];
z_Earth = [z13, z34, z46, z67, z79, z910, z1012, z1213, z1315, z1516, z1618, z1819, z1921, z2122, z2224, z2425];
t_Earth = [t13, t34, t46, t67, t79, t910, t1012, t1213, t1315, t1516, t1618, t1819, t1921, t2122, t2224, t2425];

figure(1)
%plot3(encounter_pos_x(1), encounter_pos_y(1), encounter_pos_z(1), '*')
hold on
plot3(encounter_pos_x, encounter_pos_y, encounter_pos_z, '*')
%plot3(encounter_pos_x(4), encounter_pos_y(4), encounter_pos_z(4), '*')
%plot3(encounter_pos_x(6), encounter_pos_y(6), encounter_pos_z(6), '*')
plot3(x_Earth, y_Earth, z_Earth)
legend('Encounters','Earth')

%% Generate Mars Position
[x25, y25, z25, t25] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 2, 5, 0, 2);
[x58, y58, z58, t58] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 5, 8, 2, 4);
[x811, y811, z811, t811] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 8, 11, 4, 6);
[x1114, y1114, z1114, t1114] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 11, 14, 6, 9);
[x1417, y1417, z1417, t1417] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 14, 17, 9, 11);
[x1720, y1720, z1720, t1720] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 17, 20, 11, 13);
[x2023, y2023, z2023, t2023] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 20, 23, 13, 15);
[x2326, y2326, z2326, t2326] = linear_interp(encounter_pos_x, encounter_pos_y, encounter_pos_z, encounter_time, 23, 26, 15, 18);

x_Mars = [x25, x58, x811, x1114, x1417, x1720, x2023, x2326];
y_Mars = [y25, y58, y811, y1114, y1417, y1720, y2023, y2326];
z_Mars = [z25, z58, z811, z1114, z1417, z1720, z2023, z2326];
t_Mars = [t25, t58, t811, t1114, t1417, t1720, t2023, t2326];

figure(2)
hold on
plot3(encounter_pos_x, encounter_pos_y, encounter_pos_z, '*')
plot3(x_Mars, y_Mars, z_Mars)
legend('Encounters', 'Mars')
Earth_positions = [x_Earth; y_Earth; z_Earth];
Mars_positions = [x_Mars; y_Mars; z_Mars];