%Propulsion System

%Intial Condidtions
totalmass = 9400; %Mg
forceneed = totalmass * .01; %N
disp('forceneed = '),disp(forceneed)

x3mass = .23; %Mg
x3thrust = 5.4; %N
numx3 = 18;
fullthrust = x3thrust * numx3; %N
excessthrust = fullthrust - forceneed; %N
disp('excessthrust = '),disp(excessthrust)

x3power = 100; %kw
fullpower = x3power * numx3; %kw
disp('fullpower = '),disp(fullpower)

%Fuel Analysis
isp = 2470;
deltav = 324; %m/s
g = 9.80665; %m/s^2
density = 2.942; %Mg/m^3
massflow = 3900*density/1e6*numx3; %kg/min
mr = exp(deltav/(g*isp));
totalpropmass = mr*totalmass - totalmass; %Mg
totalpropvolume = totalpropmass/(density); %m^3
disp('totalpropmass = '),disp(totalpropmass),disp('totalpropvolume = '),disp(totalpropvolume)

isp2 = 450; %liquid oxygen-liquid hydrogen
mr2 = exp(deltav/(g*isp2));
totalpropmass2 = mr2*totalmass - totalmass;%Mg
disp('totalpropmass2 = '),disp(totalpropmass2)

%Tank Analysis
tankradius= 1.9; %m
tankheight= 4;%m
tankthickness= .01; %m
tankvolume = pi*tankheight*tankradius^2;
tankdensity = 4.5; %Mg/m^3
tankmass = (2*pi*tankradius*tankheight+2*pi*tankradius^2)*tankthickness*tankdensity;
disp('tankvolume = '),disp(tankvolume),disp('tankmass = '),disp(tankmass)

tensilestrength = 550; %mpa
maxworkingstress = tensilestrength/1.4;
press = tankthickness*maxworkingstress/tankradius;
disp('press = '),disp(press)

%RCS Analysis

%Intial Conditions
powerarea = 300; %W/m^2
specificpower = 80; %W/kg
power = 2000000; %W
irradiance = 0.4305564167; %irradiance phobos
surfacearea = 8516; %m^2
mass = 52250; %kg
forceneed = 1.5; %N

%Medium Ion Thruster
forcenx = .237; %N
numnx = 4*forceneed/forcenx;
nextpower = 110400 *numnx/2; %W
nxp = power+nextpower;
nxsa = nxp/(powerarea*irradiance);
nxmass = nxp/(specificpower*irradiance);
nxthrustmass = numnx*(.5+.0135+.00095+.00077+.01477+.00251+.075);
disp('numnx = '),disp(numnx),disp('nextpower = '),disp(nextpower),disp('nxthrustmass = '),disp(nxthrustmass)

%Low Ion Thruster
forcens = .092; %N
numsa = 4*forceneed/forcens;
nstarpower = 2300*numsa/2;
nsp = power+nstarpower;
nssa = nsp/(powerarea*irradiance);
nsmass = nsp/(specificpower*irradiance);
nsthrustmass = numsa*(.5+.025+.00077+.00095+.0017+.00251+.01477+.0082);
disp('numsa = '),disp(numsa),disp('nstarpower = '),disp(nstarpower),disp('nsthrustmass = '),disp(nsthrustmass)

%Monopropellant Prop
noprop = power - 1800000;
solarmass =(mass- noprop/(specificpower*irradiance))/1000;
chemicalrcs = 4*(1464+923+77)/220.5; %Mg
disp('chemicalrcs = '),disp(chemicalrcs)

%Large Ion Thruster (Used)
rcstime = 12; %hr
rcsmass = 3900*(1.5/5.4)*rcstime*60*density/1e6;
rcsvolume = rcsmass/(density); %m^3
rcspower = 2*20000; %W
rcstankrad = .59;
rcstankheight = .9;
disp('rcsmass = '),disp(rcsmass),disp('rcsvolume = '),disp(rcsvolume),disp('rcspower = '),disp(rcspower)

rcstankvol = pi*rcstankheight*rcstankrad^2;
rcstankmass = (2*pi*rcstankrad*rcstankheight+2*pi*tankradius^2)*tankthickness*tankdensity;
rcspress = tankthickness*maxworkingstress/rcstankrad;
rcstotalmass = 4*(rcsmass+rcstankmass+.23);
disp('rcstankvol = '),disp(rcstankvol),disp('rcstankmass = '),disp(rcstankmass),disp('rcspress = '),disp(rcspress)
disp('rcstotalmass = '),disp(rcstotalmass)

%Total Configuration
systemmass =totalpropmass+x3mass*numx3+tankmass+(mass/1000);%Mg
disp('systemmass = '),disp(systemmass)

