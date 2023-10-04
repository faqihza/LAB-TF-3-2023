clear
clc

tspan = [0,100];
h0 = 0;

[t,h] = ode45(@tanki,tspan,h0);
plot(t,h);

function dhdt = tanki(t,h)
    A = 4;
    R = 1;
    qin = 5;
    dhdt = (qin - 2*h/R)/A;
end