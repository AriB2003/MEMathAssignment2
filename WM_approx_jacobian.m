function J = WM_approx_jacobian(fun,x)
%your code here
    delta_x = 1e-6;
    J = zeros(length(fun(x)), length(x));
%     disp(length(fun))
    for j = 1:length(x)
        e_j = zeros(length(x),1);
        e_j(j) = 1;
        J(:,j) = (fun(x + delta_x*e_j) - fun(x - delta_x*e_j))/(2*delta_x);
    end
end