clear
clc

t = linspace(1,10,100);
y = sin(t);
y2 = tan(t);

figure(1)
hold on
plot(t,y)

plot(t,y2)

V = 5*(1 - exp(-t/1));


plot(t,V)
hold off