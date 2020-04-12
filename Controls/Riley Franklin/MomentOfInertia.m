%%%%Moment of Inertia of the Cycler

b = 52;%Length of the habitation modules in m
habwidth = 6+2.4;%width of one habitation module
lengthcenterhab = 36.3;%length of the central hab connector
habheight = 2.5;%height from ceiing to floor
widthcenterhab = 10+2.4;%Width of central hab in meters
d = 2 * habwidth +lengthcenterhab;
h = lengthcenterhab;
t = widthcenterhab;
s = habwidth;
l = 400;%length of support in meters
g = 9.81%acceleration in hab modules
Volumehab =(habwidth)* 2.5 *(b) -(habwidth-2.4)* 2.5 *(b-2.4);
Volumehabcenter = (widthcenterhab)*(lengthcenterhab)*(2.5) -(widthcenterhab-2.4)*(lengthcenterhab)*(2.5);

%moments of inertia for the habitation unit as a cross section of an I beam
IyyI = (b*d^3- h^3*(b-t))/12;
IzzI = (2*s*b^3+h*t^3)/12;
IxxI = IzzI+IyyI;

%moment of inertia of the habitation Unit before parallel axis theorom
Ibeforepa = [IxxI 0 0; 0 IyyI 0;0 0 IzzI];

densitycyc = 2710;%kg/m^3 desnity of aluminum
MassI = (Volumehab*2+Volumehabcenter)*(densitycyc);
Ihab = Ibeforepa +[0 0 0;0 400^2 0;0 0 400^2]*MassI;

%Moment of inertia of the Habitation Unit after parallel axis theorem
Ihabbar = [Ihab(1,1) Ihab(2,2) Ihab(3,3)];
wCyc = [0,0,sqrt(g/l)];
rSS = 10; %radius of Superstructure 
hSS = 50; %height of superstructure
VSS = rSS^2 *pi * hSS;%Volume of SS in m^3
mSS = densitycyc * VSS;%mass of Superstructure with density assumedot be of aluminum

%The super structures moment of Inertia modeled as a cylinder 
ISuper = [1/12*mSS*(3*rSS^2+h^2),1/12*mSS*(3*rSS^2+h^2),1/2 * mSS * rSS];
odElev = 2.5;%m Outer diameter of Elevator
idElev = 2;%m Innderdiameter elevator
hElev = 388.88;%m Length of Elevator
VElev = h * pi * (odElev^2-idElev^2);
mElev = densitycyc * VElev;%mass of elevator
IxxE = 1/2 *  mElev * (odElev^2+idElev^2);
IyyE = 1/12 * mElev * (3*(odElev^2+idElev^2)+hElev^2);
IzzE = IyyE;

%Moment of Inertia for the elevator as a hollow cylinder
IElev = [IxxE,IyyE,IzzE];

%Moment of Inertia of the cycler modeled with two elevators, 
%two Habitation modules and the superstructure 
ICycler = 2 * (IElev+Ihabbar)+ISuper;


%angular momentum of the cycler at a rate of rotation that gives us
%1 g of acceleration in the habitation modules
LCycler = cross(ICycler,wCyc)
Lreq = norm(LCycler)/2;