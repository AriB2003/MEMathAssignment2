%Computes the theta derivatives of each vertex coordinate for the Jansen linkage
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% these are assumed to be legal values that are roots of the error funcs!
%leg_params: a struct containing the parameters that describe the linkage
%theta: the current angle of the crank
%OUTPUTS:
%dVdtheta: a column vector containing the theta derivates of each vertex coord
function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)
    % vertex_wrapper = @(coords) linkage_error_func(coords, leg_params, theta);
    vertex_wrapper = @(coords) link_length_error_func(coords, leg_params);
    J = approximate_jacobian(vertex_wrapper, vertex_coords);
    % [w,h] = size(J);
    [h,w] = size(J);
    M = zeros(h+4,w);
    M(1:4,1:4) = eye(4);
    M(5:end,:) = J;
    A = zeros(h+4,1);
    A(1) = -leg_params.crank_length*sin(theta);
    A(2) = leg_params.crank_length*cos(theta);
    dVdtheta = M\A;
end