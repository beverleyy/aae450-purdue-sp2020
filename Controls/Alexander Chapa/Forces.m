function [output,output2] = Forces(input, SurfaceArea)
time = input.Vehicle1.julian_date;
x1EMO1 = input.Vehicle1.position(:,1);
y1EMO1 = input.Vehicle1.position(:,2);
z1EMO1 = input.Vehicle1.position(:,3);
x2EMO1 = input.Vehicle2.position(:,1);
y2EMO1 = input.Vehicle2.position(:,2);
z2EMO1 = input.Vehicle2.position(:,3);
x3EMO1 = input.Vehicle3.position(:,1);
y3EMO1 = input.Vehicle3.position(:,2);
z3EMO1 = input.Vehicle3.position(:,3);
x4EMO1 = input.Vehicle4.position(:,1);
y4EMO1 = input.Vehicle4.position(:,2);
z4EMO1 = input.Vehicle4.position(:,3);

[time1, burn1] = FilterJDate(input.Vehicle1.julian_date);% filters the julian dates to seperate out burn times
[time2, burn2] = FilterJDate(input.Vehicle2.julian_date);
[time3, burn3] = FilterJDate(input.Vehicle3.julian_date);
[time4, burn4] = FilterJDate(input.Vehicle4.julian_date);

x1EMO = x1EMO1(time1,:);
y1EMO = y1EMO1(time1,:);
z1EMO = z1EMO1(time1,:);
x2EMO = x2EMO1(time2,:);
y2EMO = y2EMO1(time2,:);
z2EMO = z2EMO1(time2,:);
x3EMO = x3EMO1(time3,:);
y3EMO = y3EMO1(time3,:);
z3EMO = z3EMO1(time3,:);
x4EMO = x4EMO1(time4,:);
y4EMO = y4EMO1(time4,:);
z4EMO = z4EMO1(time4,:);


E = 23 ;%degrees, axial tilt of earth

I_cycler = [5.7471*10^9, 8.1572*10^11,  8.1019*10^11]; %moment of inertia for the cycler

Cyclerpos1 = EMO2EME([x1EMO(time1), y1EMO(time1), z1EMO(time1)], E);
Cyclerpos2 = EMO2EME([x2EMO(time2), y2EMO(time2), z2EMO(time2)], E);
Cyclerpos3 = EMO2EME([x3EMO(time3), y3EMO(time3), z3EMO(time3)], E);
Cyclerpos4 = EMO2EME([x4EMO(time4), y4EMO(time4), z4EMO(time4)], E);

x1 = Cyclerpos1(1,:);
y1 = Cyclerpos1(2,:);
z1 = Cyclerpos1(3,:);
x2 = Cyclerpos2(1,:);
y2 = Cyclerpos2(2,:);
z2 = Cyclerpos2(3,:);
x3 = Cyclerpos3(1,:);
y3 = Cyclerpos3(2,:);
z3 = Cyclerpos3(3,:);
x4 = Cyclerpos4(1,:);
y4 = Cyclerpos4(2,:);
z4 = Cyclerpos4(3,:);

Planetpos1 = xlsread('Planetposition.xlsx', 'Sheet1', 'A4:AB13110');
Planetpos2 = xlsread('Planetposition.xlsx', 'Sheet2', 'A4:AB13145');
Planetpos3 = xlsread('Planetposition.xlsx', 'Sheet3', 'A4:AB13962');
Planetpos4 = xlsread('Planetposition.xlsx', 'Sheet4', 'A4:AB14219');

[udistSun1, dist_Sun1] = Distance(Cyclerpos1,[0,0,0]);
[udistSun2, dist_Sun2] = Distance(Cyclerpos2,[0,0,0]);
[udistSun3, dist_Sun3] = Distance(Cyclerpos3,[0,0,0]);
[udistSun4, dist_Sun4] = Distance(Cyclerpos4,[0,0,0]);

[posMercury1, posVenus1, posEarth1, posMoon1, posMars1, posJupiter1, posSaturn1, posUranus1, posNeptune1] = PlanetSplitinAU(Planetpos1(time1,:));
[posMercury2, posVenus2, posEarth2, posMoon2, posMars2, posJupiter2, posSaturn2, posUranus2, posNeptune2] = PlanetSplitinAU(Planetpos2(time2,:));
[posMercury3, posVenus3, posEarth3, posMoon3, posMars3, posJupiter3, posSaturn3, posUranus3, posNeptune3] = PlanetSplitinAU(Planetpos3(time3,:));
[posMercury4, posVenus4, posEarth4, posMoon4, posMars4, posJupiter4, posSaturn4, posUranus4, posNeptune4] = PlanetSplitinAU(Planetpos4(time4,:));



