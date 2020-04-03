function [minimium_delta_v, min_TOF, min_arr_MJD, min_dep_MJD, min_delta_v_dep_vec, ...
    min_delta_v_arr_vec, min_delta_v_dep_mag, min_delta_v_arr_mag, min_r_vec_arr, ...
    min_r_vec_dep, min_i, min_a, min_type, min_p, min_TA_deg, min_raan, min_aop, min_e]...
    = lambert_iterator(r_array_dep, v_array_dep, julian_array,r_array_arr, ...
    v_array_arr, planet_i, mu, max_TOF, i_tol, tof_min)

%% Inputs
%{
all arrays MUST have indices synchronized to same julian dates

r_array_dep : large array of position vectors of the departing planet
(x,y,z inertial) [km/s]

v_array_dep : large array of velocity vectors of the departing planet
(x,y,z inertial) [km/s]

julian_array : large array of modified julian days that has indices 
corresponding to the arriving and departing ephemerides [days]

r_array_arr : large array of position vectors of the arriving planet
(x,y,z inertial) [km/s]

v_array_arr : large array of velocity vectors of the arriving planet
(x,y,z inertial) [km/s]

planet_i: inclination of the departing planet to be used to find transfer
arc with similar inclination to avoid plane change [deg]

mu : gravitational parameter of central body [km^3/s^2]

max_TOF : set maximum allowable TOF that solutions will be selected from
[days]

i_tol : the allowable tolerance for inclination of transfer arc to vary
from departing planet inclination [deg]
%}

%% Initialization
minimium_delta_v = 1e12;
min_TOF = 100*24*3600;
min_arr_MJD = 1e12;
min_dep_MJD = 1e12;
min_delta_v_dep_vec = 1e12;
min_delta_v_arr_vec = 1e12;
min_delta_v_dep_mag = 1e12;
min_delta_v_arr_mag = 1e12;
min_r_vec_arr = 1e12;
min_r_vec_dep = 1e12;

%orbital elements
min_i =1e12;
min_a = 1e12;
min_type = 1e12;
min_p = 1e12;
min_TA_deg = 1e12;
min_raan = 1e12;
min_aop = 1e12;
min_e = 1e12;
count = 0;


%% Computations
for dep = 1:length(julian_array)
    for arr = ((dep + 1):5:length(julian_array))
        
        if ((julian_array(arr) - julian_array(dep)) < max_TOF) && ((julian_array(arr) - julian_array(dep)) > tof_min)
            count = count+1;
            %execute if TOF is less than max
            curr_TOF = julian_array(arr) - julian_array(dep);
            
            [curr_a, curr_type, curr_P, curr_TA_deg] = lambert_solver_with_tof((curr_TOF*24*3600), r_array_dep(dep, :), r_array_arr(arr, :), mu);
            [curr_i, curr_raan, curr_aop, curr_v_dep, curr_v_arr, curr_TA_dep, curr_TA_arr, curr_e] = transfer_arc_creater(curr_P,curr_a, mu, r_array_arr(arr,:), r_array_dep(dep,:), curr_TA_deg);
            

            %first check if i is within allowable range of departing planet
            if (curr_i <= (planet_i + i_tol)) && (curr_i >= (planet_i - i_tol))
                %execute if curr_i is within tolerance
                
                delta_v_array_dep = curr_v_dep - v_array_dep(dep,:);
                delta_v_array_arr = curr_v_arr - v_array_arr(arr,:);

                mag_delta_v_dep = norm(delta_v_array_dep);
                mag_delta_v_arr = norm(delta_v_array_arr);
                curr_mag_total_delta_v = mag_delta_v_dep + mag_delta_v_arr;

                if (curr_mag_total_delta_v < minimium_delta_v)
                    %execute if curr total deltaV is new lowest

                    %deltaV, MJD, TOF, and positions
                    minimium_delta_v = curr_mag_total_delta_v;
                    min_TOF = curr_TOF;
                    min_arr_MJD = julian_array(arr);
                    min_dep_MJD = julian_array(dep);
                    min_delta_v_dep_vec = delta_v_array_dep;
                    min_delta_v_arr_vec = delta_v_array_arr;
                    min_delta_v_dep_mag = mag_delta_v_dep;
                    min_delta_v_arr_mag = mag_delta_v_arr;
                    min_r_vec_arr = r_array_arr(arr,:);
                    min_r_vec_dep = r_array_dep(dep,:);

                    %orbital elements
                    min_i = curr_i;
                    min_a = curr_a;
                    min_type = curr_type;
                    min_p = curr_P;
                    min_TA_deg = curr_TA_deg;
                    min_raan = curr_raan;
                    min_aop = curr_aop;
                    min_e = curr_e;
                end
            end
        end
    end
end

%all cases have been run --- check to see if no transfers were found to the
%case
if (minimium_delta_v == 1e12)
    fprintf(2, '\nError! No solution was found!\n')
else
    fprintf('\nLambert Iterator has successfully run!\n')
    fprintf('\nTOF:       \t %.3f  hours', min_TOF*24)
    fprintf('\nDeltaV Dep:\t %.4f  km/s', min_delta_v_dep_mag)
    fprintf('\nDeltaV Arr:\t %.4f  km/s', min_delta_v_arr_mag)
    fprintf('\nDeltaV Tot:\t %.4f  km/s', minimium_delta_v)
    fprintf('\nTransfer type:\t %s', min_type)
    fprintf('\nTransfer i: \t %.4f deg', min_i)
    fprintf('\nRan %d iterations!', count)
end
end
                
            

