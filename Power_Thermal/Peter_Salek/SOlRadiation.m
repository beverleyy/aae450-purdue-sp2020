%Salek, Peter           Solar Radiation Calculation
% AAE 450

function [Solar_Irradiance] = SOlRadiation(Distance)
Hsun = 64*10^6; %W/m^2
Rsun = 695*10^6; %m
Solar_Irradiance = (Rsun^2)/(Distance^2)*Hsun;
end
