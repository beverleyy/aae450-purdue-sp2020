function FSL = spaceLoss(d,lambda)
% Calculates the Free Space loss in dB of a signal of wavelength lambda,
% that travels the distance d.
% Written by Adam Wooten

FSL = pow2db((4*pi*d/lambda)^2);
end
