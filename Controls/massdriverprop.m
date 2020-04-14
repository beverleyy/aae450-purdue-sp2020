function massdriverprop

mu_0 = 4*pi()*10^(-7);
Mag_den = .2*pi();
angle = 75;
y_0 = [1,1,1];
span = [0, 4*60+14];
mass = 31207+80*10^3;
dvneed = 4.77*10^3;
time = 4*60+14;
length = 25;
%force = mass*dvneed/time+53*10^3
Marsg = 3.711;
force = mass*dvneed/time + mass * Marsg;
V= 100;

%option = odeset('Reltol', 1e-9,'absTol', 1e-9);
%[t_sol, y_sol] = ode45(@(t, y) MassDriverODE(t,y),span,y_0,option);
f_0 = 0;
f = f_0;
I_0 = 1;
I = I_0;
ti = [0:.0001:time];
dfn = 0;
Force = [];
R = [];
Current = [];
for t = [0:.0001:time]
    r = (530).*rand(1,1)-265;
    f = f+r(1)+dfn;
    dfn = force - f;
    dIn = dfn/(2*length*32);
    I = I + dIn;
    Force = [Force, f];
    Current = [Current, I];
    R = [R, V/I];
end

ti = [0:.0001:time];
size(ti)
size(Force)
figure
plot(ti,Force)
title('The force exerted on the taxi')
xlabel('time (s)')
ylabel('Force (N)')
figure
plot(ti,Current)
title('The current running through the electromagnets')
xlabel('time (s)')
ylabel('Current (A)')
figure
plot(ti,R)
title('The resistance the electromagnets curcits')
xlabel('time (s)')
ylabel('Resistance (Ohms)')
% figure
% plot(t_sol,y_sol(:,1))
% figure
% plot(t_sol,y_sol(:,2))
% figure
% plot(t_sol,y_sol(:,3))
% %Max B is 32

%https://www.nature.com/articles/s41586-019-1293-1
%https://link.springer.com/article/10.1007/BF03325781
%https://link.springer.com/content/pdf/10.1007/BF03325781.pdf
%https://courses.lumenlearning.com/boundless-physics/chapter/magnetism-and-magnetic-fields/
%https://www.sciencedirect.com/topics/engineering/wrought-iron
%https://www.sciencealert.com/world-s-strongest-superconducting-magnet-32-tesla-record
%https://pdf.sciencedirectassets.com/271436/1-s2.0-S0019057807X60166/1-s2.0-S0019057807601918/main.pdf?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEOf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJHMEUCIQDjM1fBU1qw%2BtUg%2BCACfZrPpyDYmNJXUAMc%2F4R%2Be5PXiAIga8chmX%2Bk9XIznaEhjH3%2F5gnKP3bvkXin3fltJ44oa5gqvQMIwP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARACGgwwNTkwMDM1NDY4NjUiDEYp1I1juCrrXNFRWyqRAzsRWCwTdvyPwodIiqkWmt1X8N4UJi0Gy7PF4n7w7B0XHXVbt5sXJgCWdAdUuDq1Y3Q8hqVap9x6BQqAg07GBDm7mFi%2BsNXvt6bCpGWGmE%2BxhVCVV3FYJh4%2FRPA1fBgdwWepblGsQmsl0%2FhpGE7%2FSbCEwDqmoLZRkToM4tthClh0uLjrqGZki7BTvaAkBHYPbsyj6z51Hv1QwzdU2TFsJOM9epExbS04g%2BC90hFCno8VVdeb0PUHhkMjseSWlbvuKGr6izK2dT4XQxhrUVGwpVIS6a0pSv8FrPPrOA8sp0cmnRQLYWocC%2FsCtGVCcjQwBmkHBvIZ6ByQlKWa7QrT15HOStrLUNJnma%2FULNcsQso1we5itEkbxoh4PqAEZdooJER7xqLqFFWHK9dGNbcy41BCRFr5si0LHNvXv163GwQ6l5qppZY4M1pnVrlW%2BJBqDXG0FwXyZ7%2FzNBeFV%2FBVkb1fKtrQ8JwulvRlJC5xvf6IAWTymqI%2BZGeM28f7gVvBKiu%2B%2Bym4DC8KDVejWR4cENEvMOOMlPMFOusBz92KBif%2BCVLO6RqjPxVznfV%2BK3QYWJWPPmBm%2BQy9IMk0Ws2eoyQMyybrRTm6hOX9HxZ%2B7UidlzR4B5gYAVVvHTVvHO9Y95Bf8uIjX3SbGpcf2togpwXZ5JAUYnYMHeHCeR%2BnvYT9eraE9J5Xpw%2BGWb9hflDsE6ObAMikoY1T2dKgv5KsvkrJyEXxHRVsPENRj%2BaL9l67BM2fQBVWhTtpyQXV15J3suvbOrRHIOSIPAdDYD0MD0n8rBeXgQbo1Qzk%2Bk2Y3wFFWRh0URg%2F4zm5HFbLVMXEEHUYykaEb5mF6vf8plP80cF5dmeKyw%3D%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20200308T163332Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAQ3PHCVTY34WNS24I%2F20200308%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=abbb92216ab6fb5fb1e08aa20790df7071ef853b092c79caf866e94033bc4ec7&hash=e265a1a00f3e915462939e09b89631409d2d64ffbe55c585f02c65cd42e0efc9&host=68042c943591013ac2b2430a89b270f6af2c76d8dfd086a07176afe7c76c2c61&pii=S0019057807601918&tid=spdf-f82137a0-7927-4aad-aafa-6cee5605a0c7&sid=72924ca833ec1649e95a04e71cdc9418d934gxrqa&type=client


