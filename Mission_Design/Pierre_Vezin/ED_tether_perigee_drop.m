clc
close all
clear all

%% Useful metrics
mu_earth = 398600.4415; %km^3/s^2 (gravitational parameter of Earth)

r_earth = 6378.136; %km (mean equatorial radius of Earth)
h_LEO = 1000;    %km (altitude of LEO)
r_LEO = r_earth + h_LEO;


%% Compute Useful Values
v_LEO = (mu_earth/r_LEO)^.5;    %km/s (orbital velocity of circular LEO)


%% Orbit drop after release
% The conservation of momentum allow us to express the orbital velocity of
% tether after release of S/C as a function of initial speed (orbital speed
% in LEO), the mass ratio between the S/C and the launch system {tether +
% couterweight and the various systems needed} and the deltaV applied to the payload 
% Assumptions :
%   Delta V are colinear to prograde vector
%   Initial orbit is circular

m_star = [1 2 3 5 10 50 1000].^-1;   % Mass ratio payload/tether
dV = [2:0.5:7];                       % Payload deltaV-->(for moon&cycler)

j=1;
for mratio = m_star        % Mass ratio range(m(S/C) / m(tether))
    i=1;
    for dv_sc = dV
        % Velocity of tether after release in km/s
        V_tether(i,j) = v_LEO-mratio*dv_sc; 
        
        % Corresponding Perigee (distance to Sea Level) in km
        z_perigee(i,j) = 2*r_LEO*mu_earth/(2*mu_earth-r_LEO*V_tether(i,j)^2)-r_LEO-r_earth;
        i=i+1;
    end
    j=j+1;
end



figure(9)
plot(dV, V_tether)
title('Final velocity of tether (after sep) vs. Taxi DeltaV')
xlabel('DeltaV (payload, km/s)')
ylabel('Velocity of tether (km/s)')
legend('m* = 1','1/2','1/3','1/5','1/10','1/50', '1/1000')
grid

figure(10)
hold on
plot(dV, z_perigee)
axis([2 7 -7000 2000])
title('Tether''s perigee altitude after release vs. Taxi deltaV')
xlabel('DeltaV Taxi (km/s)')
ylabel('Tether''s perigee (km above sea level)')
legend('m* = 1','1/2','1/3','1/5','1/10','1/50', '1/1000')
plot([2 7], [0 0], '--', 'HandleVisibility','off')
grid
hold off

% The perige drop is PLUNGING, unless the mass ratio is immense (20+)
% mratio = 20 implies that the tether is a least 20*100=2000 tonnes.
% We will try to put the tether on a eccetrical orbit to store some energy
% before the spin up and remain in stable orbit after release

% Starting frome here, r_LEO will be the perigee radius of the orbit (pre-
% release) and the apogee of the orbit post-release. 

perigee_min = 1000;                   %km Minimum Perigee alt after release
rp_min = perigee_min+r_earth;         %km Minimum Perigee radius after release

% Computi the speed required for the perigee to remain above Perigee_min km
v_post = (mu_earth*(2/r_LEO - 2/(r_LEO+rp_min)))^0.5

% The following loop calculates the initial speed required (at r_LEO) in
% order to remain on an orbit with a perigee >rp_min after the release of
% the spacecraft
% This velocity (v_pre) is computed for all different value of mass ratio
% and DeltaV applied to the payload
% --> the lower the mass ratio, the higher the excess speed required will
% be
% --> the greater the delta V applied to the payload, the greater the
% excess speed v_pre will need to be.
j=1;
for mratio = m_star        % Mass ratio range(m(S/C) / m(tether))
    i=1;
    for dv_sc = dV
        
        v_pre(i,j) = mratio/(1+mratio)*(dv_sc + v_LEO + v_post/mratio);
        i=i+1;
    end
    j=j+1;
end

% compute the altitude of apogee (before release) needed to limit perigee drop
% --> function of mass ratio and deltaV of payload
% z_apogee = -(v_pre.^2.*r_LEO - (2*mu_earth)).^-1 .*(2*mu_earth*r_LEO) - r_LEO - r_earth;

% figure(11)
% plot(dV, z_apogee)
% title('Tether''s initial apogee altitude before release vs. DeltaV of payload')
% xlabel('DeltaV (payload, km/s)')
% ylabel('Tether''s apogee (km above sea level)')
% legend('m* = 1','2','3','5','10','50', '1000')
% grid
% 
% % Compute the eccentricity of the initial orbit
% e_initial = (z_apogee-h_LEO)./(z_apogee + r_earth + r_LEO);
% 
% figure(12)
% plot(dV, e_initial)
% title('Tether''s orbit initial eccentricity before release vs. DeltaV of payload')
% xlabel('DeltaV (payload, km/s)')
% ylabel('Tether''s orb. eccentricity')
% legend('m* = 1','2','3','5','10','50', '1000')
% grid
