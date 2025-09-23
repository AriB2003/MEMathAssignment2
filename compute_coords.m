%Computes the vertex coordinates that describe a legal linkage configuration
%INPUTS:
%vertex_coords_guess: a column vector containing the (x,y) coordinates of every vertex
% these coords are just a GUESS! It's used to seed Newton's method
%leg_params: a struct containing the parameters that describe the linkage
%theta: the desired angle of the crank
%OUTPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
% these coords satisfy all the kinematic constraints!
function vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta)
    params = struct();
    params.ftol = 1e-10;
    vertex_wrapper = @(coords) linkage_error_func(coords, leg_params, theta);
    [vertex_coords_root, flag] = multi_newton_solver(vertex_wrapper, vertex_coords_guess, params);
end