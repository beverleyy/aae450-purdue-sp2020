%% Calculate the Link Budget for Optical Link between GEO Satellites and L4/L5 Satellites
% Written by Eric Smith

lambda = 1550e-9;% wavelength in m
d = 1.496e11; %distance between reciever and tranmitter in m
B_nm = 0.1; %Bandwidth in nm
C = 1e9; %Channel Capacity in bits/s
N0 = 0.3;%W/(m^2 nm)
Pt_Watts = 20;
Dt = .5; %transmit aperature diameter in m
Dr = .5; %recive aperature diameter in m

margin = LinkBudget(lambda,d,B_nm,C,N0,Dt,Dr,Pt_Watts)