clc
clearvars
close all
format compact

%% Define Initial Parameters and Useful Numbers
    mu_earth = 398600.4415;         %km^3/s^2 (gravitational parameter of Earth)
    r_earth = 6378.136;             %km (mean equatorial radius of Earth)
    a_Luna = 384400;                %km (radius of Lunar orbit around Earth assuming circular orbit)
    g = 9.81;                       %m/s^2 (gravitational acceleration on Earth's surface)
    max_g = 2;                      % Human factor consideration for max g load
     
%Design parameters Parameters
    taxi_release_alt1 = 1500;       %km altitude at which first taxi is released by tether
    taxi_release_rad1 = taxi_release_alt1 + r_earth;    
    
    m_tether = 19827;                           %Mg Tether mass + hub + arm
    m_taxi = 189.3;                             %Mg Taxi Mass
    total_length = 570;                         %km tether length 
    
    TOF_target=1;                   %day desired time of flight from LEO to Luna

%% Compute Delta V for 1st transfer
% Kepler Equations are full of trig and hyperbolic trig function so no
% anaytical solution -> numerical solver used
    syms SMA;               % unkwown is semi major axis of trajectory
    
    % governing equation is the equation of motion on hyperbolic trajectory
    eqn = sqrt(SMA^3/mu_earth)*((taxi_release_rad1/SMA+1)*sinh(acosh((SMA+a_Luna)/(taxi_release_rad1+SMA))) - acosh((SMA+a_Luna)/(taxi_release_rad1+SMA))) == 86400*TOF_target; 
    
    a_hyp1 = double(vpasolve(eqn,SMA));                      % solution for semi major axis
    e_hyp1 = taxi_release_rad1/a_hyp1+1;                     % associated eccentricity
    alpha1 = acosd(1/e_hyp1);                                %Asymptotic angle
    beta1 = 90-alpha1;
    Vp_1 = (mu_earth*(e_hyp1+1)/taxi_release_rad1).^0.5;     % velocity at perigee of hyperbola (at taxi release 1)

    

%% Momentum Bank Mass Solver
    % --> MOM BANK mass is determined based on mission profile (orbit drop)
    % requirements. Mmission profile is dependant on position center of 
    % mass of the tether (because it affects real rotational center)
    % finally center of mass depends on MOM BANK <--
    % We have an open loop, we will estimate m_mom and then iterate
    % until it converge
tol = 0.01;            % relative error at which iterations stop
i=1;
m_mom(i) = 30000;       %Mg Initial value for momentum bank
while i<2 || abs(m_mom(i)-m_mom(i-1)) >= tol*m_mom(i)
%% Mission Profile
% Compute CM location and real rotational radius
    pos_Cm = 1/(m_taxi+m_mom(i)+m_tether)*(m_taxi*total_length+m_tether*total_length/4);                                    %km distance hub-Cm
    rot_tether_length = total_length-pos_Cm;

    tether_orbit_radius1 = taxi_release_rad1 - rot_tether_length;   %km orbital radius of tether CM in orbit
    tether_velocity1 = sqrt(mu_earth/tether_orbit_radius1);         %km/s start on circular orbit
    tether_rate1 = (Vp_1-tether_velocity1)/rot_tether_length;       %rad/s angular rate at release
    tether_gload1 = tether_rate1^2*rot_tether_length*1000/g;        %g radial acceleration

    taxi_DV1 = (Vp_1 - tether_velocity1)*2;


%% Tether DeltaV Loss:  
% mass is calculated so that perigee drop of the tether does not exceed
% a certain distance
    max_drop = 100;                             %km

% Momentum bank mass caltetculation
    r_perigee  = tether_orbit_radius1 - max_drop;                                     % semi major axis of tether orbit after release
    tether_velocity_post = (mu_earth*(2/tether_orbit_radius1-2/(tether_orbit_radius1+r_perigee)))^0.5;        % Aopgee Velocity of tether after release (slowed down)
    tether_DV1 = tether_velocity1 - tether_velocity_post;

    m_mom(i+1) = m_taxi * taxi_DV1/tether_DV1 - m_tether;

i=i+1;
end
% Store final value
    m_momentum=m_mom(i);
    m_ratio = m_taxi/(m_tether+m_momentum);

% Housekeeping
    clear i j k l a_hoh a_ max a_range_hyp a_range_ellipt e_range_hyp ecc_anomaly_arrival_ellipt ecc_anomaly_arrival_hyp
    clear END err index l_test n_points range_ratio t TOF_days_ellipt TOF_days_hyp TOF_sec_hyp v_LEO Vp_ellipt Vp_hyp
    clear TOF_days Vp


%% Second Launch :
% second launch take place when tether is in an elliptical orbit. The first
% launch dropped the perigee 100km lower than the previous circular orbit.

% new Orbital parameters

    taxi_release_radius2  = taxi_release_rad1 - max_drop;
    taxi_release_alt2     = taxi_release_alt1 - max_drop;
% Using Hyperblic keplerian mechanics, compute Semi Major Axis of transfer
% hyperbola for TOF of 1 day

    syms SMA;
    eqn     = sqrt(SMA^3/mu_earth)*((taxi_release_radius2/SMA+1)*sinh(acosh((SMA+a_Luna)/(taxi_release_radius2+SMA))) - acosh((SMA+a_Luna)/(taxi_release_radius2+SMA))) == 86400*TOF_target; 
    a_hyp2  = double(vpasolve(eqn,SMA));
    e_hyp2  = taxi_release_radius2/a_hyp2+1;
    alpha2 = acosd(1/e_hyp2);                        %Asymptotic angle
    beta2 = 90-alpha2;
    Vp_2    = (mu_earth*(e_hyp2+1)/taxi_release_radius2).^0.5;


    tether_orbit_radius2    = taxi_release_radius2 - rot_tether_length; 
    tether_velocity2        = (mu_earth*(2/tether_orbit_radius2-2/(tether_orbit_radius2 + tether_orbit_radius1)))^0.5;
    tether_rate2            = (Vp_2-tether_velocity2)/rot_tether_length;
    tether_gload2           = tether_rate2^2*rot_tether_length*1000/g;
    tether_maxg             = max([tether_gload1 tether_gload2]);



%% Apogee drop after release of second taxi

taxi_DV2 = (Vp_2 - tether_velocity2)*2;
tether_DV2 = m_ratio*taxi_DV2;

tether_perigee2 = 2*(tether_orbit_radius2*mu_earth/(2*mu_earth - tether_orbit_radius2*(tether_velocity2-tether_DV2)^2))-tether_orbit_radius2;




%% outputs
disp ('System Design Parameters :')
disp (['Taxi Mass : ', num2str(m_taxi), ' Mg'])
disp (['Tether Mass : ', num2str(m_tether), ' Mg'])
disp (['Momentum Bank Mass : ', num2str(m_momentum), ' Mg'])
disp (['Tether Total Length : ', num2str(total_length), ' km'])
disp (['Tether Rotational Radius : ', num2str(rot_tether_length), ' km || distance Hub -> CoM : ', num2str(pos_Cm), ' km'])
disp ('-----------------------------------------------------------------')
disp ('First Launch :')
disp (['TOF : ', num2str(TOF_target), ' days'])
disp (['Taxi Release Altitude : ', num2str(taxi_release_alt1), ' km'])
disp (['Taxi Release Velocity : ', num2str(Vp_1), ' km/s'])
disp (['Tether Length : ', num2str(rot_tether_length), ' km'])
disp (['Tether Altitude :', num2str(tether_orbit_radius1-r_earth), ' km'])
disp (['Tether velocity :', num2str(tether_velocity1), ' km/s'])
disp (['Taxi Pick Up Altitude : ', num2str(taxi_release_alt1-2*rot_tether_length), ' km'])
disp (['Taxi Pick Up Velocity : ', num2str(2*tether_velocity1-Vp_1), ' km/s'])
disp(['Angular Rate : ', num2str(tether_rate1), ' rad/s'])
disp (' ')
disp (['Maximum altitude loss : ', num2str(max_drop), ' km'])
disp (['Momentum bank mass : ', num2str(m_momentum), ' Mg'])
disp("------------------------------------------------------------------")
disp ('Second Launch :')
disp (['TOF : ', num2str(TOF_target), ' days'])
disp (['Taxi Release Altitude : ', num2str(taxi_release_alt2), ' km'])
disp (['Taxi Release Velocity : ', num2str(Vp_2), ' km/s'])
disp (['Tether Length : ', num2str(rot_tether_length), ' km'])
disp (['Tether Altitude :', num2str(tether_orbit_radius2-r_earth), ' km'])
disp (['Tether velocity :', num2str(tether_velocity2), ' km/s'])
disp (['Taxi Pick Up Altitude : ', num2str(taxi_release_alt2-2*rot_tether_length), ' km'])
disp (['Taxi Pick Up Velocity : ', num2str(2*tether_velocity2-Vp_2), ' km/s'])
disp(['Angular Rate : ', num2str(tether_rate2), ' rad/s'])
disp("------------------------------------------------------------")
disp('Orbital parameters after second launch :')
disp(['Tether perigee : ', num2str(min( [ tether_orbit_radius2-r_earth    tether_perigee2-r_earth ] )), ' km'])
disp(['Tether apogee : ', num2str(max( [ tether_orbit_radius2-r_earth    tether_perigee2-r_earth ] )), ' km'])
disp(['Tether Total DeltaV loss : ', num2str(tether_DV1+tether_DV2), ' km/s'])
disp(" ")
disp(['Maximum Gload : ', num2str(max([tether_gload1 tether_gload2])), 'g' ]) 

%% Plot rendez vous trajectory:

timespan = 10*60;               %sec Duration of simulation
step     = 1;                   %sec 
t=[-1.5*timespan : step : 2*timespan];

% Tether traj for first launch:
tether_traj1    = (tether_orbit_radius1)*[-sin(tether_velocity1/tether_orbit_radius1*t);cos(tether_velocity1/tether_orbit_radius1*t)];
tethertip_traj1 = tether_traj1 + 1.5*[rot_tether_length*sin(tether_rate1*t); -rot_tether_length*cos(tether_rate1*t)];

% Taxi traj for first launch;
% taxi_park_rad1  = taxi_release_rad1-2*rot_tether_length;
% taxi_vel1       = sqrt(mu_earth/taxi_park_rad1);
% taxi_traj1      = taxi_park_rad1*[sin(taxi_vel1/taxi_park_rad1*t); cos(taxi_vel1/taxi_park_rad1*t)];

figure
set(gca, 'DataAspectRatio', [1 1 1])        % Get us a nice square aspect ratio
hold on
plot(tether_traj1(1,:), tether_traj1(2,:),...
    tethertip_traj1(1,:), tethertip_traj1(2,:),  ':')

% plot tether motion
step_visu = 20;                      %steps between 2 updates
a=0.4;
b=0.8;
c=0.1;

a_cond = 1;
b_cond = 1;
c_cond = 1;
increment = 0.05;
for i=[1:step_visu:length(t)]
    if mod((i-1)/step_visu,3) == 0
        if a_cond > 0
            if a+increment > 1
            a_cond = -1;
            a=mod(a-increment,1);
            else
            a=mod(a+increment,1);
            end
        elseif a_cond < 0
            if a-increment < 0
            a_cond = 1;
            a=mod(a+increment,1);
            else
            a=mod(a-increment,1);  
            end
        end
    elseif mod((i-1)/step_visu+1,3) == 0
        if b_cond > 0
            if b+increment > 1
            b_cond = -1;
            b=mod(b-increment,1);
            else
            b=mod(b+increment,1);
            end
        elseif b_cond < 0
            if b-increment < 0
            b_cond = 1;
            b=mod(b+increment,1);
            else
            b=mod(b-increment,1);  
            end
        end
    elseif mod((i-1)/step_visu+2,3)==0
        if c_cond > 0
            if c+increment > 1
            c_cond = -1;
            c=mod(c-increment,1);
            else
            c=mod(c+increment,1);
            end
        elseif c_cond < 0
            if c-increment < 0
            c_cond = 1;
            c=mod(c+increment,1);
            else
            c=mod(c-increment,1);  
            end
        end
        

    end
            
    plot([tethertip_traj1(1,i) tether_traj1(1,i)],[tethertip_traj1(2,i) tether_traj1(2,i)], 'Color', [a b c]);
    pause(0.1)
%     [(i-1)/step_visu a b c]
end