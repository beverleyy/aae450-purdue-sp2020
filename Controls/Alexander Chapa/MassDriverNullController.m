function MassDriverNullController

time = 4*60+14;
ti = [0:.001:time];

mass = 80*10^3+31207;

M = 1/(4*pi());
x = 1.07*80;
y = .50*80;
z = .0001;
mu = 4*pi()*10^(-7);
N = 2800;
H = M*(atan((x*y)/(z*(x^2+y^2+z^2)^(1/2)))*atan((y*z)/(x*((x^2+y^2+z^2)^(1/2)))));
B = 2*mu*H;
Marsg = 3.711;
Lneed = mass * Marsg;
Force = [];
%Lift = [];
Current = [];
for count = [0:.001:time]
    f = Lneed - (31.207*rand(1,1));
    Force = [Force, f];
    I = (Lneed - f)/(2*N*B);
    f = Lneed;
    Current = [Current, I];
end
    
    
figure
plot(ti,Force)
title('The force exerted on the taxi to incur Lift')
xlabel('time (s)')
ylabel('Lift (N)')
xlim([0,1])

figure
plot(ti,Current)
title('The current running through the Null Flux Coils')
xlabel('time (s)')
ylabel('Current (A)')
xlim([0,0.5])
ylim([0,40000000000])

%lift = 2*turns*B*I;