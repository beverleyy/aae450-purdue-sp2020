clc; clear all;

%when running, need following functions in current directory:
%lambert_iterator.m
%lambert_solver_with_tof.m
%transfer_arc_creator.m

%all cycler data needs to be located within folder in directory 
% called: 'data'
%cycler data should keep standard naming convention given in zip files

%createa a folder called Results in the directory you run from.  excel
%summary files will be thrown in there (the files will contain a basic
%table but contains the important data from the run for reference

%expect a run to take a few minutes -- theres lots of data and lots of
%iterations happening

%TODO
%hard code all inclinations of each location launching from (this should be equivalent to planet i)

%assuming step size is costant---or close to it!!
%currently using ideal cycler trajectory with simulated (uncontrolled)
%cycler velocity (not exact but best we got at this point)

%when running -- put inclination tolerance to 90 if you dont care - should
%capture everything with that

mu = 1.32712440018 * 10^11; %km^3/s^2

%input needed stuff from user
cycler_input = input('Input which cycler you want :  ', 's');
fprintf('\n')
leg_input = input('Input which leg you want (if entering multiple- start with 1st numerically) :  ', 's');
fprintf('\n')
multiple_leg_inp = input('Would you like to add another leg (0 for no -- 1 for yes) :  ');
fprintf('\n')

if multiple_leg_inp == 0
    file_to_scan = strcat('data/Cycler', cycler_input, '_Leg', leg_input, '.txt');
    
    %use this later to write table
    file_to_write = strcat('Results/Cycler', cycler_input, '_Leg', leg_input);

    %read in the data file of interest
    fid = fopen(file_to_scan, 'r');

    %read first line of labels
    labels = fgets(fid);
    
    %read in the entire text file data
    %data format: Time_array,SunX,Sun_Y,Sun_Z,Sun_U,Sun_V,Sun_W,Earth_X,Earth_Y,Earth_Z,Earth_U,Earth_V,Earth_W,Moon_X,Moon_Y,Moon_Z,Moon_U,Moon_V,Moon_W,Mars_X,Mars_Y,Mars_Z,Mars_U,Mars_V,Mars_W,Phobos_X,Phobos_Y,Phobos_Z,Phobos_U,Phobos_V,Phobos_W,Cycler_X_simulated,Cycler_Y_simulated,Cycler_Z_simulated,Cycler_U_simulated,Cycler_V_simulated,Cycler_W_simulated,Cycler_X_desired,Cycler_Y_desired,Cycler_Z_desired
    formatSpec = '%f, %f, %f, %f, %f, %f,%f, %f, %f, %f, %f, %f, %f, %f, %f, %f,%f, %f, %f, %f,%f, %f, %f, %f, %f, %f,%f, %f, %f, %f,%f, %f, %f, %f, %f, %f,%f, %f, %f, %f\n';
    sizeA = [40, inf];
    data = fscanf(fid,formatSpec,sizeA);
    %put data into columns
    data = data';
    fclose(fid);
elseif (multiple_leg_inp == 1)
    additional_leg = input('Indicate the additional leg (should be the next number numerically) :  ', 's');
    fprintf('\n')
    
    %enter all data
    file_to_scan = strcat('data/Cycler', cycler_input, '_Leg', leg_input, '.txt');
    
    %will use later to write table
    file_to_write = strcat('Results/Cycler', cycler_input, '_Leg', leg_input, '_and_leg', additional_leg);

    %read in the data file of interest
    fid = fopen(file_to_scan, 'r');

    %read first line of labels
    labels = fgets(fid);
    
    %read in the entire text file data for 1st leg indicated
    %data format: Time_array,SunX,Sun_Y,Sun_Z,Sun_U,Sun_V,Sun_W,Earth_X,Earth_Y,Earth_Z,Earth_U,Earth_V,Earth_W,Moon_X,Moon_Y,Moon_Z,Moon_U,Moon_V,Moon_W,Mars_X,Mars_Y,Mars_Z,Mars_U,Mars_V,Mars_W,Phobos_X,Phobos_Y,Phobos_Z,Phobos_U,Phobos_V,Phobos_W,Cycler_X_simulated,Cycler_Y_simulated,Cycler_Z_simulated,Cycler_U_simulated,Cycler_V_simulated,Cycler_W_simulated,Cycler_X_desired,Cycler_Y_desired,Cycler_Z_desired
    formatSpec = '%f, %f, %f, %f, %f, %f,%f, %f, %f, %f, %f, %f, %f, %f, %f, %f,%f, %f, %f, %f,%f, %f, %f, %f, %f, %f,%f, %f, %f, %f,%f, %f, %f, %f, %f, %f,%f, %f, %f, %f\n';
    sizeA = [40, inf];
    data1 = fscanf(fid,formatSpec,sizeA);
    %put data into columns
    data1 = data1';
    fclose(fid);

    %open second file to add data points together

    %read in the data file of interest
    file_to_scan = strcat('data/Cycler', cycler_input, '_Leg', num2str(additional_leg), '.txt');
    fid = fopen(file_to_scan, 'r');

    %read first line of labels
    labels = fgets(fid);

    %read in the entire text file data
    %data format: Time_array,SunX,Sun_Y,Sun_Z,Sun_U,Sun_V,Sun_W,Earth_X,Earth_Y,Earth_Z,Earth_U,Earth_V,Earth_W,Moon_X,Moon_Y,Moon_Z,Moon_U,Moon_V,Moon_W,Mars_X,Mars_Y,Mars_Z,Mars_U,Mars_V,Mars_W,Phobos_X,Phobos_Y,Phobos_Z,Phobos_U,Phobos_V,Phobos_W,Cycler_X_simulated,Cycler_Y_simulated,Cycler_Z_simulated,Cycler_U_simulated,Cycler_V_simulated,Cycler_W_simulated,Cycler_X_desired,Cycler_Y_desired,Cycler_Z_desired
    formatSpec = '%f, %f, %f, %f, %f, %f,%f, %f, %f, %f, %f, %f, %f, %f, %f, %f,%f, %f, %f, %f,%f, %f, %f, %f, %f, %f,%f, %f, %f, %f,%f, %f, %f, %f, %f, %f,%f, %f, %f, %f\n';
    sizeA = [40, inf];
    data2 = fscanf(fid,formatSpec,sizeA);
    data2 = data2';

    %get total data array for 1 and 2
    data = [data1;data2];
end



tof_test = str2num(input('Enter the max tof to allow (days) :  ', 's')); 
fprintf('\n')
tof_min = str2num(input('Enter the min tof to allow (days) :  ', 's'));
fprintf('\n')
inc_tol = str2num(input('Please enter an inclination tolerance (deg) :  ', 's'));
fprintf('\n')



%start assigning stuff
time_arr = data(:, 1);

%when calculating, want everything with respect to sun -- sun is shifting
%slightly so need to account for this
sun_pos_arr = [data(:,2), data(:,3), data(:,4)]/ 1000;
sun_vel_arr = [data(:,5), data(:,6), data(:,7)] / 1000;
earth_pos_arr = [data(:,8), data(:,9), data(:,10)]/ 1000 - sun_pos_arr;
earth_vel_arr = [data(:,11), data(:,12), data(:,13)]/1000- sun_vel_arr;
moon_pos_arr = [data(:,14), data(:,15), data(:,16)]/1000- sun_pos_arr;
moon_vel_arr = [data(:,17), data(:,18), data(:,19)]/1000- sun_vel_arr;
mars_pos_arr = [data(:,20), data(:,21), data(:,22)]/1000- sun_pos_arr;
mars_vel_arr = [data(:,23), data(:,24), data(:,25)]/1000- sun_vel_arr;
phobos_pos_arr = [data(:,26), data(:,27), data(:,28)]/1000 - sun_pos_arr;
phobos_vel_arr = [data(:,29), data(:,30), data(:,31)]/1000- sun_vel_arr;

%currently using cycler ideal position with simulated velocities since desired has no velocities

%the commented out one is the simulated cycler position
%cycler_pos_arr = [data(:,32), data(:,33), data(:,34)]/1000;
cycler_vel_arr = [data(:,35), data(:,36), data(:,37)]/1000 - sun_vel_arr;
cycler_pos_arr = [data(:,38), data(:,39), data(:,40)]/1000- sun_pos_arr;

%set up a few parameters
data_len = length(time_arr);

%compute time step and index points to step backwards 8 days
time_step_days = time_arr(2) - time_arr(1);
index_steps_days = floor( (6 / time_step_days));


%get closest approach in this leg between cycler and earth
earth_min_cyc = earth_pos_arr - cycler_pos_arr;
for i=1:data_len
    norm_earth_cyc(i) = norm(earth_min_cyc(i,:));
end
closest_approach_earth_cyc = min(norm_earth_cyc);
closest_approach_earth_cyc_ind = find(norm_earth_cyc==closest_approach_earth_cyc);

%get closest approach in this leg between cycler and moon
moon_min_cyc = moon_pos_arr - cycler_pos_arr;
for i=1:data_len
    norm_moon_cyc(i) = norm(moon_min_cyc(i, :));
    
end
closest_approach_moon_cyc = min(norm_moon_cyc);
closest_approach_moon_cyc_ind = find(norm_moon_cyc==closest_approach_moon_cyc);

%get closest approach in this leg between cycler and mars
mars_min_cyc = mars_pos_arr - cycler_pos_arr;
for i=1:data_len
    norm_mars_cyc(i) = norm(mars_min_cyc(i, :));
    
end
closest_approach_mars_cyc = min(norm_mars_cyc);
closest_approach_mars_cyc_ind = find(norm_mars_cyc==closest_approach_mars_cyc);

%get closest approach in this leg between cycler and phobos
phobos_min_cyc = phobos_pos_arr - cycler_pos_arr;
for i=1:data_len
    norm_phobos_cyc(i) = norm(phobos_min_cyc(i, :));
end
closest_approach_phobos_cyc = min(norm_phobos_cyc);
closest_approach_phobos_cyc_ind = find(norm_phobos_cyc==closest_approach_phobos_cyc);

%get closest approach in this leg between moon and earth
moon_min_earth = earth_pos_arr - moon_pos_arr;
for i=1:data_len
    norm_moon_earth(i) = norm(moon_min_earth(i, :));
end
closest_approach_moon_earth = min(norm_moon_earth);
closest_approach_moon_earth_ind = find(norm_moon_earth==closest_approach_moon_earth);

%get closest approach in this leg between phobos and mars
phobos_min_mars = phobos_pos_arr - mars_pos_arr;
for i=1:data_len
    norm_phobos_mars(i) = norm(phobos_min_mars(i, :));
end
closest_approach_phobos_mars = min(norm_phobos_mars);
closest_approach_phobos_mars_ind = find(norm_phobos_mars==closest_approach_phobos_mars);

%create switch case to evaluate which part of leg to evaluate for, given
fprintf('User input guide to select the correct transfer\n')
fprintf('Earth-Cycler (0)\tEarth-Moon (1)\t\tMoon-Cycler (2) \tCycler-Earth (3)\tMoon-Earth (4)\n')
fprintf('Cycler-Moon (5)\t\tPhobos-Cycler (6)\tPhobos-Mars (7)\t\tMars-Cycler (8)\n')
fprintf('Cycler-Phobos (9)\tMars-Phobos (10)\tCycler-Mars (11)\n')
which_case = input('\nEnter a number to select a transfer to investigate :   ');

switch which_case
    case 0
        %Earth-cycler
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_earth_cyc_ind - index_steps_days) >= 0) && ((closest_approach_earth_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_pos = cycler_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_vel = cycler_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            time_arr_cycler_earth = time_arr((closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_earth_cyc_ind - index_steps_days) < 0) && ((closest_approach_earth_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_pos = cycler_pos_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_vel = cycler_vel_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            time_arr_cycler_earth = time_arr(1: (closest_approach_earth_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_earth_cyc_ind - index_steps_days) < 0) && ((closest_approach_earth_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: end,: );
            trimmed_earth_vel = earth_vel_arr( 1: end,: );
            trimmed_cycler_earth_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_earth_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_earth = time_arr(1: end );
        elseif ((closest_approach_earth_cyc_ind - index_steps_days) >= 0) && ((closest_approach_earth_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_earth_pos = cycler_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_earth_vel = cycler_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_earth = time_arr((closest_approach_earth_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_earth_pos,  trimmed_earth_vel,time_arr_cycler_earth, trimmed_cycler_earth_pos , trimmed_cycler_earth_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        earth_to_cycler_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_earth_to_cycler.xlsx');
        writetable(earth_to_cycler_leg,file_to_write)
        
    case 1
        %earth-moon
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_moon_earth_ind - index_steps_days) >= 0) && ((closest_approach_moon_earth_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            time_arr_moon_earth = time_arr((closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_earth_ind - index_steps_days) < 0) && ((closest_approach_moon_earth_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_pos = moon_pos_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            time_arr_moon_earth = time_arr(1: (closest_approach_moon_earth_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_earth_ind - index_steps_days) < 0) && ((closest_approach_moon_earth_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: end,: );
            trimmed_earth_vel = earth_vel_arr( 1: end,: );
            trimmed_moon_pos = moon_pos_arr( 1: end,: );
            trimmed_moon_vel = moon_vel_arr( 1: end,: );
            time_arr_moon_earth = time_arr(1: end );
        elseif ((closest_approach_moon_earth_ind - index_steps_days) >= 0) && ((closest_approach_moon_earth_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            time_arr_moon_earth = time_arr((closest_approach_moon_earth_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_earth_pos,  trimmed_earth_vel,time_arr_moon_earth, trimmed_moon_pos , trimmed_moon_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        earth_to_moon_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_earth_to_moon.xlsx');
        writetable(earth_to_moon_leg,file_to_write)
    case 2
        %moon-cycler
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_moon_cyc_ind - index_steps_days) >= 0) && ((closest_approach_moon_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_pos = cycler_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_vel = cycler_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            time_arr_cycler_moon = time_arr((closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_cyc_ind - index_steps_days) < 0) && ((closest_approach_moon_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_pos = cycler_pos_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_vel = cycler_vel_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            time_arr_cycler_moon = time_arr(1: (closest_approach_moon_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_cyc_ind - index_steps_days) < 0) && ((closest_approach_moon_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( 1: end,: );
            trimmed_moon_vel = moon_vel_arr( 1: end,: );
            trimmed_cycler_moon_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_moon_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_moon = time_arr(1: end );
        elseif ((closest_approach_moon_cyc_ind - index_steps_days) >= 0) && ((closest_approach_moon_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_moon_pos = cycler_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_moon_vel = cycler_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_moon = time_arr((closest_approach_moon_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_moon_pos,  trimmed_moon_vel,time_arr_cycler_moon, trimmed_cycler_moon_pos , trimmed_cycler_moon_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        moon_to_cycler_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_moon_to_cycler.xlsx');
        writetable(moon_to_cycler_leg,file_to_write)
        
    case 3
        %cycler-earth
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_earth_cyc_ind - index_steps_days) >= 0) && ((closest_approach_earth_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_pos = cycler_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_vel = cycler_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days),: );
            time_arr_cycler_earth = time_arr((closest_approach_earth_cyc_ind - index_steps_days): (closest_approach_earth_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_earth_cyc_ind - index_steps_days) < 0) && ((closest_approach_earth_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_pos = cycler_pos_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            trimmed_cycler_earth_vel = cycler_vel_arr( 1: (closest_approach_earth_cyc_ind + index_steps_days),: );
            time_arr_cycler_earth = time_arr(1: (closest_approach_earth_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_earth_cyc_ind - index_steps_days) < 0) && ((closest_approach_earth_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: end,: );
            trimmed_earth_vel = earth_vel_arr( 1: end,: );
            trimmed_cycler_earth_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_earth_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_earth = time_arr(1: end );
        elseif ((closest_approach_earth_cyc_ind - index_steps_days) >= 0) && ((closest_approach_earth_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_earth_pos = cycler_pos_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_earth_vel = cycler_vel_arr( (closest_approach_earth_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_earth = time_arr((closest_approach_earth_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_cycler_earth_pos , trimmed_cycler_earth_vel,time_arr_cycler_earth, trimmed_earth_pos,  trimmed_earth_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        cycler_to_earth_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_cycler_to_earth.xlsx');
        writetable(cycler_to_earth_leg,file_to_write)
        
    case 4
        %Moon-earth
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_moon_earth_ind - index_steps_days) >= 0) && ((closest_approach_moon_earth_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days),: );
            time_arr_moon_earth = time_arr((closest_approach_moon_earth_ind - index_steps_days): (closest_approach_moon_earth_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_earth_ind - index_steps_days) < 0) && ((closest_approach_moon_earth_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_earth_vel = earth_vel_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_pos = moon_pos_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( 1: (closest_approach_moon_earth_ind + index_steps_days),: );
            time_arr_moon_earth = time_arr(1: (closest_approach_moon_earth_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_earth_ind - index_steps_days) < 0) && ((closest_approach_moon_earth_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( 1: end,: );
            trimmed_earth_vel = earth_vel_arr( 1: end,: );
            trimmed_moon_pos = moon_pos_arr( 1: end,: );
            trimmed_moon_vel = moon_vel_arr( 1: end,: );
            time_arr_moon_earth = time_arr(1: end );
        elseif ((closest_approach_moon_earth_ind - index_steps_days) >= 0) && ((closest_approach_moon_earth_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_earth_pos = earth_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            trimmed_earth_vel = earth_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_earth_ind - index_steps_days): end,: );
            time_arr_moon_earth = time_arr((closest_approach_moon_earth_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_moon_pos , trimmed_moon_vel,time_arr_moon_earth, trimmed_earth_pos,  trimmed_earth_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        moon_to_earth_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_moon_to_earth.xlsx');
        writetable(moon_to_earth_leg,file_to_write)
        
    case 5
        %cycler-moon
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_moon_cyc_ind - index_steps_days) >= 0) && ((closest_approach_moon_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_pos = cycler_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_vel = cycler_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days),: );
            time_arr_cycler_moon = time_arr((closest_approach_moon_cyc_ind - index_steps_days): (closest_approach_moon_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_cyc_ind - index_steps_days) < 0) && ((closest_approach_moon_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_moon_vel = moon_vel_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_pos = cycler_pos_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            trimmed_cycler_moon_vel = cycler_vel_arr( 1: (closest_approach_moon_cyc_ind + index_steps_days),: );
            time_arr_cycler_moon = time_arr(1: (closest_approach_moon_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_moon_cyc_ind - index_steps_days) < 0) && ((closest_approach_moon_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( 1: end,: );
            trimmed_moon_vel = moon_vel_arr( 1: end,: );
            trimmed_cycler_moon_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_moon_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_moon = time_arr(1: end );
        elseif ((closest_approach_moon_cyc_ind - index_steps_days) >= 0) && ((closest_approach_moon_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_moon_pos = moon_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            trimmed_moon_vel = moon_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_moon_pos = cycler_pos_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_moon_vel = cycler_vel_arr( (closest_approach_moon_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_moon = time_arr((closest_approach_moon_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_cycler_moon_pos , trimmed_cycler_moon_vel,time_arr_cycler_moon, trimmed_moon_pos,  trimmed_moon_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        cycler_to_moon_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_cycler_to_moon.xlsx');
        writetable(cycler_to_moon_leg,file_to_write)
        
    case 6
        %phobos-cycler
        
        
        %create an arry to iterate over for only phobos to cycle about closest
        %approach
        if ((closest_approach_phobos_cyc_ind - index_steps_days) >= 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            time_arr_cycler_phobos = time_arr((closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_cyc_ind - index_steps_days) < 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            time_arr_cycler_phobos = time_arr(1: (closest_approach_phobos_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_cyc_ind - index_steps_days) < 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( 1: end,: );
            trimmed_phobos_vel = phobos_vel_arr( 1: end,: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_phobos = time_arr(1: end );
        elseif ((closest_approach_phobos_cyc_ind - index_steps_days) >= 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_phobos = time_arr((closest_approach_phobos_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_phobos_pos,  trimmed_phobos_vel,time_arr_cycler_phobos, trimmed_cycler_phobos_pos , trimmed_cycler_phobos_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        phobos_to_cycler_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_phobos_to_cycler.xlsx');
        writetable(phobos_to_cycler_leg,file_to_write)
        
    case 7
        %phobos-mars
        
        %create an arry to iterate over for only phobos to cycle about closest
        %approach
        if ((closest_approach_phobos_mars_ind - index_steps_days) >= 0) && ((closest_approach_phobos_mars_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            time_arr_phobos_mars = time_arr((closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_mars_ind - index_steps_days) < 0) && ((closest_approach_phobos_mars_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_pos = phobos_pos_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            time_arr_phobos_mars = time_arr(1: (closest_approach_phobos_mars_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_mars_ind - index_steps_days) < 0) && ((closest_approach_phobos_mars_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: end,: );
            trimmed_mars_vel = mars_vel_arr( 1: end,: );
            trimmed_phobos_pos = phobos_pos_arr( 1: end,: );
            trimmed_phobos_vel = phobos_vel_arr( 1: end,: );
            time_arr_phobos_mars = time_arr(1: end );
        elseif ((closest_approach_phobos_mars_ind - index_steps_days) >= 0) && ((closest_approach_phobos_mars_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            time_arr_phobos_mars = time_arr((closest_approach_phobos_mars_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_phobos_pos , trimmed_phobos_vel, time_arr_phobos_mars, trimmed_mars_pos,  trimmed_mars_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        phobos_to_mars = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_phobos_to_mars.xlsx');
        writetable(phobos_to_mars,file_to_write);
    case 9
        %mars-cycler
        
        %create an arry to iterate over for only earth to cycle about closest
        %approach
        if ((closest_approach_mars_cyc_ind - index_steps_days) >= 0) && ((closest_approach_mars_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_pos = cycler_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_vel = cycler_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            time_arr_cycler_mars = time_arr((closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_mars_cyc_ind - index_steps_days) < 0) && ((closest_approach_mars_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_pos = cycler_pos_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_vel = cycler_vel_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            time_arr_cycler_mars = time_arr(1: (closest_approach_mars_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_mars_cyc_ind - index_steps_days) < 0) && ((closest_approach_mars_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: end,: );
            trimmed_mars_vel = mars_vel_arr( 1: end,: );
            trimmed_cycler_mars_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_mars_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_mars = time_arr(1: end );
        elseif ((closest_approach_mars_cyc_ind - index_steps_days) >= 0) && ((closest_approach_mars_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_mars_pos = cycler_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_mars_vel = cycler_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_mars = time_arr((closest_approach_mars_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_mars_pos,  trimmed_mars_vel,time_arr_cycler_mars, trimmed_cycler_mars_pos , trimmed_cycler_mars_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        mars_to_cycler_leg = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_mars_to_cycler.xlsx');
        writetable(mars_to_cycler_leg,file_to_write)
        
    case 9
        %cycler-phobos
        
        %create an arry to iterate over for only phobos to cycle about closest
        %approach
        if ((closest_approach_phobos_cyc_ind - index_steps_days) >= 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days),: );
            time_arr_cycler_phobos = time_arr((closest_approach_phobos_cyc_ind - index_steps_days): (closest_approach_phobos_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_cyc_ind - index_steps_days) < 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( 1: (closest_approach_phobos_cyc_ind + index_steps_days),: );
            time_arr_cycler_phobos = time_arr(1: (closest_approach_phobos_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_cyc_ind - index_steps_days) < 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( 1: end,: );
            trimmed_phobos_vel = phobos_vel_arr( 1: end,: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_phobos = time_arr(1: end );
        elseif ((closest_approach_phobos_cyc_ind - index_steps_days) >= 0) && ((closest_approach_phobos_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_phobos_pos = cycler_pos_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_phobos_vel = cycler_vel_arr( (closest_approach_phobos_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_phobos = time_arr((closest_approach_phobos_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_cycler_phobos_pos , trimmed_cycler_phobos_vel, time_arr_cycler_phobos, trimmed_phobos_pos,  trimmed_phobos_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        cycler_to_phobos = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_cycler_to_phobos.xlsx');
        writetable(cycler_to_phobos,file_to_write);
        
    case 10
        %mars-phobos
        
        %create an arry to iterate over for only phobos to cycle about closest
        %approach
        if ((closest_approach_phobos_mars_ind - index_steps_days) >= 0) && ((closest_approach_phobos_mars_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days),: );
            time_arr_phobos_mars = time_arr((closest_approach_phobos_mars_ind - index_steps_days): (closest_approach_phobos_mars_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_mars_ind - index_steps_days) < 0) && ((closest_approach_phobos_mars_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_pos = phobos_pos_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            trimmed_phobos_vel = phobos_vel_arr( 1: (closest_approach_phobos_mars_ind + index_steps_days),: );
            time_arr_phobos_mars = time_arr(1: (closest_approach_phobos_mars_ind + index_steps_days) );
            
        elseif ((closest_approach_phobos_mars_ind - index_steps_days) < 0) && ((closest_approach_phobos_mars_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: end,: );
            trimmed_mars_vel = mars_vel_arr( 1: end,: );
            trimmed_phobos_pos = phobos_pos_arr( 1: end,: );
            trimmed_phobos_vel = phobos_vel_arr( 1: end,: );
            time_arr_phobos_mars = time_arr(1: end );
        elseif ((closest_approach_phobos_mars_ind - index_steps_days) >= 0) && ((closest_approach_phobos_mars_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            trimmed_phobos_pos = phobos_pos_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            trimmed_phobos_vel = phobos_vel_arr( (closest_approach_phobos_mars_ind - index_steps_days): end,: );
            time_arr_phobos_mars = time_arr((closest_approach_phobos_mars_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_mars_pos,  trimmed_mars_vel, time_arr_phobos_mars, trimmed_phobos_pos , trimmed_phobos_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        mars_to_phobos = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_mars_to_phobos.xlsx');
        writetable(mars_to_phobos,file_to_write);
        
    case 11
        %cycler-mars
        
        %create an arry to iterate over for only phobos to cycle about closest
        %approach
        if ((closest_approach_mars_cyc_ind - index_steps_days) >= 0) && ((closest_approach_mars_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is within lower and upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_pos = cycler_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_vel = cycler_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days),: );
            time_arr_cycler_mars = time_arr((closest_approach_mars_cyc_ind - index_steps_days): (closest_approach_mars_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_mars_cyc_ind - index_steps_days) < 0) && ((closest_approach_mars_cyc_ind + index_steps_days) <= data_len)
            %execute if search index is not within lower but is within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_mars_vel = mars_vel_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_pos = cycler_pos_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            trimmed_cycler_mars_vel = cycler_vel_arr( 1: (closest_approach_mars_cyc_ind + index_steps_days),: );
            time_arr_cycler_mars = time_arr(1: (closest_approach_mars_cyc_ind + index_steps_days) );
            
        elseif ((closest_approach_mars_cyc_ind - index_steps_days) < 0) && ((closest_approach_mars_cyc_ind + index_steps_days) > data_len)
            %execute if search index is not within upper or lower bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( 1: end,: );
            trimmed_mars_vel = mars_vel_arr( 1: end,: );
            trimmed_cycler_mars_pos = cycler_pos_arr( 1: end,: );
            trimmed_cycler_mars_vel = cycler_vel_arr( 1: end,: );
            time_arr_cycler_mars = time_arr(1: end );
        elseif ((closest_approach_mars_cyc_ind - index_steps_days) >= 0) && ((closest_approach_mars_cyc_ind + index_steps_days) > data_len)
            %execute if search index is within lower and not within upper bounds of
            %data array
            trimmed_mars_pos = mars_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            trimmed_mars_vel = mars_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_mars_pos = cycler_pos_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            trimmed_cycler_mars_vel = cycler_vel_arr( (closest_approach_mars_cyc_ind - index_steps_days): end,: );
            time_arr_cycler_mars = time_arr((closest_approach_mars_cyc_ind - index_steps_days): end );
        end

        [min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
            = lambert_iterator(trimmed_cycler_mars_pos , trimmed_cycler_mars_vel, time_arr_cycler_mars, trimmed_mars_pos,  trimmed_mars_vel, ...
            90, mu, tof_test, inc_tol, tof_min);
        
        cycler_to_mars = table(min_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
            min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
            min_r_vec_dep, min_i, min_a, min_p, min_TA_deg, min_raan, min_aop, min_e, inc_tol, tof_test, tof_min)
        
        %all files written to a results directory within the current folder
        file_to_write = strcat(file_to_write, '_cycler_to_mars.xlsx');
        writetable(cycler_to_mars,file_to_write);
        
end


fprintf('\nFile written to: %s', file_to_write)
fprintf('\n\nIterator has finished running!\n')
