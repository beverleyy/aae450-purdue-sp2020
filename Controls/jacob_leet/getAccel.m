function [accel] = getAccel(mass,albedo,radii,constants,dim,temp,emis,vec)
%% INITIALIZE PARAMETERS
n = length(mass);
index = 1:n;

% X = vec(1:n);
% Y = vec((n+1):(2*n));
% Z = vec((2*n+1):(3*n));
% 
% U = vec((3*n+1):(4*n));
% V = vec((4*n+1):(5*n));
% W = vec((5*n+1):(6*n));

X = zeros(n,1);
Y = zeros(n,1);
Z = zeros(n,1);
U = zeros(n,1);
V = zeros(n,1);
W = zeros(n,1);

for i = 1:(n-1)
    X(i) = vec(3*i-2);
    Y(i) = vec(3*i-1);
    Z(i) = vec(3*i-0);
    
    U(i) = vec(3*i+13);
    V(i) = vec(3*i+14);
    W(i) = vec(3*i+15);
end

X(n) = vec(31);
Y(n) = vec(32);
Z(n) = vec(33);
U(n) = vec(34);
V(n) = vec(35);
W(n) = vec(36);

Fxs = zeros(n,1); 
Fys = zeros(n,1);
Fzs = zeros(n,1);

Xaccel = zeros(n,1); 
Yaccel = zeros(n,1);
Zaccel = zeros(n,1);

accel = zeros(3*n,1);
%% FORCE CALCULATION
for i = index
    for j = index
        % Doesn't compute force on itself
        if i == j
            continue
        end
        
        % Gets Direction between Bodies
        [r,dirx,diry,dirz] = getDirection(X,Y,Z,i,j);
        
        % Gets Force from gravitional 
        [Fx,Fy,Fz] = getGravForce(dirx,diry,dirz,r,constants,mass,i,j);
        Fxs(i) = Fxs(i) + Fx;Fys(i) = Fys(i) + Fy;Fzs(i) = Fzs(i) + Fz;
        
        % Gets Force from solar radiation
        if i == 6
            [Fx,Fy,Fz] = getRadForce(dirx,diry,dirz,X,Y,Z,r,radii,dim,albedo,constants,i,j);
            Fxs(i) = Fxs(i) + Fx;Fys(i) = Fys(i) + Fy;Fzs(i) = Fzs(i) + Fz;
            
            % Gets Force from Planet Thermal Radiation
            if j ~= 1
                [Fx,Fy,Fz] = getThermalForce(dirx,diry,dirz,r,temp,emis,radii,dim,constants,j);
                Fxs(i) = Fxs(i) + Fx;Fys(i) = Fys(i) + Fy;Fzs(i) = Fzs(i) + Fz;
            
            % Gets Force from Solar Wind
            else
                [Fx, Fy, Fz] = getSolarWindForce(U,V,W,dim,r,i);
                Fxs(i) = Fxs(i) + Fx;Fys(i) = Fys(i) + Fy;Fzs(i) = Fzs(i) + Fz;
                
            end
            
        end
    end
    % Computes forces emitted by spacecraft
    if i == 6
        
    end
end

%% ACCELERATION
for i = index
    Xaccel(i) = Fxs(i)/mass(i);
    Yaccel(i) = Fys(i)/mass(i);
    Zaccel(i) = Fzs(i)/mass(i);
end

%% ARRAY COMBINATION
for i = index
    accel(3*i-2) = Xaccel(i);
    accel(3*i-1) = Yaccel(i);
    accel(3*i-0) = Zaccel(i);
end
