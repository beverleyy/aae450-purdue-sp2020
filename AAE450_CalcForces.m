%% Purdue University AAE 450 Spacecraft Design, Spring 2020
%  Pertubation Torques Analysis - Scaling Analysis
%  Beverley Yeo (U1721040H)
%  Nanyang Technological University, Singapore

clear all;
clc;

%% Galileo values - Earth
sr = 9e-5;      %solar radiation
rsr = 1.2e-7;   %reflected solar radiation
ptr = 7.8e-8;   %planet thermal radiation
sw = 3.1e-8;    %solar wind
mt = 1.1e-10;   %meteoroids

ag1 = 13.2;     %area of galileo near earth for sr and sw
ag2 = 6.50;     %area of galileo near earth for rsr and ptr
ag3 = 11.28;    %area of galileo near earth for meteoroids

%% Galileo values - Interplanetary
% sr = 1.1e-5;
% rsr = 0;
% ptr = 0;
% sw = 3.6e-9;
% mt = 9.4e-9;
% 
% ag1 = 14.16; % area for sr and sw
% ag2 = 1; %arbitrary - no rsr and ptr
% ag3 = 11.79; %area for meteoroids

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
    SolarRad(i) = (areas(i)/ag1)*sr;
    RefSolRad(i) = (areas(i)/ag2)*rsr;
    PlanetTherm(i) = (areas(i)/ag2)*ptr;
    SolarWind(i) = (areas(i)/ag1)*sw;
    Meteo(i) = (areas(i)/ag3)*mt;
    
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
for j = 1:rc
    ZTorque = ZTorque + Torques(j,3);
    YTorque = YTorque + Torques(j,2);
    XTorque = XTorque + Torques(j,1);
end

clear i j rc cc;