%Error function that encodes the fixed vertex constraints
%INPUTS:
%vertex_coords: a column vector containing the (x,y) coordinates of every vertex
% same input as link_length_error_func
%leg_params: a struct containing the parameters that describe the linkage
% importantly, leg_params.crank_length is the length of the crank
% and leg_params.vertex_pos0 and leg_params.vertex_pos2 are the
% fixed positions of the crank rotation center and vertex 2.
%theta: the current angle of the crank
%OUTPUTS:
%coord_errors: a column vector of height four corresponding to the differences
% between the current values of (x1,y1),(x2,y2) and
% the fixed values that they should be
function coord_errors = fixed_coord_error_func(vertex_coords, leg_params, theta)
    vertex_matrix = column_to_matrix(vertex_coords);
    coord_errors = [
        vertex_matrix(1,1)-cos(theta)*leg_params.crank_length;
        vertex_matrix(1,2)-sin(theta)*leg_params.crank_length;
        vertex_matrix(2,1)-leg_params.vertex_pos2(1);
        vertex_matrix(2,2)-leg_params.vertex_pos2(2)
    ];
end