function [r,dirx,diry,dirz] = getDirection(X,Y,Z,i,j)
% Finds displacement between bodies
dx = X(j)-X(i);
dy = Y(j)-Y(i);
dz = Z(j)-Z(i);

% Calculates distance
r = sqrt(dx^2 + dy^2 + dz^2);

% Calculates unit direction vectors
dirx = dx/r;
diry = dy/r;
dirz = dz/r;