%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Colin Miller
%
% Class: AAE450
%
% HW/Project: StationKeeping
%
% Description:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GEOEast = csvread('DVIB_GEOEast.txt');
GEOWest = csvread('DVIB_GEOWest.txt');
GEOMid = csvread('DVIB_GEOMid.txt');

AREOEast = csvread('DVIB_AREOEast.txt');
AREOWest = csvread('DVIB_AREOWest.txt');
AREOMid = csvread('DVIB_AREOMid.txt');

jj=1;
for ii=2:length(GEOEast)
    if (GEOEast(ii, 2) ~= GEOEast(ii-1,2))
        DV_GEOEast(jj) = GEOEast(ii,2);
        ED_GEOEast(jj) = GEOEast(ii,1);
        jj = jj+1
    end
end

jj=1;
for ii=2:length(GEOMid)
    if (GEOMid(ii, 2) ~= GEOMid(ii-1,2))
        DV_GEOMid(jj) = GEOMid(ii,2);
        ED_GEOMid(jj) = GEOMid(ii,1);
        jj = jj+1
    end
end

jj=1;
for ii=2:length(GEOWest)
    if (GEOWest(ii, 2) ~= GEOWest(ii-1,2))
        DV_GEOWest(jj) = GEOWest(ii,2);
        ED_GEOWest(jj) = GEOWest(ii,1);
        jj = jj+1
    end
end

jj=1;
for ii=2:length(AREOEast)
    if (AREOEast(ii, 2) ~= AREOEast(ii-1,2))
        DV_AREOEast(jj) = AREOEast(ii,2);
        ED_AREOEast(jj) = AREOEast(ii,1);
        jj = jj+1
    end
end

jj=1;
for ii=2:length(AREOMid)
    if (AREOMid(ii, 2) ~= AREOMid(ii-1,2))
        DV_AREOMid(jj) = AREOMid(ii,2);
        ED_AREOMid(jj) = AREOMid(ii,1);
        jj = jj+1
    end
end

jj=1;
for ii=2:length(AREOWest)
    if (AREOWest(ii, 2) ~= AREOWest(ii-1,2))
        DV_AREOWest(jj) = AREOWest(ii,2);
        ED_AREOWest(jj) = AREOWest(ii,1);
        jj = jj+1
    end
end

Tot_AREOWest = sum(abs(DV_AREOWest))/(AREOWest(end,1))*3600*24*365*6
Tot_AREOMid = sum(abs(DV_AREOMid))/(AREOMid(end,1))*3600*24*365*6
Tot_AREOEast = sum(abs(DV_AREOEast))/(AREOEast(end,1))*3600*24*365*6

Tot_GEOWest = sum(abs(DV_GEOWest))/(GEOWest(end,1))*3600*24*365*6
Tot_GEOMid = sum(abs(DV_GEOMid))/(GEOMid(end,1))*3600*24*365*6
Tot_GEOEast = sum(abs(DV_GEOEast))/(GEOEast(end,1))*3600*24*365*6

figure
plot(GEOEast(:,1)/(3600*24), GEOEast(:,3));
figure
plot(GEOWest(:,1)/(3600*24), GEOWest(:,3));
figure
plot(GEOMid(:,1)/(3600*24), GEOMid(:,3));
title('Mid-Longitude GEO Satellite')
xlabel('Time (days)')
ylabel('Longitude (degrees)')

figure
plot(AREOEast(:,1)/(3600*24), AREOEast(:,3));
figure
plot(AREOWest(:,1)/(3600*24), AREOWest(:,3));
figure
plot(AREOMid(:,1)/(3600*24), AREOMid(:,3));