clear
clc

tspan = [0,20]; h10 = 0; h20 = 5;
A1 = 4; R1 = 1; qin1 = 5;
A2 = 4; R2 = 1; qin2 = 5;

[t1,h1] = ode45(@(t,h) tanki(t,h,A1,R1,qin1),tspan,h10);
[t2,h2] = ode45(@(t,h) tanki(t,h,A2,R2,qin2),tspan,h20);
plot(t1,h1);
hold on
plot(t2,h2);
hold off
legend('h1','h2')
function dhdt = tanki(t,h,A,R,qin)
    dhdt = (qin - 2*h/R)/A;
end