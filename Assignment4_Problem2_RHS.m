% Assignment4_Problem2_RHS.m
% Peter Ferrero, Oregon State University, MTH 552, 2/6/2018
% Computes RHS of Problem 2 of Assignment 4 for ODE45 solver.

function dudt = Assignment4_Problem2_RHS(t,u)

dudt(1,1) = u(2);
dudt(2,1) = -u(1);

end