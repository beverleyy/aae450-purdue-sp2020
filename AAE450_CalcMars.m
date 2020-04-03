%% Purdue University AAE 450 Spacecraft Design, Spring 2020
%  Pertubation Torques Analysis - Scaling Analysis
%  Beverley Yeo (U1721040H)
%  Nanyang Technological University, Singapore

clear all;
clc;

%% Constants
f0 = 1361; 
c = 3e+8;
k = 1;      %assumed blackbody spacecraft
sigma = 5.67e-8;

%% Mars values
rss = 1.524;            %distance to sun (avg)
alpha = 0.25;           %bond albedo (NASA)
R_mars = 2.27075e-5;    %mars radius = 3397km
rps = 1.2*R_mars;       %approach distance
T = 209.8;              %blackbody temperature

%% Calculate normalized forces (F_norm = F/A)
sr = k*(f0/rss^2)/c;
rsr = k*(alpha*R_mars^2*f0)/(c*3*rss^2*rps^2);
ptr = k*(sigma*(T^4)*R_mars^2)/(c*rps^2);
sw = (2.3e-9)/(rss^2);
mt = 0;                                         %research this

%% Cycler stats
% Need to make better estimates for the areas if want better scaling
% But the order of magnitude should be relatively correct

PanelArea1 = 13440/2;           %from P&T team
PanelArea2 = 13440/2;           %from P&T team
SSArea = 55*10;                 %55m height, 10m diameter, treat as rectangle
HabArea = 2*6*76 + 50^2;        %50m^2 is elevator area, 2*(76m length, 6m height)

%These are the moment arms
HabDistanceX = 10+388;          %388m arm length, 10m radius of superstructure
HabDistanceY = 0;               %assume same line as CM - not sure about this number
HabDistanceZ = 0;               %2.5m offset from CM - not sure about this number
SolarPanelX1 = 0; 
SolarPanelY1 = 0;
SolarPanelZ1 = 55/2+16.8;       %16.8m solar panel height
SolarPanelX2 = 0; 
SolarPanelY2 = 0;
SolarPanelZ2 = -(55/2+16.8);    %below x-y plane (negative z-distance)
SuperStructureZ = 0;
SuperStructureY = 0;
SuperStructureX = 0;

%% Scale Galileo forces to cycler
% Formula is F = kAf/c, use area ratios to scale

areas = [PanelArea1,PanelArea2,SSArea,HabArea];

%loop through each component, calculate force due to each component
for i=1:length(areas)
    SolarRad(i) = areas(i)*sr;
    RefSolRad(i) = areas(i)*rsr;
    PlanetTherm(i) = areas(i)*ptr;
    SolarWind(i) = areas(i)*sw;
    Meteo(i) = areas(i)*mt;
    
    %Sum up forces on each component
    TotalForce(i) = SolarRad(i) + RefSolRad(i) + PlanetTherm(i) + SolarWind(i) + Meteo(i);
end

%% Calculate Torques (X-axis)
    HabTorque(1) = TotalForce(4)*HabDistanceY;
    SSTorque(1) = TotalForce(3)*SuperStructureY;
    Panel1Torque(1) = TotalForce(1)*SolarPanelY1;
    Panel2Torque(1) = TotalForce(2)*SolarPanelY2;
 
%% Calculate Torques (Y-axis)
    HabTorque(2) = TotalForce(4)*HabDistanceZ;
    SSTorque(2) = TotalForce(3)*SuperStructureZ;
    Panel1Torque(2) = TotalForce(1)*SolarPanelZ1;   
    Panel2Torque(2) = TotalForce(2)*SolarPanelZ2;   

%% Calculate Torques (Z-axis)
    HabTorque(3) = TotalForce(4)*HabDistanceX;
    SSTorque(3) = TotalForce(3)*SuperStructureX;
    Panel1Torque(3) = TotalForce(1)*SolarPanelX1;
    Panel2Torque(3) = TotalForce(2)*SolarPanelX2;
    
%% Sum total torques along each axis
ZTorque = 0; 
YTorque = 0;
XTorque = 0;
Torques = [HabTorque; SSTorque; Panel1Torque; Panel2Torque];

[rc cc] = size(Torques);
for j = 1:cc
    ZTorque = ZTorque + Torques(j,3);
    YTorque = YTorque + Torques(j,2);
    XTorque = XTorque + Torques(j,1);
end

clear i j rc cc;