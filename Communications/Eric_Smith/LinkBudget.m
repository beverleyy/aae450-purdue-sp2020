function margin = LinkBudget(lambda,d,B_nm,C,spectRadiance,Dt,Dr,Pt_Watts)
%% Calculate Link Budget with given inputs
% Written by Eric Smith
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

B = c/(B_nm*1e-9); %Bandwidth in Hz
SNR_req = 2^(C/B)-1; %Required SNR for given data rate and bandwidth

Pt = pow2db(Pt_Watts); %transmit power in Watts

At = Dt^2 * pi/4; % Transmitter Aperture Area
Ar = Dr^2 * pi/4; % Receiver Aperture Area

Gt = antennaGain(At,lambda); % Receiver Antenna Gain in dB
Gr = antennaGain(Ar,lambda); % Receiver Antenna Gain in dB

Lfs = spaceLoss(d,lambda); %Free Space Loss in dB

N = spectRadiance*Ar*B_nm; % noise power in Watts

P_req = pow2db(SNR_req * N); % required power in dB

eta_t = pow2db(.8); % transmitter optics efficiency in dB
eta_a = pow2db(.8); % aperture illumination efficiency in dB
L_pointing = 3; %dB estimate for now
L_atm = 0; %no atmosphere loss because tx/rx both in space
L_pol = 0; %no polarization
eta_r = pow2db(.8); % receiver optics efficiency in dB

margin = Pt+eta_t+eta_a+Gt-L_pointing-L_atm-L_pol-Lfs+eta_r+Gr-P_req; % Link Margin in dB
end
