clc
clearvars
close all
format compact

%% I: Compute trajectory Parameters for Tether, Taxi, Velocities, Rates 
% Define Initial Parameters and Useful Numbers
    mu_earth = 398600.4415;    %km^3/s^2
    r_earth = 6378.136;        %km
    a_Luna = 384400;           %km (radius of Lunar orbit)
    g = 9.81;                  %m/s^2 (acceleration on Earth's surface)
    
     
%Design Parameters
    %Mission Design input based on Code "HighSwing"
    total_length = 570;             %km tether length
    taxi_release_alt1 = 1500;       %km altitude @ first taxi  release
    TOF_target=1;                   %day desired TOF from LEO to Luna
    taxi_release_rad1 = taxi_release_alt1 + r_earth;% Corresponding Radius    
    %Mass input based on Work from J.Tiberi, S.Lachs
    m_tether = 19827;                   %Mg Tether mass
    m_hub = 63828;                      %Mg hub+arm mass
    m_taxi = 189.3;                     %Mg Taxi Mass
    % Momentum Bank Mass 
        % Hub is so heavy, there is no need to size the momentum bank with
        % regard to orbital height loss anymore. We keep 30000 mt because
        % it is the last value and allows for sufficient Moment of Inertia.
    m_momentum = 30000;             %Mg
    %Compile these mass in a ratio (easier to use in calcs)
    m_ratio = m_taxi/(m_tether+m_momentum+m_hub);
    %Center of Mass location along tether and real rotational radius
    dist_hub_Cm = 1/(m_taxi+m_momentum+m_tether+m_hub)*...
               (m_taxi*total_length+m_tether*total_length/4);   %km
    rot_tether_length = total_length-dist_hub_Cm;               %km

%% Compute Delta V for 1st transfer
% Kepler Equations are full of trig and hyperbolic trig function so no
% anaytical solution -> numerical solver used
    syms SMA;               % unkwown is semi major axis of trajectory
    
    % governing equation is the equation of motion on hyperbolic trajectory
    eqn = sqrt(SMA^3/mu_earth)*((taxi_release_rad1/SMA+1)*...
        sinh(acosh((SMA+a_Luna)/(taxi_release_rad1+SMA))) -...
        acosh((SMA+a_Luna)/(taxi_release_rad1+SMA))) == 86400*TOF_target; 
    
    a_hyp1 = double(vpasolve(eqn,SMA));    %km solution for semi major axis
    e_hyp1 = taxi_release_rad1/a_hyp1+1;   %/ associated eccentricity
    alpha1 = acosd(1/e_hyp1);              %rad Asymptotic angle
    beta1 = 90-alpha1;
    Vp_1 = (mu_earth*(e_hyp1+1)/taxi_release_rad1).^0.5; %km/s Perigee Vel.

    



%% Mission Profile
     tether_orbit_radius1 = taxi_release_rad1 -...
         rot_tether_length;      %km orbital radius of tether CoM in orbit
     tether_velocity1 = sqrt(mu_earth/...
           tether_orbit_radius1);%km/s start on circular orbit
     tether_rate1 = (Vp_1-tether_velocity1)/...
         rot_tether_length;      %rad/s angular rate at release
     tether_gload1 = tether_rate1^2*rot_tether_length*...
         1000/g;                 %g radial acceleration
     taxi_DV1 = (Vp_1 - tether_velocity1)*...
                2;               %km/s total speed gain of the taxi
            
     %Tether loses momentum (Velocity):
     tether_DV1 = taxi_DV1*m_ratio;
     %Tether new perigee:
     tether_orbit_radius2 = 2*(tether_orbit_radius1*mu_earth/...
         (2*mu_earth - tether_orbit_radius1*...
         (tether_velocity1-tether_DV1)^2))-tether_orbit_radius1; %km

%% Second Launch :
% second launch take place when tether is in an elliptical orbit. The first
% launch dropped the perigee X lower than the previous circular orbit

% New Orbital parameters
    taxi_release_radius2  = tether_orbit_radius2 + rot_tether_length;
    taxi_release_alt2     = taxi_release_radius2 - r_earth;
% Using Hyperblic keplerian mechanics, compute Semi Major Axis of transfer
% hyperbola for TOF of 1 day
    syms SMA;
    eqn     = sqrt(SMA^3/mu_earth)*((taxi_release_radius2/SMA+1)*...
            sinh(acosh((SMA+a_Luna)/(taxi_release_radius2+SMA))) -...
            acosh((SMA+a_Luna)/(taxi_release_radius2+SMA))) == 86400*...
                                                            TOF_target; 
    a_hyp2  = double(vpasolve(eqn,SMA));     %km SMA of Hyperbola
    e_hyp2  = taxi_release_radius2/a_hyp2+1; %/ Eccentricity
    alpha2 = acosd(1/e_hyp2);                %deg Asymptotic angle
    beta2 = 90-alpha2;                  %deg Ejection angle wrt Nodal Line
    Vp_2    = (mu_earth*(e_hyp2+1)/...
        taxi_release_radius2).^0.5;          %km/s perigee Velocity

    tether_orbit_radius2    = taxi_release_radius2 - rot_tether_length; 
    tether_velocity2        = (mu_earth*(2/tether_orbit_radius2-2/...
                                (tether_orbit_radius2 +...
                                tether_orbit_radius1)))^0.5;
    tether_rate2            = (Vp_2-tether_velocity2)/rot_tether_length;
    tether_gload2           = tether_rate2^2*rot_tether_length*1000/g;
    % Extract maximum gload among the two launches
    tether_maxg             = max([tether_gload1 tether_gload2]);

%% Apogee drop after release of second taxi

taxi_DV2 = (Vp_2 - tether_velocity2)*2;    %km/s Total speed gain for taxi
tether_DV2 = m_ratio*taxi_DV2;             %km/s Total speed loss for tether

% Compute tether apogee drop after second launch:
tether_perigee2 = 2*(tether_orbit_radius2*mu_earth/...
    (2*mu_earth - tether_orbit_radius2*(tether_velocity2-tether_DV2)^2))...
    -tether_orbit_radius2;

%% Display outputs
disp ('System Design Parameters :')
disp (['Taxi Mass : ', num2str(m_taxi), ' Mg'])
disp (['Tether Mass : ', num2str(m_tether), ' Mg'])
disp (['Hub+Arm Mass : ', num2str(m_hub), ' Mg'])
disp (['Momentum bank mass : ', num2str(m_momentum), ' Mg'])
disp (['Tether Total Length : ', num2str(total_length), ' km'])
disp (['Tether Rotational Radius : ', num2str(rot_tether_length),...
        ' km || distance Hub to CoM : ', num2str(dist_hub_Cm), ' km'])
disp ('-----------------------------------------------------------------')
disp ('First Launch :')
disp (['TOF : ', num2str(TOF_target), ' days'])
disp (['Taxi Release Altitude : ', num2str(taxi_release_alt1), ' km'])
disp (['Taxi Release Velocity : ', num2str(Vp_1), ' km/s'])
disp (['Tether Rotational Length : ', num2str(rot_tether_length), ' km'])
disp (['Tether Altitude :', num2str(tether_orbit_radius1-r_earth), ' km'])
disp (['Tether velocity :', num2str(tether_velocity1), ' km/s'])
disp (['Taxi Pick Up Altitude : ', num2str(taxi_release_alt1-2*...
                                            rot_tether_length), ' km'])
disp (['Taxi Pick Up Velocity : ',num2str(2*tether_velocity1-Vp_1),'km/s'])
disp(['Angular Rate : ', num2str(tether_rate1), ' rad/s'])
disp (' ')

disp("------------------------------------------------------------------")
disp ('Second Launch :')
disp (['TOF : ', num2str(TOF_target), ' days'])
disp (['Taxi Release Altitude : ', num2str(taxi_release_alt2), ' km'])
disp (['Taxi Release Velocity : ', num2str(Vp_2), ' km/s'])
disp (['Tether Rotational Length : ', num2str(rot_tether_length), ' km'])
disp (['Tether Altitude :', num2str(tether_orbit_radius2-r_earth), ' km'])
disp (['Tether velocity :', num2str(tether_velocity2), ' km/s'])
disp (['Taxi Pick Up Altitude : ',num2str(taxi_release_alt2-2*...
                                            rot_tether_length), ' km'])
disp (['Taxi Pick Up Velocity : ',num2str(2*tether_velocity2-Vp_2),'km/s'])
disp(['Angular Rate : ', num2str(tether_rate2), ' rad/s'])
disp("------------------------------------------------------------")
disp('Orbital parameters after second launch :')
disp(['Tether perigee : ', num2str(min([tether_orbit_radius2-r_earth,...
                                    tether_perigee2-r_earth ] )), ' km'])
disp(['Tether apogee : ', num2str(max([tether_orbit_radius2-r_earth,...
                                    tether_perigee2-r_earth ] )), ' km'])
disp(['Tether Total DeltaV loss : ',num2str(tether_DV1+tether_DV2),'km/s'])
disp(" ")
disp(['Maximum Gload : ', num2str(max([tether_gload1 tether_gload2])),'g']) 

%------------------------------------------------------------------------
%% II Plot rendez vous trajectory:
% Trajectory plotted here is a demonstration trajectory that uses the
% orbital parameters of te first taxi launch. Proportions can be distorted
% tohighlight the relative motion
animation = 1; % set animation to other than zero for the animation to run

if animation ~= 0  
timespan = 15*60;            %sec Duration of simulation
step     = 10;               %sec high quality = small step
t=(-timespan:step:timespan); %sec Timespan of simulation
scale_factor = 1;            % increase diensions (do not exceed 2)


% Tether trajectory for demo launch:
    tether_traj    = (tether_orbit_radius1)*...
    [-sin(tether_velocity1/tether_orbit_radius1*t);cos(tether_velocity1/...
                                            tether_orbit_radius1*t)];
    tethertip_traj = tether_traj + scale_factor*...
                        [rot_tether_length*sin(tether_rate1*t);
                         -rot_tether_length*cos(tether_rate1*t)];

% Taxi trajectory for demo launch;
    % Elliptical trajectory (suborbital flight) parameters:
    ra = tether_orbit_radius1 - scale_factor*...
                        rot_tether_length; %km radius of apogee
    va = tether_velocity1-taxi_DV1*...
                        scale_factor/2;    %km/s velocity at apogee
    sma = ra*mu_earth/(2*mu_earth-ra*va^2);%km semi major ax
    ecc = ra/sma-1;                        %/ eccentricity
    period = 2*pi*sqrt(sma^3/mu_earth);    %sec Orbital period
   
    %Numerical solver is used to compute position over time on the ellipse
    syms EA;                               %rad Eccentric Anomaly
    k=1;
    taxi_EA = 0*ones(1,length(t));         % memory allocation for speed
    for time = t
       eqn = EA - ecc*sin(EA) == 2*pi/period.*(time+period/2);
       taxi_EA(k)=double(vpasolve(eqn,EA));%rad eccAnomaly @ t=time
       k=k+1;
    end
    % taxi x-y trajectory is stored in 2D array
     taxi_traj = [sma*sqrt(1-ecc^2)*sin(taxi_EA) 
                 -sma*(cos(taxi_EA)-ecc)];
             
% Get position of taxi on surface of Earth before it leaves ground 
    % Use Elliptic equation to compute ecc anomaly from r=r_earth
    EA_start = acos(1/ecc-(r_earth-(scale_factor-1)*...
               rot_tether_length)/sma/ecc);                 
    % Store x-y departure position in array
    taxi_start = [sma*sqrt(1-ecc^2)*sin(EA_start)   
                        -sma*(cos(EA_start)-ecc)];
% Get the time of departure of the taxi (from the ground) - Numerically
    syms time
    eqn = 2*pi/period*(time+period/2) == EA_start - ecc*sin(EA_start);
    t_start = double(vpasolve(eqn, time));
% get the indexes associated with different events (rendezvous, release)
    index_dep = round((t_start+timespan)/2/timespan*length(t));  
    index_rdv = round(length(t)/2);                              
    
% the following loop detects array index for taxi release. To do so it
% searches for the moment the tether tip radius reaches a maximum
% -> grad(r)=0
    k=index_rdv;          %We start from rdv, not the beginning (shorter)
    while tethertip_traj(1,k)^2+tethertip_traj(2,k)^2 <...
            tethertip_traj(1,k+1)^2+tethertip_traj(2,k+1)^2
        k=k+1;
    end
    index_rel = k;
    
    % based on taxi orbital parameters, rdv time, departure time etc, let's
    % recompute the taxi trajectory by concatnating the different segments
    taxi_traj_real=taxi_traj;
    taxi_traj_real(:,1:index_dep)=taxi_start*ones(1,index_dep);
    taxi_traj_real(:,index_rdv:index_rel)=...
                            tethertip_traj(:,index_rdv:index_rel);
    % The Hyperbolic trajectory is displayed as a straight line (simpler)
    taxi_traj_real(:,index_rel+1:length(t))=taxi_traj_real(:,index_rel)*...
            ones(1,length(t)-index_rel)+(taxi_traj_real(:,index_rel)...
            -taxi_traj_real(:,index_rel-1))*(1:1:length(t)-index_rel);
        
% Start animated plot:
fig = figure;
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set(gca, 'DataAspectRatio', [1 1 1])   % Get us a nice square aspect ratio
axis([-7000 3500 3000 8000])
hold on
% Plot permanen lines for earth surface, tether trajectory, taxi trajectory
plot(tether_traj(1,:), tether_traj(2,:),':b',...
    tethertip_traj(1,:), tethertip_traj(2,:),  ':r',...
    taxi_traj(1,:),taxi_traj(2,:), ':',...
        linspace(0,r_earth-(scale_factor-1)*rot_tether_length,4000).*...
            cos(linspace(0,200*pi,4000)),...
        linspace(0,r_earth-(scale_factor-1)*rot_tether_length,4000).*...
            sin(linspace(0,200*pi,4000)), ':b',...
        (r_earth-(scale_factor-1)*rot_tether_length).*...
            cos(linspace(0,2*pi,4000)),...
        (r_earth-(scale_factor-1)*rot_tether_length).*...
            sin(linspace(0,2*pi,4000)),'-b')

% plot tether motion
index_anim_start = round(3/4*index_dep); % array index at which plot starts
im={};                                   % array storing successive images

for i=(index_anim_start:1:length(t))
    % Plot all elements (tether is a short line, taxi is a circle...)            
    tether_plot = plot([tethertip_traj(1,i) tether_traj(1,i)],...
        [tethertip_traj(2,i) tether_traj(2,i)], 'r');
    tether_trace = plot([tethertip_traj(1,i) tether_traj(1,i)],...
        [tethertip_traj(2,i) tether_traj(2,i)], ':r');
    hub_plot    = plot(tether_traj(1,i), tether_traj(2,i), 'ok');
    taxi_plot   = plot(taxi_traj_real(1,i), taxi_traj_real(2,i), 'ob');
    taxi_trace = plot(taxi_traj_real(1,i), taxi_traj_real(2,i), '.b');
    
    drawnow
    frame = getframe(fig);                     %save current frame
    im{i+1-index_anim_start} = frame2im(frame);%store it in array
    
    delete(tether_plot)                      %remove current tether drawing
    delete(hub_plot)                         %remove current hub drawing
    delete(taxi_plot)                        %remove current taxi drawing

end %repeat for entire trajectory
% Save images as GIF:
    filename = 'testGIF.GIF';
    for i =(1:1:length(im))
       [A,map] = rgb2ind(im{i},64);
       if i==round(1)
       imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.05);
       else
       imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.05);
       end
     end
