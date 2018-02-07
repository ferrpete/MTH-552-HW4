% Assignment4_Problem1.m
% Peter Ferrero, Oregon State University, MTH 552, 2/6/2018
% Examines the global error for various finite difference methods with
% various step sizes.

N = [5, 10, 20];
U = zeros(length(N));

for i=1:length(N)
    
    n = N(i);
    k = 1/n;
    t = [0:k:1]';
    
    u_lmm = zeros(length(t),1);
    u_lmm(2) = k;
    u_fwd = zeros(length(t),1);
    u_fwd(2) = k;
    u_bdf = zeros(length(t),1);
    u_bdf(2) = k;
    
    for j=3:length(t)
        
         u_lmm(j) = 3*u_lmm(j-1) - 2*u_lmm(j-2);
         u_fwd(j) = 4*u_fwd(j-1) - 3*u_fwd(j-2);
         u_bdf(j) = (4/3)*u_bdf(j-1) - (1/3)*u_bdf(j-2);
        
    end
    
    U(i,:) = [u_lmm(end), u_fwd(end), u_bdf(end)];
    
end