clear
clc

tspan = [0,100];
x0 = [0;0];
kp = 0.2; kg = 0.6; m = 5;
F = 10;

[t,x] = ode45(@(t,x) pegas(t,x,kp,kg,m,F),...
               tspan,x0);
plot(t,x)
legend('posisi','velocity')
function dxdt = pegas(t,x,kp,kg,m,F)
    dxdt = [0 1;-kp/m -kg/m]*x + [0;1/m]*F;
end