end

 %% Plot tether CM full trajectory from launch 1 to Re-Boost
ecc_anomaly = linspace(0,2*pi,2000);
%Initial tether orbit 
    orbit1 = [tether_orbit_radius1*cos(ecc_anomaly);...
              tether_orbit_radius1*sin(ecc_anomaly)];
% Tether orbit after second Launch
    tether_sma2 = (tether_orbit_radius1+tether_orbit_radius2)/2;
    tether_ecc2=max([tether_orbit_radius2, tether_perigee2])/tether_sma2-1;
    orbit2 = [tether_sma2*(cos(ecc_anomaly)-tether_ecc2);
              tether_sma2*sqrt(1-tether_ecc2^2)*sin(ecc_anomaly)];
%Tether orbit after 2nd launch (circular)
    tether_sma3 = (tether_perigee2+tether_orbit_radius2)/2;
    tether_ecc3=max([tether_orbit_radius2 tether_perigee2])/tether_sma3-1;
    orbit3 = [tether_sma3*(cos(ecc_anomaly)-tether_ecc3);
              tether_sma3*sqrt(1-tether_ecc3^2)*sin(ecc_anomaly)];
           
figure
plot(orbit1(1,:), orbit1(2,:),'-r',...
    orbit2(1,:), orbit2(2,:),':m',...
    orbit3(1,:), orbit3(2,:),'-b',...
    r_earth*cos(ecc_anomaly),r_earth*sin(ecc_anomaly),'-k');
set(gca, 'DataAspectRatio', [1 1 1])
title('ED tether''s different Orbits')
legend('Initial', 'Intermediate','Final', 'Earth')