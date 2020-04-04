% dVarray = zeros(25,1);
% for z = 1:25
% clear
load('Cycler1.mat')
%% Inputs
LegNo = 1;
t_step = 60*10; % in seconds
Kp = 1e-3;
Ki = 1e-12;

%%
Leg = sprintf('Leg%d',LegNo);
start_date = Cycler1.(Leg).julian(1);
duration = (Cycler1.(Leg).julian(end) - Cycler1.(Leg).julian(1))*24*60*60;


%% Initial Conditions
SPM_pos0 = Cycler1.(Leg).SPM_pos0;
SPM_vel0 = Cycler1.(Leg).SPM_vel0;
Cyc_pos0 = Cycler1.(Leg).Cyc_pos0;
Cyc_vel0 = Cycler1.(Leg).Cyc_vel0;

%% Desired Trajectory
desired_trajectory = interp1(linspace(0,duration,length(Cycler1.(Leg).julian)),Cycler1.(Leg).trajectory,linspace(0,duration,duration/t_step+1));
desired_trajectory = desired_trajectory*149597870.700e3;
%% Constants
constants = [6.67408e-11; 299792458; 1361; 1.38064852e-23];

%% Planets
bodies = {'SUN';'EARTH';'MOON';'MARS';'PHOBOS';'CYCLER'};
mass = [1.9885E+30	5.9722E+24	7.3490E+22	6.4171E+23	1.0800E+16,250000]';
radii = [695700 6378.137 1737.53 3389.92 11.16666667]';
albedo = [0	0.367	0.12	0.15	0.06]';
temp = [0 288 233 210 215]';
emis = [0 0.9 0.9 0.8 0.93]';
dim = [6;30];  % [Diameter,height]

%% Convert Units

SPM_pos0 = SPM_pos0*149597870.700e3;
SPM_vel0 = SPM_vel0*149597870.700e3/86400.0;
Cyc_pos0 = Cyc_pos0*149597870.700e3;
Cyc_vel0 = Cyc_vel0*149597870.700e3/86400.0;

%% 
% sim('NewSim.slx')
%%
% tdV = 0;
% for i =1:length(dV.Data)
%     tdV = tdV + norm(dV.Data(i,:));
% end
% dVarray(z) = tdV/t_step/1e3;
%%
% end