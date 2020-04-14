%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Colin Miller
%
% Class: AAE450
%
% HW/Project: Comm Sats
%
% Description: Calculates magnitude of force on spacecraft due to other
% bodies
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AAE450_ConstantInit;

geo_rad = (Earth.GM*Earth.Side^2/(4*pi^2))^(1/3)
areo_rad = (Mars.GM*Mars.Side^2/(4*pi^2))^(1/3)

a_areo_Mars = Mars.GM/areo_rad^2
a_areo_Sun = Sun.GM/(Mars.SMA*(1-Mars.Ecc)-areo_rad)^2
a_areo_Phobos = Phobos.GM/(Phobos.SMA*(1-Phobos.Ecc)-areo_rad)^2
a_areo_Deimos = Deimos.GM/(Deimos.SMA*(1-Deimos.Ecc)-areo_rad)^2

a_geo_Earth = Earth.GM/(geo_rad)^2
a_geo_Sun = Sun.GM/(Earth.SMA*(1-Earth.Ecc)-geo_rad)^2
a_geo_Moon = Moon.GM/(Moon.SMA*(1-Moon.Ecc)-geo_rad)^2