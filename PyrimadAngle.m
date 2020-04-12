%%below is the code used to find the optimal pyramid angle for 
%%a very even momentum envelope it was used to find an agle of 
%%53.1 so that is what will be used for the code above, that is sizing
%%the flywheel
wf = 6600/60*2*pi;%radians per second rotation rate of the flywheel
densityf = 8000;%kg/m^3 %density of the flywheel as stainless steel
grate = [0,deg2rad(3.1),0];%rad/s max rotation rate of the gimbals
wf = [0 , 0,wf];
thetap = deg2rad(53.1);%angle of the orientation of the pyrimad orientation
%of the gyroscopes
check=100
for i = 0:.1:90 
    thetap = deg2rad(i);
    hf = wf(3)%*Ixf
    hmax = 4*sin(thetap)*hf
    hcheck = hf * 2*(1+cos(thetap))
    t = norm(norm(hcheck) - norm(hmax));
    if t< check
        pyramidangle = i
        check = t
    end
end
% rcmsp = 100;%arm that the torque will act about for solar panels
% SAsp = 13440;%surface area of solarpanels
% aveforcesp= .0000033;%Newton per m^2 average froce from solar radiatin
% timestoringrad = Lreq/(SAsp * rcmsp*aveforcesp)/(3600*24*365);

% TorqueRCS =Lreq /(3600 * 24 * 400*10); 
% G = 6.67 * 10 ^-11;
% GravTorque = 3* G;
