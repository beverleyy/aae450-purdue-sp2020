function [udist, dist] = Distance(point1, point2)

dist = [];
C1pos = point1(:,1:3);
diff1 = C1pos-point2;


x1 = diff1(:,1);
y1 = diff1(:,2);
z1 = diff1(:,3);

udist1 = [0,0,0,0];

for count = 1:1:length(x1)
    dist1 = sqrt((x1(count))^2+y1(count)^2+z1(count)^2);
    %dist2 = sqrt((x2(count))^2+y2(count)^2+z2(count)^2);
    %dist3 = sqrt((x3(count))^2+y3(count)^2+z3(count)^2);
    %dist4 = sqrt((x4(count))^2+y4(count)^2+z4(count)^2);
    dist = [dist, dist1];
    udist1(count,1:3) = diff1(count,:)./dist1;
    %udist2(count,1:3) = diff2(count,:)./dist2;
    %udist3(count,1:3) = diff3(count,:)./dist3;
    %udist4(count,1:3) = diff4(count,:)./dist4;
    
end
ux1 = udist1(:,1);
uy1 = udist1(:,2);
uz1 = udist1(:,3);

udist = [udist1];
    