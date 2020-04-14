function [traj] = getTraj(t,t_step,desired_trajectory)
t_top = ceil(t/t_step)+1;
t_bottom = floor(t/t_step)+1;

if t_top == t_bottom
    traj = desired_trajectory(t_bottom,:);
else
    traj = (desired_trajectory(t_top,:)-desired_trajectory(t_top,:))/(t_top-t_bottom) * (t - t_bottom) + desired_trajectory(t_bottom,:);
end