% L1 = length(x1EMO)
% L2 = length(posMercury(:,1))
% L3 = length(x1)
%input2 = [x1,y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4];

%Cycler 1 distances
[uC_Me1, distC_Me1] = Distance(Cyclerpos1, posMercury1);
[uC_V1, distC_V1] = Distance(Cyclerpos1, posVenus1);
[uC_E1, distC_E1] = Distance(Cyclerpos1, posEarth1);
[uC_Ma1, distC_Ma1] = Distance(Cyclerpos1, posMars1);
[uC_J1, distC_J1] = Distance(Cyclerpos1, posJupiter1);
[uC_S1, distC_S1] = Distance(Cyclerpos1, posSaturn1);
[uC_U1, distC_U1] = Distance(Cyclerpos1, posUranus1);
[uC_N1, distC_N1] = Distance(Cyclerpos1, posNeptune1);
[uC_Mo1, distC_Mo1] = Distance(Cyclerpos1, posMoon1);

%Cycler 2 distances
[uC_Me2, distC_Me2] = Distance(Cyclerpos2, posMercury2);
[uC_V2, distC_V2] = Distance(Cyclerpos2, posVenus2);
[uC_E2, distC_E2] = Distance(Cyclerpos2, posEarth2);
[uC_Ma2, distC_Ma2] = Distance(Cyclerpos2, posMars2);
[uC_J2, distC_J2] = Distance(Cyclerpos2, posJupiter2);
[uC_S2, distC_S2] = Distance(Cyclerpos2, posSaturn2);
[uC_U2, distC_U2] = Distance(Cyclerpos2, posUranus2);
[uC_N2, distC_N2] = Distance(Cyclerpos2, posNeptune2);
[uC_Mo2, distC_Mo2] = Distance(Cyclerpos2, posMoon2);

%Cycler 3 distances
[uC_Me3, distC_Me3] = Distance(Cyclerpos3, posMercury3);
[uC_V3, distC_V3] = Distance(Cyclerpos3, posVenus3);
[uC_E3, distC_E3] = Distance(Cyclerpos3, posEarth3);
[uC_Ma3, distC_Ma3] = Distance(Cyclerpos3, posMars3);
[uC_J3, distC_J3] = Distance(Cyclerpos3, posJupiter3);
[uC_S3, distC_S3] = Distance(Cyclerpos3, posSaturn3);
[uC_U3, distC_U3] = Distance(Cyclerpos3, posUranus3);
[uC_N3, distC_N3] = Distance(Cyclerpos3, posNeptune3);
[uC_Mo3, distC_Mo3] = Distance(Cyclerpos3, posMoon3);

%Cycler 4 distances
[uC_Me4, distC_Me4] = Distance(Cyclerpos4, posMercury4);
[uC_V4, distC_V4] = Distance(Cyclerpos4, posVenus4);
[uC_E4, distC_E4] = Distance(Cyclerpos4, posEarth4);
[uC_Ma4, distC_Ma4] = Distance(Cyclerpos4, posMars4);
[uC_J4, distC_J4] = Distance(Cyclerpos4, posJupiter4);
[uC_S4, distC_S4] = Distance(Cyclerpos4, posSaturn4);
[uC_U4, distC_U4] = Distance(Cyclerpos4, posUranus4);
[uC_N4, distC_N4] = Distance(Cyclerpos4, posNeptune4);
[uC_Mo4, distC_Mo4] = Distance(Cyclerpos4, posMoon4);



%L1 = [length(uC_Me(1,:)),length(uC_Me(:,1))];
% Radiation from sun
Rss = dist_Sun;
c = 2.998*10^8;
k = 1;
fO=1361; %W/m^2
Force_rad = k.*SurfaceArea.*fO./(c.*Rss.^2);

%                      Force_sunrad = udistSun.*Force_rad;

% Reflected Solar rad

Me_radius = 2439.7;
V_radius = 6051.8;
E_radius = 6378.1;
Ma_radius = 3396.2;
J_radius = 71492;
S_radius = 60268;
U_radius = 25559;
N_radius = 24764;
Mo_radius = 1738.1;

Me_a = 0.119;
V_a = 0.75;
E_a = 0.29;
Mo_a = 0.123;
Ma_a = 0.16;
J_a = 0.343;
S_a = 0.342;
U_a = 0.29;
N_a = 0.31;


