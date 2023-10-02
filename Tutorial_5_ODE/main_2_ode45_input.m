clear
clc

tspan = [0,100];
y0 = 0;
qin1 = 1;
qin2 = 2;

[t1,h1] = ode45(@(t,h) tanki(t,h,qin1), tspan, y0);
[t2,h2] = ode45(@(t,h) tanki(t,h,qin2), tspan, y0);

plot(t1,h1)
hold on
plot(t2,h2)
hold off

function dhdt = tanki(t,h,qin)
    A = 5;
    R = 4;

    dhdt = (qin - 2*h/R)/A;
end

