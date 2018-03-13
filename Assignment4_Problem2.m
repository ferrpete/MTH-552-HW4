% Assignment4_Problem2.m
% Peter Ferrero, Oregon State University, MTH 552, 2/6/2018
% Compares the phase plane solution of a harmonic oscillator using various
% finite difference schemes.

T = 2*pi;
h = 1;
t = [0:h:T];

A = [0,1;-1,0];

uFE = zeros(2,length(t));
uFE(:,1) = [1, 0];
uBE = zeros(2,length(t));
uBE(:,1) = [1, 0];
uTrapz = zeros(2,length(t));
uTrapz(:,1) = [1, 0];
uExact = [cos(t); -sin(t)];

errFE = zeros(1,length(t));
errBE = zeros(1,length(t));
errTrapz = zeros(1,length(t));

distFE = zeros(1,length(t));
distFE(1) = 1;
distBE = zeros(1,length(t));
distBE(1) = 1;
distTrapz = zeros(1,length(t));
distTrapz(1) = 1;

for i=2:length(t)
    
    uFE(:,i) = uFE(:,i-1) + h*A*uFE(:,i-1);
    uBE(:,i) = (eye(2,2) - h*A)\uBE(:,i-1);
    uTrapz(:,i) = (eye(2,2) - (h/2)*A)\(uTrapz(:,i-1) +...
        (h/2)*A*uTrapz(:,i-1));
    
    errFE(i) = norm(uExact(:,i)-uFE(:,i),'inf');
    errBE(i) = norm(uExact(:,i)-uBE(:,i),'inf');
    errTrapz(i) = norm(uExact(:,i)-uTrapz(:,i),'inf');
    
    distFE(i) = uFE(1,i)^2 + uFE(2,i)^2;
    distBE(i) = uBE(1,i)^2 + uBE(2,i)^2;
    distTrapz(i) = uTrapz(1,i)^2 + uTrapz(2,i)^2;
end

[tODE45,uODE45] = ode45(@Assignment4_Problem2_RHS, t, [1,0]);
errODE45 = max(abs(uExact-uODE45'));
distODE45 = uODE45(:,1).^2 + uODE45(:,2).^2;

figure(1)
scatter(uFE(1,:),uFE(2,:),'ro')
hold on
scatter(uBE(1,:),uBE(2,:),'bo')
scatter(uTrapz(1,:),uTrapz(2,:),'kx')
scatter(uODE45(:,1),uODE45(:,2),'go')
plot(uExact(1,:),uExact(2,:),'k--')
legend('FE', 'BE', 'Trapezoidal','ODE45', 'Exact')
legend('Location', 'southeast')
xlabel('x')
ylabel('y')
axis([-2.5 2.5 -2.5 2.5])
hold off

figure(2)
plot(t,errFE,'r.-',t,errBE,'b--',t,errTrapz,'kx-',t,errODE45','g.-')
legend('FE','BE','Trapezoidal','ODE45')
legend('Location','southeast')
xlabel('Time, t')
ylabel('Error, e(t)')

figure(3)
plot(t, distFE,'r.-', t,distBE,'b--',t,distTrapz,'kx-',t,distODE45','g.-')
legend('FE','BE','Trapezoidal','ODE45')
legend('Location','southeast')
xlabel('Time, t')
ylabel('Distance, d(x,y)')