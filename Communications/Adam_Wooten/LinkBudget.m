function margin = LinkBudget(lambda,d,B_nm,C,spectRadiance,Dt,Dr,Pt_Watts)
%% Calculate Link Budget with given inputs
% Written by Eric Smith editted by Adam Wooten
% lambda = wavelength of carrier
% d = distance between transmitter and receiver
% B_nm = Bandwidth in nanometers
% C = required data rate in bits/s
% N0 = noise power density in W/(m^2 nm)
% Dt = Diameter of transmitter aperture
% Dr = Diameter of receiver aperture
% Pt_Wattts = transmitter power in Watts
%%
c = 299792458; %speed of light in m/s

%Bandwidth in Hz
B = c/(B_nm*1e-9); 
%Required SNR for given data rate and bandwidth
SNR_req = 2^(C/B)-1; 

%transmit power in Watts
Pt = pow2db(Pt_Watts); 

% Transmitter Aperture Area
At = Dt^2 * pi/4; 
% Receiver Aperture Area
Ar = Dr^2 * pi/4; 

% Receiver Antenna Gain in dB
Gt = antennaGain(At,lambda); 
% Receiver Antenna Gain in dB
Gr = antennaGain(Ar,lambda); 

%Free Space Loss in dB
Lfs = spaceLoss(d,lambda); 

% noise power in Watts
N = spectRadiance*Ar*B_nm; 

% required power in dB
P_req = pow2db(SNR_req * N); 

% transmitter optics efficiency in dB
eta_t = pow2db(.8); 
% aperture illumination efficiency in dB
eta_a = pow2db(.8); 
%dB estimate for now
L_pointing = 3; 
%no atmosphere loss because tx/rx both in space
L_atm = 0; 
%no polarization
L_pol = 0; 
% receiver optics efficiency in dB
eta_r = pow2db(.8); 

% Link Margin in dB
margin = Pt+eta_t+eta_a+Gt-L_pointing-L_atm-L_pol-Lfs+eta_r+Gr-P_req; 
end
