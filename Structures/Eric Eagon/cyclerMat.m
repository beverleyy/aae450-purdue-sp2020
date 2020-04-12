function [yield, density] = cyclerMat(x)
%cyclerTetherMat lets the user choose what material the tether should be.
%   1) Aluminum 6061-T6
%   2) Dyneema Fiber(Spectra 2000)
%   3) Zylon
%   4) Kevlar
%   5) Hercules IM7
%   6) Aluminum 7075-T6
%   7) HexTow AS4C Carbon Fiber
%   8) HD115 Plastazote Polyethylene Foam

if x == 1
    yield = 276e6;   %[Pa]
    density = 2700;  %[kg/m^3]
elseif x == 2
        yield = 3.325e9;  %Reduced due to UV radiation
        density = 970;
elseif x == 3
        yield = 5.8e9;
        density = 1560;
elseif x == 4
        yield = 2.8e9;
        density = 1450;
elseif x == 5
        yield = 4.82e9;
        density = 1550;
elseif x == 6
        yield = 503e6;
        density = 2700;
elseif x == 7
        yield = 4.654e9;
        density = 1780;
elseif x == 8
        yield = 2390e3;
        density = 115;
else
    error('NOT A SPECIFIED MATERIAL')
end
end

