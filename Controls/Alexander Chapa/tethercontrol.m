function output = tethercontrol(ID, Current_adot, Current_a, Taxi_speed, Catch_point, time)
%Current_a will be the current angle of the 
Mass = [217863, 31168, 41307];
Length = [1353, 680, 825];
Tipspeed = [5.1515, 3.6508, 4.0218];
Name = ['Luna', 'Phobos', 'Mars'];
name = Name(ID);
length = Length(ID)*10^3;
mass = Mass(ID)*10^3*3;
tip_0 = Tipspeed(ID)*10^3;
torque = 16*10^9;
stime = time*60*60;
%commented out due to the fact 
angledot = Current_adot
angle = Current_a
%tipneed = Taxispeed*10^3;

Inertia = mass*length^2/12;
% while((dist1 > length)&(t<(mindist/taxispeed*2)))
%     [udist1, dist1] = Distance([0,0,0],Taxipos1);
%     Taxipos1 = Taxipos1 + taxispeed*dt*taxi_direction;
%     t = t + dt;
% end
%taxiangle = atan2d(sind(dist1*udist1(2)/length),cosd(dist1*udist1(1)/length));
gain = torque/Inertia;
taxiangle = Catch_point;
%angledot = tip_0/(2*pi()*length)*360;
%angle = 360*rand(1,1);
angledotneed = Taxi_speed/(2*pi()*length)*360;

arm1angle = angle;
arm2angle = arm1angle +120;
arm3angle = arm1angle -120;

arm1anglef = arm1angle*stime;
arm2anglef = arm1anglef+120;
arm3anglef = arm1anglef-120;

if((angledot * stime)<120)
    fprintf('too close')
    if((arm1anglef-taxiangle) <= (arm2anglef-taxiangle))
       if((arm1anglef-taxiangle)<=(arm3anglef-taxiangle))
        alpha = arm1anglef;
       else
        alpha = arm3anglef;
       end
    elseif((arm3anglef-taxiangle)<=(arm2anglef-taxiangle))
    alpha = arm3anglef;
   else
    alpha = arm2anglef;
    end
else
    if((arm1anglef-taxiangle) <= (arm2anglef-taxiangle))
    if((arm1anglef-taxiangle)<=(arm3anglef-taxiangle))
        alpha = arm1anglef;
    else
        alpha = arm3anglef;
    end
elseif((arm3anglef-taxiangle)<=(arm2anglef-taxiangle))
    alpha = arm3anglef;
else
    alpha = arm2anglef;
    end
end

alpha_need = taxiangle - alpha;


avg_ad_inc = (alpha + alpha_need)/stime;
avg_ad = (angledot+angledotneed)/2;

first_change_time = abs((angledot-avg_ad)/(gain));
avg_first_ad = (angledot-avg_ad)/2;
last_change_time = abs((avg_ad-angledotneed)/(gain));
avg_last_ad = (avg_ad-angledotneed)/2;

avg_change_ad = (first_change_time*avg_first_ad + last_change_time*avg_last_ad)/(first_change_time+last_change_time);
total_change_time = first_change_time+last_change_time;

if((avg_ad < angledot) & (avg_ad < angledotneed))
    etime = time-total_change_time;
    g = 1;
    
elseif(avg_ad == angledotneed)
    etime = 2*total_change_time;
    if(avg_ad < angledot)
       g=2;
    else
       g =6;
    end
    
elseif((avg_ad > angledot) & (avg_ad > angledotneed))
    etime = time-total_change_time;
    g = 3;
else
    add_change = avg_ad-avg_change_ad;
    if(add_change > 0)
        etime = (total_change_time*(avg_change_ad-avg_ad))/(avg_ad-angledot);
        g = 4;
    else
        etime = (total_change_time*(avg_change_ad-avg_ad))/(avg_ad-angledotneed);
        g = 5;
    end
end
t = 0;
AlphadotHist = Tetherhistory(angledot, angledotneed, first_change_time, last_change_time, etime, g, stime, torque, Inertia, avg_change_ad, avg_ad);

figure
timehist = [0:.001:stime+.001];
plot(timehist,AlphadotHist,'r')
title('The Angular velocity over time of the phobos tether')
xlabel('Time (s)')
ylabel('Angular Velocity of Tether (deg/s)')
output =t;
    
    
        

   


