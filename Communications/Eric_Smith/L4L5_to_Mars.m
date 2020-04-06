%% Calculate the Link Budget for Optical Link between L4/L5 Satellites and Mars
% Written by Eric Smith

lambda = 1550e-9;% wavelength in m
d = 5.242e11; %distance between reciever and tranmitter in m
B_nm = 0.1; %Bandwidth in nm
C = 1e9; %Channel Capacity in bits/s
N0 = 0.3;%W/(m^2 nm)
Pt_Watts = 20;
Dt = 1.6; %transmit aperature diameter in m
Dr = 1.6; %recive aperature diameter in m

margin = LinkBudget(lambda,d,B_nm,C,N0,Dt,Dr,Pt_Watts)