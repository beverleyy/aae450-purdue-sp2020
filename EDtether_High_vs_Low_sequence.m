% V2 : modification by Pierre VEZIN (M.D) 
% 01/02/2020
    
clc
clearvars
close all
    
%% Define Initial Parameters and Useful Numbers
mu_earth = 398600.4415;      %km^3/s^2 (gravitational parameter of Earth)
r_earth = 6378.136;          %km (mean equatorial radius of Earth)
h_taxi = 1500;               %km taxi release altitude
r_taxi = h_taxi+r_earth;

a_Luna = 384400;   %km (radius of Luna orbit)
g = 9.80665;       %m/s^2 (gravitational acceleration on Earth's surface)

m_taxi = 190000;        %kg (estimate from human factors of mass of taxi)
g_max = 2;               % Human factor consideration for max g load

v_LEO = (mu_earth/r_taxi)^.5; %km/s (orbital velocity of circular LEO)
TOF_target=1;                  %day desired time of flight from LEO to Luna

%% Compute Delta V for 1st transfer

% for Elliptic transfer to Luna (TOF>2.2days). We will compute a time of
% flight and the perigee velocity for a range of trajetcory
    n_points = 1000;
    a_max = 16*a_Luna;              %km maximum semi-major axis used
    a_hoh = .5*(r_taxi + a_Luna);   %km SMA of hohman transf
    a_range_ellipt = linspace(a_hoh, a_max, n_points/4); %km SMA range
    
    %Eccentrical anomaly of taxi when encounters Luna (ellipt. traj.)
    ecc_anomaly_arrival_ellipt_high = acos((a_range_ellipt - a_Luna)./...
            (a_range_ellipt - r_taxi));  %rad
    %Time of flight LEO luna
    TOF_days_ellipt_high = (ecc_anomaly_arrival_ellipt_high -...
        (1 -r_taxi./a_range_ellipt).*sin(ecc_anomaly_arrival_ellipt_high))./...
        (mu_earth./a_range_ellipt.^3).^.5 / 86400;  %days
    % Perigee velocity
    Vp_ellipt_high = (2*mu_earth/r_taxi - mu_earth./a_range_ellipt).^.5; %km/s

% for Hyperbolic transfer to Luna (TOF<2.2days)
    range_ratio = 100;
    a_range_hyp = linspace(r_taxi,range_ratio*r_taxi, n_points*3/4);
    e_range_hyp = r_taxi./a_range_hyp + 1;
    
    % Hyperbolic eccentrical anomaly at Luna Encounter 
    ecc_anomaly_arrival_hyp_high = acosh((a_range_hyp + a_Luna) ./...
        (e_range_hyp .* a_range_hyp));
    % Associated time of flight
    TOF_sec_hyp_high = (a_range_hyp.^3/mu_earth).^0.5.*...
        ((r_taxi./a_range_hyp+1) .* sinh(ecc_anomaly_arrival_hyp_high)...
        - ecc_anomaly_arrival_hyp_high); % sec
    TOF_days_hyp_high = TOF_sec_hyp_high/86400; % days
    
    % Associated Perigee velocity
    Vp_hyp_high = (mu_earth*(e_range_hyp+1)/r_taxi).^0.5;

% Concatenate results (elliptical and hyperbolic solutions) to get 1 array
    l1 = length(TOF_days_hyp_high);
    l2 = length(TOF_days_ellipt_high);
    TOF_days_high = TOF_days_hyp_high;
    TOF_days_high(l1+1 : l1+l2)=flip(TOF_days_ellipt_high); % TOF
    Vp_high=Vp_hyp_high;
    Vp_high(l1+1 : l1+l2)=flip(Vp_ellipt_high); % Perigee velocity

%% Compute tether length for every transfer TOFs
% We want exactly 2g of centrifugal acceleration at the tip, we want a tip
% velocity equal to the perigee velocity of Luna transfer trajectory. We
% set taxi release altitude: now tether length, max acceleration, tether
% velocity and tether altitude are bound together  with non linear
% equations (orbit mechanics) too complex to solve analytically. -->
% Iterative method to find the accurate optimal value for tether length.

% For a high swing profile (tether releases taxi above itself)
l_high_final = 0*ones(1,length(Vp_high));
j=1;
for v_perigee = Vp_high
    l_high = 500*ones(1,10);          %km initial guess for tether length 
    accu = 0.001;
    END = 0;
    l_test = 0*ones(1,10);
    i=1;
    while END ~= 1
        r_tether = r_taxi - l_high(i); 
        v_tether = sqrt(mu_earth/r_tether);
        
        l_test(i) = (v_perigee-v_tether)^2*1e3/g_max/9.81;
        err = (l_test(i)/l_high(i));
        
        l_high(i+1) = err*l_high(i);
        
        i=i+1;
        if i>1 && abs((l_high(i)-l_high(i-1))/l_high(i-1)) < accu
            END = 1;
        end
    end

    l_high_final(j) = l_high(i);
    j=j+1;
end

%%  For a low swing profile 
% Taxi leaves at low altitude and tether flies above

h_taxi = 400;               %km taxi release altitude
r_taxi = h_taxi+r_earth;

% for Elliptic transfer to Luna (TOF>2.2days)

    ecc_anomaly_arrival_ellipt_low = acos((a_range_ellipt - a_Luna)./...
            (a_range_ellipt - r_taxi));  %rad (ecc anomaly @ Luna arrival)
    TOF_days_ellipt_low = (ecc_anomaly_arrival_ellipt_high -...
        (1 -r_taxi./a_range_ellipt).*sin(ecc_anomaly_arrival_ellipt_high))./...
        (mu_earth./a_range_ellipt.^3).^.5 / 86400;  %seconds (ToF LEO-Luna)
    %Orbital parameters we compute the perigee velocity
    Vp_ellipt_low = (2*mu_earth/r_taxi - mu_earth./a_range_ellipt).^.5; %km/s

    % for Hyperbolic transfer to Luna

    ecc_anomaly_arrival_hyp_low = acosh((a_range_hyp + a_Luna) ./...
        (e_range_hyp .* a_range_hyp));
    TOF_sec_hyp_high = (a_range_hyp.^3/mu_earth).^0.5.*...
        ((r_taxi./a_range_hyp+1) .* sinh(ecc_anomaly_arrival_hyp_low)...
        - ecc_anomaly_arrival_hyp_low);
    TOF_days_hyp_low = TOF_sec_hyp_high/86400;

    Vp_hyp_low = (mu_earth*(e_range_hyp+1)/r_taxi).^0.5;

    % Concatenate results (elliptical and hyperbolic solutions)
    l1 = length(TOF_days_hyp_low);
    l2 = length(TOF_days_ellipt_high);
    TOF_days_low = TOF_days_hyp_low;
    TOF_days_low(l1+1 : l1+l2)=flip(TOF_days_ellipt_high);
    Vp_low=Vp_hyp_low;
    Vp_low(l1+1 : l1+l2)=flip(Vp_ellipt_low);

l_low_final = 0*ones(1,length(Vp_low));
j=1;
for v_perigee = Vp_low


    l_low = 500*ones(1,10);                            %km initial guess for tether length 
    err=0;
    l_test = 0*ones(1,10);

    accu = 0.01;
    END = 0;

    i=1;
    while END ~= 1
        r_tether = r_taxi + l_low(i); 
        v_tether(j) = sqrt(mu_earth/(r_tether));
        
        l_test(i) = (v_perigee-v_tether(j))^2*1e3/g_max/9.81;
        err = (l_test(i)/l_low(i));
        
        l_low(i+1) = err*l_low(i);
        
        i=i+1;
        if i>1 && abs((l_low(i)-l_low(i-1))/l_low(i-1)) < accu
            END = 1;
        end
    end

    l_low_final(j) = l_low(i);
    j=j+1;
end
figure
    hold on
    title('Taxi velocity and tether length Vs TOF (High Swing)')
    yyaxis 'left'
    ylim([5 15])

        plot(TOF_days_high, Vp_high, ':r')
        plot(TOF_days_low, Vp_low, ':b') 
    xlabel('Time Of flight (days)')
    ylabel('Taxi Velocity (km/s)')
    yyaxis right
    ylim([0 2000])
        plot(TOF_days_high, l_high_final, '-r')
        plot(TOF_days_low, l_low_final, '-b')
    ylabel('Tether length (km)')
    legend('V_p (high swing)', 'V_p (low swing', 'L_t (high)', 'L_t (low)')
    grid
    hold off

    

