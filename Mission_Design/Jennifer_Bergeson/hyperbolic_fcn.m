function [H, iter] = hyperbolic_fcn(H_start, N, tol, e)

H = H_start;
iter = 0;
difference = 1 + tol;
N_guess = 1;
while difference > tol 
    N_guess = e*sinh(H) - H;
    difference = abs((N_guess - N));
    H = H - .00000001;
    iter = iter + 1;
end