sun_rad_Me1 = reflective_solar_rad(SurfaceArea,Me_a,Me_radius,fO,c,posMercury1,distC_Me1);
sun_rad_V1 = reflective_solar_rad(SurfaceArea,V_a,V_radius,fO,c,posVenus1,distC_V1);
sun_rad_E1 = reflective_solar_rad(SurfaceArea,E_a,E_radius,fO,c,posEarth1,distC_E1);
sun_rad_Ma1 = reflective_solar_rad(SurfaceArea,Ma_a,Ma_radius,fO,c,posMars1,distC_Ma1);
sun_rad_J1 = reflective_solar_rad(SurfaceArea,J_a,J_radius,fO,c,posJupiter1,distC_J1);
sun_rad_S1 = reflective_solar_rad(SurfaceArea,S_a,S_radius,fO,c,posSaturn1,distC_S1);
sun_rad_U1 = reflective_solar_rad(SurfaceArea,U_a,U_radius,fO,c,posUranus1,distC_U1);
sun_rad_N1 = reflective_solar_rad(SurfaceArea,N_a,N_radius,fO,c,posNeptune1,distC_N1);
sun_rad_Mo1 = reflective_solar_rad(SurfaceArea,Mo_a,Mo_radius,fO,c,posMoon1,distC_Mo1);

sun_rad_Me2 = reflective_solar_rad(SurfaceArea,Me_a,Me_radius,fO,c,posMercury2,distC_Me2);
sun_rad_V2 = reflective_solar_rad(SurfaceArea,V_a,V_radius,fO,c,posVenus2,distC_V2);
sun_rad_E2 = reflective_solar_rad(SurfaceArea,E_a,E_radius,fO,c,posEarth2,distC_E2);
sun_rad_Ma2 = reflective_solar_rad(SurfaceArea,Ma_a,Ma_radius,fO,c,posMars2,distC_Ma2);
sun_rad_J2 = reflective_solar_rad(SurfaceArea,J_a,J_radius,fO,c,posJupiter2,distC_J2);
sun_rad_S2 = reflective_solar_rad(SurfaceArea,S_a,S_radius,fO,c,posSaturn2,distC_S2);
sun_rad_U2 = reflective_solar_rad(SurfaceArea,U_a,U_radius,fO,c,posUranus2,distC_U2);
sun_rad_N2 = reflective_solar_rad(SurfaceArea,N_a,N_radius,fO,c,posNeptune2,distC_N2);
sun_rad_Mo2 = reflective_solar_rad(SurfaceArea,Mo_a,Mo_radius,fO,c,posMoon2,distC_Mo2);

sun_rad_Me3 = reflective_solar_rad(SurfaceArea,Me_a,Me_radius,fO,c,posMercury3,distC_Me3);
sun_rad_V3 = reflective_solar_rad(SurfaceArea,V_a,V_radius,fO,c,posVenus3,distC_V3);
sun_rad_E3 = reflective_solar_rad(SurfaceArea,E_a,E_radius,fO,c,posEarth3,distC_E3);
sun_rad_Ma3 = reflective_solar_rad(SurfaceArea,Ma_a,Ma_radius,fO,c,posMars3,distC_Ma3);
sun_rad_J3 = reflective_solar_rad(SurfaceArea,J_a,J_radius,fO,c,posJupiter3,distC_J3);
sun_rad_S3 = reflective_solar_rad(SurfaceArea,S_a,S_radius,fO,c,posSaturn3,distC_S3);
sun_rad_U3 = reflective_solar_rad(SurfaceArea,U_a,U_radius,fO,c,posUranus3,distC_U3);
sun_rad_N3 = reflective_solar_rad(SurfaceArea,N_a,N_radius,fO,c,posNeptune3,distC_N3);
sun_rad_Mo3 = reflective_solar_rad(SurfaceArea,Mo_a,Mo_radius,fO,c,posMoon3,distC_Mo3);

