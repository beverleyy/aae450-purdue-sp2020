%control wheel sizing. Takes the given torque limits and satellite
%properties and calculates the SIZE of control wheels necessary. (this is
%assuming we will not need to desaturate the control wheels. those
%calculations will be done later, etc.)

%ASSUMPTIONS
%no rcs failure
%pyramid shape
%need to be able to overcome all torque w/o thruster help
%torques always max, shared across all axes

%satellite properties
torqueEx = 1.3052e-06; %kg-m, expected MAX torque on satellite
density = 8000; %kg/m^3, density of reaction wheel material
speedlimRPM = 7000; %rev/min, maximum rotation speed of the reaction wheel. taken from similar models
LS = 8; %yrs, lifespan
h = .05; %m, height of reaction wheel.
wheelTorque = .17; %N-m, torque applied by motor

%calcs
speedlim = 7000 / 60 * 2 * pi * .9; %rad/sec, dont wanna exceed 90% of max speed
changeinAM = torqueEx * (LS * 365 * 24 * 60 * 60); %THIS IS WHAT RCS NEED TO PROVIDE, we say TEN years LS
Ineeded = changeinAM/speedlim;

R = (Ineeded/(.5 * density * h))^(1/4); 
%R is the radius needed if each reaction wheel is in its own direction.
%Augmenting such that they are in a pyramid configuration requires calcs
%below:
mass = density * h * R^2;
maxE = wheelTorque * speedlim; %max power. dont worry about the E

fprintf('torque needed = %.4f kg*m \n', torqueEx)
fprintf('R = %.4f m \n', R)
fprintf('h = %.4f m \n', h) 
fprintf('mass = %.4f kg \n', mass)
fprintf('max power per wheel = %.4f W \n', maxE)
