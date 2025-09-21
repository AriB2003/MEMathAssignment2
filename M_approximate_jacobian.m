%Implementation of finite difference approximation
%for Jacobian of multidimensional function
%INPUTS:
%fun: the mathetmatical function we want to differentiate
%x: the input value of fun that we want to compute the derivative at
%OUTPUTS:
%J: approximation of Jacobian of fun at x
function J = M_approximate_jacobian(fun,x)
%set delta value
delta_x = 1e-6;
%make empty Jacobian
J = zeros(length(fun(x)),length(x));

%Fun over every column
for col = 1:length(x)
    e_j = zeros(length(x),1);
    e_j(col) = delta_x;

    pos = fun(x + e_j);
    neg = fun(x - e_j);
    J(:,col) = (pos - neg)/(2*delta_x);
end