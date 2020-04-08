%% Spin up procedure and power requirements
% Joe Tiberi

%% Initialization
close all
global arm l mp dv_req
arm = 1000; %Torque Arm length
l = 5.72e5; %Tether Length
mp = 182e3; %Payload Mass
dv_req = 3.72e3; %m/s runs for one delta V


for I_type = [1 0]
%I_type = input('\n Inertia type:\n   (0 = With Payload)\n   (1 = No Payload)\n');

%% Velocity Calculations
[t,y] = ode45(@thing,[1:1:20000],290);
vels = y; % assigns a variable for plotting
t_plot = t;

%% Power

% Inertia
vs = dv_req*sqrt(970/2/3.5e9);

I_payload = mp*l^2*sqrt(pi)/2/vs*exp(vs.^2)*erf(vs);
I_nopayload = I_payload -mp*l^2;

switch I_type
    case 0
        I = I_payload;
    case 1
        I = I_nopayload;
end
theta = asin(arm/l);

pow = I./l^3.*(tan(theta)*2*y.^3./cos(theta));

%% Variable arm calc
arm_var = [150:10:1000]; %range of torque arm lengths

% Loop initialization
count = 1;
t_spin = [];
pow_loop = [];


for param = arm_var
    arm = param;
    theta_loop = asin(arm/l);
    [t,y] = ode45(@thing,[1:2:50000],290);
    v_max = y(find(y >= (dv_req-10) & y <= (dv_req+10),1));
    t_spin(count) = t(find(y >= (dv_req-10) & y <= (dv_req+10),1)); %spinup time for each arm length
    
    % Power
    vs_loop = v_max*sqrt(970/2/3.5e9);
    I_payload_loop = mp*l^2*sqrt(pi)/2/vs_loop*exp(vs_loop^2)*erf(vs_loop);
    I_nopayload_loop = I_payload_loop - mp*l^2;
    
    switch I_type
        case 0
            I = I_payload_loop;
        case 1
            I = I_nopayload_loop;
    end
    pow_loop(count) = I/l^3*(tan(theta_loop)*2*v_max^3/cos(theta_loop)); %power required for each arm
    
    count = count + 1;
end


%% Variable Storage
switch I_type
    case 0
        payload1 = [t_plot,vels,pow];
        payload2 = [arm_var',t_spin',pow_loop'];
    case 1
        no_payload1 = [t_plot,vels,pow];
        no_payload2 = [arm_var',t_spin',pow_loop'];
end
clear t_plot vels pow arm_var t_spin pow_loop I vs y t 
end

%% Output
figure
subplot(1,2,1)
    plot(payload1(:,1)./3600,payload1(:,2)./1000,no_payload1(:,1)./3600,no_payload1(:,2)./1000)
    grid on
    title('Spin-up Procedure')
    xlabel('Time (h)')
    ylabel('Velocity Achieved (km/s)')
    legend('With Payload','No Payload')
    
subplot(1,2,2)
    plot(payload1(:,2)./1000,payload1(:,3),no_payload1(:,2)./1000,no_payload1(:,3))
    grid on
    title('Spin-up power')
    xlabel('Velocity (km/s)')
    ylabel('Power Required (W)')
    legend('With Payload','No Payload')
    
    
figure
subplot(1,2,1)
    plot(payload2(:,1),payload2(:,2)./3600,no_payload2(:,1),no_payload2(:,2)./3600)
    grid on
    title('Spin-up Times')
    xlabel('Torque Arm Length (m)')
    ylabel('Time (h)')
    legend('With Payload','No Payload')
        
subplot(1,2,2)
    plot(payload2(:,1),payload2(:,3),no_payload2(:,1),no_payload2(:,3))
    grid on
    title('Spin-up power')
    xlabel('Torque Arm Length (m)')
    ylabel('Power Required (W)')
    legend('With Payload','No Payload')
        

    
%% Functions
function vp = thing(v,t)
    global arm l
    theta = asin(arm/l);
    vp = tan(theta)/(cos(theta)*l)*(v^2);
    
end