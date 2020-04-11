clc
format long
%% Define Parameters
F_surface = 63*10^(6);  % (W/m^2) Energy flux emitted at the Sun's surface, as provided by https://www.acs.org/content/acs/en/climatescience/energybalance/energyfromsun.html
r_sun = 695990*10^3; % (m) Radius of the Sun
r_mercury = 1738.1*10^3; % (m) Radius of Mercury
r_venus = 6051.9*10^3;   % (m) Radius of Venus
r_earth = 6378.136*10^3; % (m) Radius of Earth
r_mars = 3397*10^3;  % (m) Radius of Mars

a_mercury = 57909226.542*10^3;   % (m) semi-major axis of Mercury's orbit
a_venus = 108209474.537*10^3;    % (m) semi-major axis of Venus' orbit
a_earth = 149597870.7*10^3;  % (m) semi-major axis of Earth's orbit
a_mars = 227943822.428*10^3; % (m) semi-major axis of Mars' orbit

mu_sun = 132712440017.99*1000000000;   % (m^3/s^2) gravitational parameter of the sun

%% Determine Relevance of Eclipse due to Mercury and Venus
Solar_power = F_surface*pi*r_sun^2; % (W) Total power emitted from Sun
F_mercury = (F_surface*r_sun^2)/(a_mercury^2);  % (W/m^2) Energy flux from Sun at Mercury's orbital radius
F_venus = (F_surface*r_sun^2)/(a_venus^2);  % (W/m^2) Energy flux from Sun at Venus' orbital radius
F_earth = (F_surface*r_sun^2)/(a_earth^2);  % (W/m^2) Energy flux from Sun at Earth's orbital radius
F_mars = (F_surface*r_sun^2)/(a_mars^2);  % (W/m^2) Energy flux from Sun at Mars' orbital radius

area_sun = pi*r_sun^2;  % (m^2) Surface area of circular projection of Sun
area_mercury = pi*r_mercury^2;  % (m^2) Surface area of circular projection of Mercury
area_venus = pi*r_venus^2;  % (m^2) Surface area of circular projections of Venus

F_earth_mercury = F_earth*(1 - area_mercury/area_sun);    % (W/m^2) Energy flux from Sun at Earth's orbital radius with Mercury eclipsing
F_earth_venus = F_earth*(1 - area_venus/area_sun);  % (W/m^2) Energy flux from Sun at Earth's orbital radius with Venus eclipsing
F_earth_mercury_venus = F_earth*(1 - area_venus/area_sun - area_mercury/area_sun);  % (W/m^2) Energy flux from the Sun at Earth's orbital radius with Mercury AND Venus eclipsing
earth_power_loss_mercury = 1 - F_earth_mercury/F_earth; % Ratio of power lost at Earth when Mercury is eclipsing
earth_power_loss_venus = 1 - F_earth_venus/F_earth; % Ratio of power lost at Earth when Venus is eclipsing
earth_power_loss_mercury_venus = 1 - F_earth_mercury_venus/F_earth;   % Ratio of power lost when both Mercury and Venus are Eclipsing at Earth's orbital radius

F_mars_mercury = F_mars*(1 - area_mercury/area_sun);    % (W/m^2) Energy flux from Sun at Mars' orbital radius with Mercury eclipsing
F_mars_venus = F_mars*(1 - area_venus/area_sun);  % (W/m^2) Energy flux from Sun at Mars' orbital radius with Venus eclipsing
F_mars_mercury_venus = F_mars*(1 - area_venus/area_sun - area_mercury/area_sun);  % (W/m^2) Energy flux from the Sun at Mars' orbital radius with Mercury AND Venus eclipsing
mars_power_loss_mercury = 1 - F_mars_mercury/F_mars;    % Ratio of power lost at Mars when Mercury is eclipsing
mars_power_loss_venus = 1 - F_mars_venus/F_mars;    % Ratio of power lost at Mars when Venus is eclipsing
mars_power_loss_mercury_venus = 1 - F_mars_mercury_venus/F_mars;   % Ratio of power lost when both Mercury and Venus are Eclipsing at Mars' orbital radius

%% Calculate Eclipse Times 
delta_M_earth = 2*atan(r_earth/a_earth);    % (rad) angle Earth sweeps out from Sun
n_earth = (mu_sun/a_earth^3)^.5;    % (s^(-1)) n of Earth
delta_t_earth = delta_M_earth/(n_earth*60);  % (min) Eclipse time behind Earth assuming cycler is on circular orbit at Earth semi-major axis

delta_M_mars = 2*atan(r_mars/a_mars);   % (rad) angle Mars sweeps out from Sun
n_mars = (mu_sun/a_mars^3)^.5;  % (s^(-1)) n of Mars
delta_t_mars = delta_M_mars/(n_mars*60); % (min) Eclipse time behind Mars assuming cycler is on circular orbit at Mars semi-major axis

delta_M_mercury = 2*atan(r_mercury/a_mercury);    % (rad) angle Mercury sweeps out from Sun
delta_t_mercury = delta_M_mercury/(n_mars*60);  % (min) Eclipse time behind Mercury assuming cycler is on circular orbit at Mars semi-major axis

delta_M_venus = 2*atan(r_venus/a_venus);    % (rad) angle Earth sweeps out from Sun
delta_t_venus = delta_M_venus/(n_mars*60);  % (min) Eclipse time behind Venus assuming cycler is on circular orbit at Mars semi-major axis
