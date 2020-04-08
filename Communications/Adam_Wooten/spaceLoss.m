function FSL = spaceLoss(d,lambda)
% Calculates the Free Space loss in dB of a signal of wavelength lambda,
% that travels the distance d.
% Written by Eric Smith
% Used by Link Budget 

FSL = pow2db((4*pi*d/lambda)^2);
end
