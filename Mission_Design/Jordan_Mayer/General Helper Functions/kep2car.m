function [car] = kep2car(kep,GM,atype)

% Name: kep2car.m
% Author: C. Frueh
% Purpose
%    To compute the Cartesian position/velocity given Keplerian elements.
% Inputs
%    kep   - Keplerian elements, (6 x 1) vector with order semi-major axis,
%            eccentricity, inclination, right-ascension of the ascending
%            node, argument of periapse, mean anomaly
%    mu    - value of the gravitational parameter of the central body
%    atype - units of the angles in the Keplerian elements, 'rad' or 'deg'
% Outputs
%    car - Cartesian position/velocity
% Dependencies
%    None

sma  = kep(1);
ecc  = kep(2);
inc  = kep(3);
raan = kep(4);
argp = kep(5);
manm = kep(6);

if(strcmp(atype,'deg'))
    inc  = inc*(pi/180.0);
    raan = raan*(pi/180.0);
    argp = argp*(pi/180.0);
    manm = manm*(pi/180.0);
end

itermax = 10;
toler   = 1.0D-12;
delta   = 1.0;
eanm    = manm;
iter    = 0;
while((iter < itermax) && (abs(delta) > toler))
    iter  = iter + 1;
    delta = ((eanm - ecc*sin(eanm) - manm)/(1.0 - ecc*cos(eanm)));
    eanm  = eanm - delta;
end
tanm = 2.0*atan(sqrt((1.0+ecc)/(1.0-ecc))*tan(0.5*eanm));
% if ~isreal(tanm)
%     keyboard 
% end
r    = sma*(1.0-ecc*cos(eanm));
slr  = sma*(1.0-ecc*ecc);
angm = sqrt(GM*slr);
vr   = (angm/slr)*ecc*sin(tanm);
vf   = (angm/slr)*(1.0+ecc*cos(tanm));
argl = argp + tanm;

cos_s = cos(argl);
sin_s = sin(argl);
cos_i = cos(inc);
sin_i = sin(inc);
cos_W = cos(raan);
sin_W = sin(raan);

R3s = [cos_s,sin_s,0.0;-sin_s,cos_s,0.0;0.0,0.0,1.0];
R1i = [1.0,0.0,0.0;0.0,cos_i,sin_i;0.0,-sin_i,cos_i];
R3W = [cos_W,sin_W,0.0;-sin_W,cos_W,0.0;0.0,0.0,1.0];
T   = R3s*R1i*R3W;

x   = T(1,1)*r;
y   = T(1,2)*r;
z   = T(1,3)*r;
xd  = T(1,1)*vr + T(2,1)*vf;
yd  = T(1,2)*vr + T(2,2)*vf;
zd  = T(1,3)*vr + T(2,3)*vf;

car = [x;y;z;xd;yd;zd];

end