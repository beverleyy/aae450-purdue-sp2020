%%%%%CMG Sizing and equations

ZTorqueBev = 1.0564;%Interplanetary torque in the z-direction
missiontime = 4.73* 10^8; %predicited length of the mission in seconds
sf = 1.3; %safety factor for cmg's
Lreq = ZTorqueBev*missiontime * sf; %integrate torques by time, with a safety factor 



wf = 6600/60*2*pi;%radians per second rotation rate of the flywheel
densityf = 8000;%kg/m^3 %density of the flywheel as stainless steel
grate = [0,deg2rad(3.1),0];%rad/s max rotation rate of the gimbals
wf = [0 , 0,wf];
thetap = deg2rad(53.1);%angle of the orientation of the pyrimad orientation
%of the gyroscopes

%calculates the maximum Angular Momentum in any direction for a given
%radius of gyrscope in the pyrimadal configuration
for rf =1:.1:100
    hf = rf/10;
    vf = hf* rf^2*pi;%m^3
    mf = densityf*vf;%kg
    Ixf = .5 * mf * rf^2;%kg*m^2
    Lf = wf(3)*Ixf;
    Lmax = 4*sin(thetap)*Lf;
    if Lmax > Lreq
        break
    end
    
end

mCMG = safetyfacror *mf;
Iyf = 1/12*mf*(3*rf^2+hf^2);%kg*m^2
Izf = Iyf;
If = [Ixf, 0, 0; 0,Iyf,0;0,0,Izf]; %moment of inertia of the flywheel
t = cross(grate,If*wf'); %max torque the CMGs can put out
%P = .5 * ZTorqueBev *grate; Attempt to find power consumed
vCMG = (rf* 1.2*2)^3;  %voulume approximate of CMG as 
%RCS 
refuel = 1917* 3600 * 24;%time seconds
thrust = 5.4* 2;%thrust available for two thrusters in either z direction
length = 400;%m of torque arm
Angularmomreq = ZTorqueBev * refuel; %how much angular momentum needs to be 
%undone over the longest time between refuelings
thrusttime = Angularmomreq/(length * thrust);%secs how long
%we need to thrust in order to undo the Angular Momentum Requirement
thrusttime = thrusttime / 3600;% change to hours

