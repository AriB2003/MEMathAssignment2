%initialize leg_params structure
leg_params = struct();
%number of vertices in linkage
leg_params.num_vertices = 7;
%number of links in linkage
leg_params.num_linkages = 10;
%matrix relating links to vertices
leg_params.link_to_vertex_list = ...
[   1, 3;... %link 1 adjacency
    3, 4;... %link 2 adjacency
    2, 3;... %link 3 adjacency
    2, 4;... %link 4 adjacency
    4, 5;... %link 5 adjacency
    2, 6;... %link 6 adjacency
    1, 6;... %link 7 adjacency
    5, 6;... %link 8 adjacency
    5, 7;... %link 9 adjacency
    6, 7 ... %link 10 adjacency
];
%list of lengths for each link
%in the leg mechanism
leg_params.link_lengths = ...
[   50.0,... %link 1 length
    55.8,... %link 2 length
    41.5,... %link 3 length
    40.1,... %link 4 length
    39.4,... %link 5 length
    39.3,... %link 6 length
    61.9,... %link 7 length
    36.7,... %link 8 length
    65.7,... %link 9 length
    49.0 ... %link 10 length
];
%length of crank shaft
leg_params.crank_length = 15.0;
%fixed position coords of vertex 0
leg_params.vertex_pos0 = [0;0];
%fixed position coords of vertex 2
leg_params.vertex_pos2 = [-38.0;-7.8];
%column vector of initial guesses
%for each vertex location.
%in form: [x1;y1;x2;y2;...;xn;yn]
vertex_guess_coords = [...
    [ 0; 50];... %vertex 1 guess
    [ -50; 0];... %vertex 2 guess
    [ -50; 50];... %vertex 3 guess
    [-100; 0];... %vertex 4 guess
    [-100; -50];... %vertex 5 guess
    [ -50; -50];... %vertex 6 guess
    [ -50; -100]... %vertex 7 guess
];
leg_drawing = initialize_leg_drawing(leg_params);
theta = 0:0.1:2*pi;
fd_x_tip = zeros(length(theta),1);
fd_y_tip = zeros(length(theta),1);
j_x_tip = zeros(length(theta),1);
j_y_tip = zeros(length(theta),1);
for ind=1:length(theta)
    vertex_guess_coords = compute_coords(vertex_guess_coords,leg_params,theta(ind));
    fd_velocities = finite_diff_velocities(vertex_guess_coords, leg_params, theta(ind));
    j_velocities = compute_velocities(vertex_guess_coords, leg_params, theta(ind));
    fd_velocity_matrix = column_to_matrix(fd_velocities);
    fd_x_tip(ind) = fd_velocity_matrix(7,1);
    fd_y_tip(ind) = fd_velocity_matrix(7,2);
    j_velocity_matrix = column_to_matrix(j_velocities);
    j_x_tip(ind) = j_velocity_matrix(7,1);
    j_y_tip(ind) = j_velocity_matrix(7,2);
    update_leg_drawing(vertex_guess_coords, leg_drawing, leg_params, j_velocities);
    pause(0.05);
end
figure;
subplot(2,1,1);
plot(theta, fd_x_tip, "r-", "DisplayName","Finite Diff");
hold on
plot(theta, j_x_tip,"b--", "DisplayName","Lin Alg");
title("X velocity of tip");
xticks([0, pi/2, pi, 3*pi/2, 2*pi])
xlabel("\theta");
ylabel("units/s");
legend();
hold off
subplot(2,1,2);
plot(theta, fd_y_tip,"r-", "DisplayName","Finite Diff");
hold on
plot(theta, j_y_tip,"b--", "DisplayName","Lin Alg");
title("Y velocity of tip");
xticks([0, pi/2, pi, 3*pi/2, 2*pi])
xlabel("\theta");
ylabel("units/s");
legend();
hold off