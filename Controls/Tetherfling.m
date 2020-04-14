function Tetherfling(ID, Current_ad)
Mass = [217863, 31168, 41307];
Length = [1353, 680, 825];
Tipspeed = [5.1515, 3.6508, 4.0218];
Name = ['Luna', 'Phobos', 'Mars'];
name = Name(ID);
length = Length(ID)*10^3;
mass = Mass(ID)*10^3*3;
tip_0 = Tipspeed(ID)*10^3;
torque = 789*10^9;
Inertia = mass*length^2/12;


gain = torque/Inertia;
ad = tip_0/(2*pi()*length)*360
neededad = ad-Current_ad;
tneed = neededad/gain/60/60

Alphadot = [];
Alpha = Current_ad;
for t = 0:1000:tneed*20
    if((tip_0-Alpha)>gain*1000)
        Alpha = Alpha + gain*1000;
    elseif((tip_0-Alpha)<-gain*1000)
        Alpha = Alpha - gain*1000;
    else
        Alpha = tip_0;
    end
    Alphadot = [Alphadot Alpha];
end
   
ti = [0:1000:tneed*20];

figure
plot(ti,Alphadot,'b')
xlabel('Time (sec)')
ylabel('Angular Velocity (deg/s)')
title('The Angular Velocity Profile of the Tether Sling for Departing Taxi')
ylim([0 Alpha*2])
grid on
    