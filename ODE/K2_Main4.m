clear
clc

tspan =[0 20]; % waktu 
x0 = [0;0]; % nilai awal

k = 5; b = 1; m = 1; F = 5;
[t,x] = ode45(@(t,x) pegas(t,x,k,b,m,F),...
                tspan,...
                x0);
plot(t,x)

function dxdt = pegas(t,x,k,b,m,F)
    dxdt = [0 1;-k/m -b/m]*x + [0;1/m]*F;
    
    % x1 = x(1);
    % x2 = x(2);
    % dx1dt = x2;
    % dx2dt = -(k*x1/m) - (b*x2/m) + (F/m);
    % dxdt = [dx1dt;dx2dt];
end