%Updates the plot objects that visualize the leg linkage
%for the current leg configuration
%INPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
%leg_drawing: a struct containing all the plotting objects for the linkage
% leg_drawing.linkages is a cell array, where each element corresponds
% to a plot of a single link (excluding the crank)
% leg_drawing.crank is a plot of the crank link
% leg_drawing.vertices is a cell array, where each element corresponds
% to a plot of one of the vertices in the linkage
function update_leg_drawing(complete_vertex_coords, leg_drawing, leg_params, velocities)
    %iterate through each link, and update corresponding link plot
    vertex_matrix = column_to_matrix(complete_vertex_coords);
    for linkage_index = 1:leg_params.num_linkages
        %linkage_index is the label of the current link
        %your code here
        %line_x and line_y should both be two element arrays containing
        %the x and y coordinates of the line segment describing the current link
        a = leg_params.link_to_vertex_list(linkage_index,1); % node number of link start
        b = leg_params.link_to_vertex_list(linkage_index,2); % node number of link end
        line_x = [vertex_matrix(a,1),vertex_matrix(b,1)];
        line_y = [vertex_matrix(a,2),vertex_matrix(b,2)];
        set(leg_drawing.linkages{linkage_index},'xdata',line_x,'ydata',line_y);
    end
    %iterate through each vertex, and update corresponding vertex plot
    for vertex_index = 1:leg_params.num_vertices
        %vertex_index is the label of the current vertex
        %your code here
        %dot_x and dot_y should both be scalars
        %specifically the x and y coordinates of the corresponding vertex
        dot_x = vertex_matrix(vertex_index,1);
        dot_y = vertex_matrix(vertex_index,2);
        set(leg_drawing.vertices{vertex_index},'xdata',dot_x,'ydata',dot_y);
    end
    %your code here
    %crank_x and crank_y should both be two element arrays
    %containing the x and y coordinates of the line segment describing the crank
    crank_x = [0,vertex_matrix(1,1)];
    crank_y = [0,vertex_matrix(1,2)];
    set(leg_drawing.crank,'xdata',crank_x,'ydata',crank_y);
    foot_x = vertex_matrix(7,1);
    foot_y = vertex_matrix(7,2);
    line([foot_x],[foot_y],'marker',...
        '.','markerfacecolor','k','markeredgecolor','k','markersize',3);
    if length(velocities)>1
        velocity_matrix = column_to_matrix(velocities);
        velocity_x = [foot_x,foot_x+velocity_matrix(7,1)];
        velocity_y = [foot_y,foot_y+velocity_matrix(7,2)];
        set(leg_drawing.velocity,'xdata',velocity_x,'ydata',velocity_y);
    end
    drawnow;
    axis([-120,20,-100,50]);
end