sun_rad_Me4 = reflective_solar_rad(SurfaceArea,Me_a,Me_radius,fO,c,posMercury2,distC_Me4);
sun_rad_V4 = reflective_solar_rad(SurfaceArea,V_a,V_radius,fO,c,posVenus2,distC_V4);
sun_rad_E4 = reflective_solar_rad(SurfaceArea,E_a,E_radius,fO,c,posEarth2,distC_E4);
sun_rad_Ma4 = reflective_solar_rad(SurfaceArea,Ma_a,Ma_radius,fO,c,posMars2,distC_Ma4);
sun_rad_J4 = reflective_solar_rad(SurfaceArea,J_a,J_radius,fO,c,posJupiter2,distC_J4);
sun_rad_S4 = reflective_solar_rad(SurfaceArea,S_a,S_radius,fO,c,posSaturn2,distC_S4);
sun_rad_U4 = reflective_solar_rad(SurfaceArea,U_a,U_radius,fO,c,posUranus2,distC_U4);
sun_rad_N4 = reflective_solar_rad(SurfaceArea,N_a,N_radius,fO,c,posNeptune2,distC_N4);
sun_rad_Mo4 = reflective_solar_rad(SurfaceArea,Mo_a,Mo_radius,fO,c,posMoon2,distC_Mo4);


Sun_ref_rad1 = uC_Me1.*sun_rad_Me1 + uC_V1.*sun_rad_V1 + uC_E1.*sun_rad_E1 + uC_Ma1.*sun_rad_Ma1 + uC_J1.*sun_rad_J1 + uC_S1.*sun_rad_S1 + uC_U1.*sun_rad_U1 + uC_N1.*sun_rad_N1 + uC_Mo1.*sun_rad_Mo1;
Sun_ref_rad2 = uC_Me2.*sun_rad_Me2 + uC_V2.*sun_rad_V2 + uC_E2.*sun_rad_E2 + uC_Ma2.*sun_rad_Ma2 + uC_J2.*sun_rad_J2 + uC_S2.*sun_rad_S2 + uC_U2.*sun_rad_U2 + uC_N2.*sun_rad_N2 + uC_Mo2.*sun_rad_Mo2;
Sun_ref_rad3 = uC_Me3.*sun_rad_Me3 + uC_V3.*sun_rad_V3 + uC_E3.*sun_rad_E3 + uC_Ma3.*sun_rad_Ma3 + uC_J3.*sun_rad_J3 + uC_S3.*sun_rad_S3 + uC_U3.*sun_rad_U3 + uC_N3.*sun_rad_N3 + uC_Mo3.*sun_rad_Mo3;
Sun_ref_rad4 = uC_Me4.*sun_rad_Me4 + uC_V4.*sun_rad_V4 + uC_E4.*sun_rad_E4 + uC_Ma4.*sun_rad_Ma4 + uC_J4.*sun_rad_J4 + uC_S4.*sun_rad_S4 + uC_U4.*sun_rad_U4 + uC_N4.*sun_rad_N4 + uC_Mo4.*sun_rad_Mo4;
% Solar wind

Sun_wind = 2.3*10^(-9)./dist_Sun;
%Force_sun_wind = udistSun.*Sun_wind;

%planet radiation

Me_temp = 438+273;
V_temp = 468+273;
E_temp = 25+273;
Ma_temp = -28 + 273;
J_temp = -119+273;
S_temp = -139 + 273;
U_temp = -196 + 273; 
N_temp = -202 + 273;

P_rad_Me = Planetradiation(SurfaceArea, Me_temp, Me_radius, c, distC_Me);
P_rad_Ma = Planetradiation(SurfaceArea, Ma_temp, Ma_radius, c, distC_Ma);
P_rad_Mo = Planetradiation(SurfaceArea, Ma_temp, Mo_radius, c, distC_Mo);
P_rad_V = Planetradiation(SurfaceArea, V_temp, V_radius, c, distC_V);
P_rad_E = Planetradiation(SurfaceArea, E_temp, E_radius, c, distC_E);
P_rad_J = Planetradiation(SurfaceArea, J_temp, J_radius, c, distC_J);
P_rad_S = Planetradiation(SurfaceArea, S_temp, S_radius, c, distC_S);
P_rad_U = Planetradiation(SurfaceArea, U_temp, U_radius, c, distC_U);
P_rad_N = Planetradiation(SurfaceArea, N_temp, N_radius, c, distC_N);

%P_rad = uC_Me.*P_rad_Me + uC_V.*P_rad_V + uC_E.*P_rad_E + uC_Ma.*P_rad_Ma + uC_J.*P_rad_J + uC_S.*P_rad_S + uC_U.*P_rad_U + uC_N.*P_rad_N + uC_Mo.*P_rad_Mo;


