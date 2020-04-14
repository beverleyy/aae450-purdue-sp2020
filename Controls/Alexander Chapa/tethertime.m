function tethertime(current_adot, Taxi_speed, ID)
Mass = [217863, 31168, 41307];
Length = [1353, 680, 825];
Name = ['Luna', 'Phobos', 'Mars'];
name = Name(ID);
length = Length(ID)*10^3;
mass = Mass(ID)*10^3;
t = [0:1:3600*36];
maxtorque = 16*10^9
len_m = length;
Inertia = mass*(len_m^2)/12
gain =  maxtorque/Inertia
adot = .47/(2*pi()*700)*360

min = adot-maxtorque/Inertia*t;
max = adot+maxtorque/Inertia*t;

av_min = (adot-min)/2.*t;
av_max = (adot+max)/2.*t;

range = gain.*t.^2;

output = (range.*3)./360;

F = sqrt(360/(3*gain))/3600

plot(t./3600,output)
title('Percent of the Circumference that Taxi is able to rendzvous with Tether')
xlabel('Time Before Arrival (hr)')
ylabel('Percent of Circumference')
grid on


