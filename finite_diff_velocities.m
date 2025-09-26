%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dUdtheta = finite_diff_velocities(vertex_coords, leg_params, theta)
    delta_theta = 10^-7;
    left = compute_coords(vertex_coords,leg_params,theta-delta_theta);
    right = compute_coords(vertex_coords,leg_params,theta+delta_theta);
    dUdtheta = (right-left)/(2*delta_theta);
end