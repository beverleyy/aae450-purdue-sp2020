function [i, raan, aop, v_dep, v_arr, TA_dep, TA_arr, e] = transfer_arc_creater(p,a, mu, r_arr, r_dep, TA)

    %calculate eccentricity
    e =  sqrt(1 - (p / a));
    r_arr_mag = norm(r_arr);
    r_dep_mag = norm(r_dep);
    
    
    %calculate periods
    period_sec = 2 * pi * sqrt(a^3 / mu); %s
    period_days = period_sec / (24 * 3600); %days

    %use f and g functions to calculate velocities for arrival and
    %departure

    f = 1 - (r_arr_mag / p) * (1 - cosd(TA));
    g = r_arr_mag * r_dep_mag * sind(TA) / (sqrt(mu * p));
    v_dep = (r_arr - f * r_dep) / g;
    v_dep_mag = norm(v_dep);

    f_dot = (dot(r_dep, v_dep) / (p * r_dep_mag)) * (1 - cosd(TA)) ...
        - (1 / r_dep_mag) * sqrt(mu / p) * sind(TA);
    g_dot = 1 - (r_dep_mag / p) * (1 - cosd(TA));
    v_arr = f_dot * r_dep + g_dot * v_dep;
    v_arr_mag = norm(v_arr);

    %need to check if v_arr or v_dep came out to be inf based on too low
    %tof
    
    if (v_dep_mag > 1e8) || (v_arr_mag > 1e8) || (isnan(v_dep_mag)) || (isnan(v_arr_mag))
        %assign valus that will not be accepted before breaking
        i=0; raan=0; aop=0; v_dep=[1e12,1e12,1e12]; 
        v_arr=[1e12, 1e12, 1e12]; TA_dep=0; TA_arr=0; e=0;
        return
    end
    
    %get h_vec, h_mag, and h_hat to be used for RAAN and i calculations
    h_vec = cross(r_dep, v_dep);
    h_mag = norm(h_vec);
    h_hat = h_vec / h_mag;
    
    i = acosd(h_hat(3));
    
    %get raan combos for quad check
    raan1 = acosd(h_hat(2) / (-1 * sind(i)));
    raan2 = -1 * raan1;
    raan3 = asind(h_hat(1) / sind(i));
    if (raan3 > 0)
        raan4 = 180 - raan3;
    else
        raan4 = -1*(180 + raan3);
    end
    
    %run the quad check
    if abs(raan1 - raan3) < 0.5
        raan = raan1;
    elseif abs(raan1 - raan4) < 0.5
        raan = raan1;
    elseif abs(raan2 - raan3) < 0.5
        raan = raan2;
    elseif abs(raan2 - raan4) < 0.5
        raan = raan2;
    else
        fprintf(2, 'Error on quad check for RAAN')
    end
    
    %repeat this process for theta
    %get theta combos for quad check
    r_dep_hat = r_dep / norm(r_dep);
    theta_hat_dep = cross(h_hat, r_dep_hat);
    theta1 = acosd(theta_hat_dep(3)/ sind(i));
    theta2 = theta1*-1;
    theta3 = asind((r_dep(3)/norm(r_dep)) / sind(i));
    if (theta3 > 0)
        theta4 = 180 - theta3;
    else
        theta4 = -1*(180 + theta3);
    end
    
    %run theta quad check - 0.5 is arbitrarily small enough value to
    %determine right angle here
    if abs(theta1 - theta3) < 0.5
        theta = theta1;
    elseif abs(theta1 - theta4) < 0.5
        theta = theta1;
    elseif abs(theta2 - theta3) < 0.5
        theta = theta2;
    elseif abs(theta2 - theta4) < 0.5
        theta = theta2;
    else
        fprintf(2, 'Error on quad check for theta')
    end
    
    %need to get TA at dep on the transfer arc to determine AOP now
    TA_dep = acosd( (1/e) * (p / r_dep_mag - 1));
    TA_arr = acosd( (1/e) * (p / r_arr_mag - 1));
    
    %determine if we are ascending or descending
    r_dot = dot(v_dep, r_dep_hat);
    
    if (r_dot >= 0) %ascending
         TA_dep = acosd( (1/e) * (p / r_dep_mag - 1));
         TA_arr = acosd( (1/e) * (p / r_arr_mag - 1));
    else %descending
         TA_dep = -1 * acosd( (1/e) * (p / r_dep_mag - 1));
         TA_arr = -1 * acosd( (1/e) * (p / r_arr_mag - 1));
    end
    
    aop = theta - TA_dep;
    
end