% Plot of the docking angles
thetaTotal = linspace(0,2*pi,1000);    % Angle swept by the Tether for a revolution

%   Mars plot
thetaMars = linspace(pi/2,pi/2 + dockingAngleMars(length(dockingAngleMars)),1000);

for i=1:1:length(thetaTotal)
    if thetaTotal(i) == thetaMars(i)
        modifArm(i) = ArmLengthMars;
    else
        modifArm(i) = 0;
    end 
        
end

figure

polarplot(thetaTotal,1)
%'HandleVisibility','off'
hold on
polarplot(thetaMars,1,'X')
hold off
legend("Mars Tether docking Angle for T = 1.5s")
