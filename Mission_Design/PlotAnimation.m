%% Code to produce plot animations
%   Copy/paste this in the main script
%   The parameter in the pause function represents the time between two
%   frames.

% curve3D = animatedline('LineWidth',1);
% view(43,24)
% for i=1:1:length(SimOut.t)
% %     pause(0.01)
% %     plot3(x_pos(1:i),y_pos(1:i),z_pos(1:i))
%     addpoints(curve3D,x_pos(1:i),y_pos(1:i),z_pos(1:i))
%     drawnow
%     
%     annotation('textbox',[0.125 0 0 0.065],'String',"Plot made by Valentin RICHARD",'FitBoxToText','on');
% end