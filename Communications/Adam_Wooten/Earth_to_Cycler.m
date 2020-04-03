%% Calculate the Link Budget for Optical Link between Earth Satellites and Cycler
% Written by Adam Wooten

% wavelength in m
lambda = 1550e-9;
%distance between reciever and tranmitter in m 2.7AU
d = 4.039e11; 
%Bandwidth in nm
B_nm = 0.1; 
%Channel Capacity in bits/s
C = 1e9; 
%W/(m^2 nm)
N0 = 0.3;
Pt_Watts = 24;
%transmit aperature diameter in m
Dt = 1.2; 
%recive aperature diameter in m
Dr = .5; 

margin = LinkBudget(lambda,d,B_nm,C,N0,Dt,Dr,Pt_Watts)