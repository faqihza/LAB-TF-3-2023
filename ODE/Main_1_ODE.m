clear
clc

tspan = [0,10];
y0 = 1;

[t,y] = ode45(@sistem,tspan,y0);

plot(t,y)

function dydt = sistem(t,y)
    dydt = 10-2*y;
end