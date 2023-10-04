clear
clc

tspan =[0 10]; % waktu 
y0 = 5; % nilai awal

[t,y] = ode45(@sistem,tspan,y0);
plot(t,y)

function dydt = sistem(t,y)
    dydt = -2*y + 15;
end