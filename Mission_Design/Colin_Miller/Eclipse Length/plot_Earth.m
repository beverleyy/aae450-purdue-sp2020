function [gh] = plot_Earth(npts,GMST0)

persistent cdata;
if isempty(cdata)
    cdata = imread('EarthTex.jpg');
end
RE_eq = 6378.137;
RE_pol = 6356.752314245;

[Earthx, Earthy, Earthz] = ellipsoid(0,0,0,RE_eq, RE_eq, RE_pol,npts);

C = [cosd(GMST0), -sind(GMST0), 0; sind(GMST0), cosd(GMST0), 0; 0,0,1];
Rotated = C*[Earthx(:)'; Earthy(:)'; Earthz(:)'];
Earthx = reshape(Rotated(1,:), npts+1, npts+1);
Earthy = reshape(Rotated(2,:), npts+1, npts+1);
Earthz = reshape(Rotated(3,:), npts+1, npts+1);


Gh = surf(Earthx, Earthy, -Earthz, 'FaceColor','texturemap', 'CData', cdata, 'EdgeColor','none');
axis equal
end