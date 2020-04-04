figure(4)
for i = 1:5
    plot3(SPM_pos.Data(:,3*i-2)/149597870.700e3,SPM_pos.Data(:,3*i-1)/149597870.700e3,SPM_pos.Data(:,3*i-0)/149597870.700e3,'LineWidth',2)
    hold on
end
%%
plot3(Cycler_pos.Data(:,1)/149597870.700e3,Cycler_pos.Data(:,2)/149597870.700e3,Cycler_pos.Data(:,3)/149597870.700e3,'LineWidth',2)
hold on
%%
plot3(desired_trajectory(:,1)/149597870.700e3,desired_trajectory(:,2)/149597870.700e3,desired_trajectory(:,3)/149597870.700e3,'LineWidth',2)
%%
grid
xlabel('X (AU)','FontSize',14)
ylabel('Y (AU)','FontSize',14)
zlabel('Z (AU)','FontSize',14)
%%
legend('Sun','Earth','Moon','Mars','Phobos','Cycler Simulated','Cycler Desired')

%%
% meanx = mean(Cycler_pos.Data(:,1)-desired_trajectory(:,1));
% meany = mean(Cycler_pos.Data(:,2)-desired_trajectory(:,2));
% meanz = mean(Cycler_pos.Data(:,3)-desired_trajectory(:,3));
% fprintf('-----------------------------------------------------\n')
% dist = norm([meanx,meany,meanz])/1e3
% 
% 
% % 
% tdV = 0;
% for i =1:length(dV.Data)
%     tdV = tdV + norm(dV.Data(i,:));
% end
% tdV
% % 
% 
% %%
% figure(5)
% plot3(Cycler_pos.Data(:,1)-desired_trajectory(:,1),Cycler_pos.Data(:,2)-desired_trajectory(:,2),Cycler_pos.Data(:,3)-desired_trajectory(:,3))
