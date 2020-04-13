%% Initialization
clear
clc
window_time = 13.5;%days
load('spinupPowerVars.mat')
n=0;
tim = t;
Pim = P;

%% Spin up and down 
for i = length(Pim)+1:2*length(Pim)
    n = n + 1;
    P(i) = Pim(length(Pim)+1-n);
    t(i) = tim(length(tim)) + tim(length(tim)) - tim(length(tim) + 1 - n);
end

% figure(1)
% plot(t,P)
% xlabel('Time (s)')
% ylabel('Power (W)')

%% Creating Arrays
reboost_time = 8*24*3600; %Reboost Duration (s)
reboost_power = 500e6; %Power required during Reboost (W)
trip_time = window_time*24*3600; %Launch Window (s)
time_rb = [max(t):1:(reboost_time+max(t))]; %Reboost time Array
power_rb = ones(length(time_rb),1)*reboost_power; %Reboost Power Array
time_idle_1 = [max(time_rb):3600*24:trip_time]; %Idle Time in first window
time_2 = (window_time*24*3600)+t; %Window Time added for second one
time_idle_2 = max(time_2)+[max(t):3600*24:trip_time]; %Idle time in second window
power_idle_1 = 2000*ones(length(time_idle_1)); %Power during idle time (W)
power_idle_2 = 2000*ones(length(time_idle_2)); %Power during idle time (W)

%% Plotting Power Required and Battery Supply

figure(1)
plot(t./(24*3600),P./(10^6),'r') %Mw per hour
hold on
plot(time_rb./(24*3600),power_rb./(10^6),'g')
plot(time_idle_1./(24*3600), power_idle_1./(10^6),'b')
plot(time_2./(24*3600), P./(10^6),'r')
plot(time_idle_2./(24*3600), power_idle_2./(10^6),'b')

title('Power Required per two launch windows')
xlabel('Time (Days)')
ylabel('Power Required (MW)')
legend('Spin up and down','Reboost','Idle Time')


figure(2)
plot(t./(24*3600),(P -reboost_power)./(10^6),'r')%Mw per hour
ylim([0 inf])
hold on
plot(time_rb./(24*3600),(power_rb-reboost_power)./(10^6),'g')
plot(time_idle_1./(24*3600), (power_idle_1-reboost_power)./(10^6),'b')
plot(time_2./(24*3600), (P-reboost_power)./(10^6),'r')
plot(time_idle_2./(24*3600), (power_idle_2-reboost_power)./(10^6),'b')

title('Power Supplied by Batteries')
xlabel('Time (Days)')
ylabel('Power Supplied (MW)')
legend('Spin up and down','Reboost','Idle Time')

%% Battery Sizing

battery_energy = 0;
for i = 1:length(P)-1
    if ((P(i)-reboost_power) > 0)
        battery_energy = battery_energy + (P(i)-reboost_power) * (t(i+1)-t(i)); %W*s
    end
end

battery_energy = battery_energy * 2/3600; %w*hr

Specific_Energy = 650; %Wh/kg https://www.nasa.gov/sites/default/files/atoms/files/650_whkg_1400_whl_recharg_batt_new_era_elect_mobility_ymikhaylik_0.pdf
Energy_Density = 1400; %Wh/L https://www.nasa.gov/sites/default/files/atoms/files/650_whkg_1400_whl_recharg_batt_new_era_elect_mobility_ymikhaylik_0.pdf
Battery_mass = battery_energy/Specific_Energy;%kg
Battery_mass = (battery_energy/Specific_Energy)*(10^-6); %Mg
Battery_Volume = battery_energy/Energy_Density; %Liters
Battery_Volume = Battery_Volume * 0.001; %m^3

%% Feasability Analysis
idle_time_total = 0.67*sum(time_idle_1)+sum(time_idle_2);
Energy_charge = reboost_power * idle_time_total/3600;

total_energy_required = 0;
for i=1:length(P)-1
    total_energy_required = total_energy_required + (t(i+1)-t(i))*P(i);
end

total_energy_required = 2 * total_energy_required;
total_energy_required = total_energy_required + (reboost_time * reboost_power);
total_energy_required = total_energy_required + (max(time_idle_1) - min(time_idle_1)) * 2000;
total_energy_required = total_energy_required + (max(time_idle_2) - min(time_idle_2)) * 2000;

total_energy_produced = reboost_power * (window_time*2*3600*24) * 0.66;

total_energy_produced = total_energy_produced / 3600000000000;%Gwhr
total_energy_required = total_energy_required / 3600000000000; %Gwhr

%% Solar Array Sizing
eff_solar = 0.32;
solar_in = 1367.9; %W/m2
eff_trans = 0.92;
pow_prod = reboost_power / (eff_solar*eff_trans);
solar_array_area = pow_prod/solar_in; %m^2
solar_array_area = solar_array_area/1000000; %km^2

solar_mass = 490; %Mg/km^2
solar_array_mass = solar_array_area*solar_mass; %Mg




