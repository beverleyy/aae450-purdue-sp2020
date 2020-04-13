Iyf = 1/12*mf*(3*rf^2+hf^2);%kg*m^2
Izf = Iyf;
If = [Ixf, 0, 0; 0,Iyf,0;0,0,Izf]; %moment of inertia of the flywheel
torquemax = cross(grate,If*wf')


figure(1)
hold on
len =length(w_dot.time)
plot(w_dot.time(len/2:len/2+1000),w_dot.Data(len/2:len/2+1000))
t =3718:.01:3790;
plot(t,wCyc(3)+zeros(1,length(t)),'--')
xlim([3787,3790])
xlabel('simulation time(s)')
ylabel('angular velocity(rad/s)')
title('Simulation Angular Velocity')
legend('Simulation Results','1 g angular velocity')
hold off