% Total net force 
%Net_Force = P_rad + Force_sun_wind + Sun_ref_rad + Force_sunrad;
%Plotting
counter = linspace(0,length(Force_rad(:,1)),length(Force_rad(:,1)));
%vehiles force
uuu = sum(Force_rad(4,:));
figure(1)
plot(counter,Force_rad(:,1),'r');
hold on;
plot(counter,Force_rad(:,2),'k');
plot(counter, Force_rad(:,3),'b');
plot(counter,Force_rad(:,4),'g');

title('Solar Radiation Force Excerted on the Cycle at Each Positon')
xlabel('Position')
ylabel('Force Felt (N)')
legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')

counter = linspace(0,length(P_rad_Me(:,1)),length(P_rad_Me(:,1)));
% figure(2)
% plot(counter,P_rad_Me(:,1),'r');
% hold on;
% plot(counter,P_rad_Me(:,2),'k');
% plot(counter, P_rad_Me(:,3),'b');
% plot(counter,P_rad_Me(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Mercury')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_E(:,1)),length(P_rad_E(:,1)));
% figure(3)
% plot(counter,P_rad_E(:,1),'r');
% hold on;
% plot(counter,P_rad_E(:,2),'k');
% plot(counter, P_rad_E(:,3),'b');
% plot(counter,P_rad_E(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Earth')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_V(:,1)),length(P_rad_V(:,1)));
% figure(4)
% plot(counter,P_rad_V(:,1),'r');
% hold on;
% plot(counter,P_rad_V(:,2),'k');
% plot(counter, P_rad_V(:,3),'b');
% plot(counter,P_rad_V(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Venus')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_Ma(:,1)),length(P_rad_Ma(:,1)));
% figure(5)
% plot(counter,P_rad_Ma(:,1),'r');
% hold on;
% plot(counter,P_rad_Ma(:,2),'k');
% plot(counter, P_rad_Ma(:,3),'b');
% plot(counter,P_rad_Ma(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Mars')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_J(:,1)),length(P_rad_J(:,1)));
% figure(6)
% plot(counter,P_rad_J(:,1),'r');
% hold on;
% plot(counter,P_radJ(:,2),'k');
% plot(counter, P_rad_J(:,3),'b');
% plot(counter,P_rad_J(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Jupiter')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_S(:,1)),length(P_rad_S(:,1)));
% figure(7)
% plot(counter,P_rad_S(:,1),'r');
% hold on;
% plot(counter,P_rad_S(:,2),'k');
% plot(counter, P_rad_S(:,3),'b');
% plot(counter,P_rad_S(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Saturn')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_U(:,1)),length(P_rad_U(:,1)));
% figure(8)
% plot(counter,P_rad_U(:,1),'r');
% hold on;
% plot(counter,P_rad_U(:,2),'k');
% plot(counter, P_rad_U(:,3),'b');
% plot(counter,P_rad_U(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Uranus')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_N(:,1)),length(P_rad_N(:,1)));
% figure(9)
% plot(counter,P_rad_N(:,1),'r');
% hold on;
% plot(counter,P_rad_N(:,2),'k');
% plot(counter, P_rad_N(:,3),'b');
% plot(counter,P_rad_N(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Neptune')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')
% 
% counter = linspace(0,length(P_rad_Mo(:,1)),length(P_rad_Mo(:,1)));
% figure(11)
% plot(counter,P_rad_Mo(:,1),'r');
% hold on;
% plot(counter,P_rad_Mo(:,2),'k');
% plot(counter, P_rad_Mo(:,3),'b');
% plot(counter,P_rad_Mo(:,4),'g');
% 
% title('Solar Radiation Force Refleced off of Moon')
% xlabel('Position')
% ylabel('Force Felt (N)')
% legend('Vehicle1','Vehicle2','Vehicle3','Vehicle4')

avg_Mo = sum(sum(P_rad_Mo))/4
avg_Me = sum(sum(P_rad_Me))/4
avg_Ma = sum(sum(P_rad_Ma))/4
avg_V = sum(sum(P_rad_V))/4
avg_E = sum(sum(P_rad_E))/4
avg_J = sum(sum(P_rad_J))/4
avg_S = sum(sum(P_rad_S))/4
avg_U = sum(sum(P_rad_U))/4
avg_N = sum(sum(P_rad_N))/4
avg_Sun = sum(sum(Force_rad))/4
avg_wind = sum(sum(Sun_wind))/4
%Vehicle distance

output = Force_rad(1,:);
output2 = sum(Force_rad');
rrr = input.Vehicle1.julian_date;

Force_rad_avg = sum(Force_rad/length(time))













    