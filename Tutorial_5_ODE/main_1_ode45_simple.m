clear
clc

tspan = [0,10];
y0 = 1;

[t,y] = ode45(@odefunc, tspan, y0);

plot(t,y)

function dydt = odefunc(t,y)
    dydt = -y;
end

