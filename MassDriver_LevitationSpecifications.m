clc;
clear;
%% Introduction
% Project Escalator
%
% Code Author: Natasha Yarlagadda
%
% This code calculates various ReBCO magnet and null-flux coil 
% specifications and parameters for the 3 tracks across Project Escalator 
% where we can use maglev technology

%% Assumptions
% - max acceleration is 2 G's
%
% - launch stack uses wheels to 'levitate' before 27.7 m/s
%
% - the same launch stack is used at each of the three locations
%
% - curvature of track does not affect coil orientation
%
% - same orientation of null flux coils used for levitation can be used for
% guidance (no change necessary)

%% Variable Initializations
m_taxi = 200; %(Mg) mass of taxi vehicle
m_cradle = 100; %(Mg) mass of cradle
w_cradle = 30; %(m) width of cradle
g_Mars = 3.711; %(m/s^2) gravitational constant on Mars
F_SCM = 14; %(kN) force that one ReBCO SCM can produce
l_launch_Mars_accel = 750; %(km) length of Olympus Mons launch track for acceleration
l_launch_Mars_decel = 130; %(km) length of Olympus Mons launch track for deceleration
l_launch_Luna = 159; %(km) length of Luna launch track
r_land_Mars = 697; %(m) average radius of Mars landing track 
h_mag = 0.5; %(m) height of magnet
w_mag = 1.7; %(m) width of magnet
s_mag = 0.4; %(m) spacing between magnets on launch stack 
h_coil = 0.55; %(m) height of coil 
w_coil = 0.31; %(m) width of coil
s_coil = 0.15; %(m) spacing between coils on tracks

%% Section I
% Calculates the initial values needed to calculate specifications for the
% tracks
m_stack = m_taxi + m_cradle; %(Mg)
F_lev = (m_stack*g_Mars)/1000; %(MN)
n_magnets = ceil(F_lev/F_SCM); %(#)
n_mag_side = n_magnets/2; %(#)

%% Section II
% Calculates track specifications for Olympus Mons launch track
l_launch_Mars = (l_launch_Mars_accel + l_launch_Mars_decel)*1000; %(m)
n_coil_Mars_launch = l_launch_Mars/(w_coil + s_coil); %(#)

%% Section II
% Calculates track specifications for Luna launch track
n_coil_Luna_launch = (l_launch_Luna*1000)/(w_coil + s_coil); %(#)

%% Section III
% Calculates track specifications for Mars landing track
r_outer = r_land_Mars + w_cradle/2; %(km)
r_inner = r_land_Mars - w_cradle/2; %(km)
l_outer_land = 2*pi*r_outer; %(km)
l_inner_land = 2*pi*r_inner; %(km)
n_coil_land_outer = (l_outer_land*1000)/(w_coil + s_coil); %(#)
n_coil_land_inner = (l_inner_land*1000)/(w_coil + s_coil); %(#)

%% Displaying Outputs
% System specifications:
fprintf ('Mass of launch stack: %f Mg\n', m_stack)
fprintf ('Levitation force required: %f MN\n', F_lev)
fprintf ('Number of ReBCO magnets needed: %f magnets\n', n_magnets)
fprintf ('Number of ReBCO magnets needed on each side: %f magnets\n', n_mag_side)
%
% ReBCO Magnets specifications:
fprintf ('Force from one ReBCO magnet: %f kN\n', F_SCM)
fprintf ('Height of ReBCO magnet: %f m\n', h_mag)
fprintf ('Width of ReBCO magnet: %f m\n', w_mag)
fprintf ('Spacing between magnets: %f m\n', s_mag)
%
% Null-Flux Coil specifications:
fprintf ('Height of Null-Flux coil: %f m\n', h_coil)
fprintf ('Width of Null-Flux coil: %f m\n', w_coil)
fprintf ('Spacing between Null-Flux coils: %f m\n', s_coil)
%
% Olympus Mons launch track:
fprintf ('Olympus Mons Launch Track Length: %f km\n', l_launch_Mars/1000)
fprintf ('Number of coils for Olympus Mons launch track: %f coils per side\n', n_coil_Mars_launch)
%
% Luna launch track:
fprintf ('Luna Launch Track Length: %f km\n', l_launch_Luna)
fprintf ('Number of coils for Luna track: %f coils per side\n', n_coil_Luna_launch)
%
% Mars landing track:
fprintf ('Mars Landing Track Outer Length: %f km\n', l_outer_land)
fprintf ('Mars Landing Track Inner Length: %f km\n', l_inner_land)
fprintf ('Number of coils for Mars outer landing rail: %f coils\n', n_coil_land_outer)
fprintf ('Number of coils for Mars inner landing rail: %f coils\n', n_coil_land_inner)