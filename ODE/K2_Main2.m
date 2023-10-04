clear
clc

tspan =[0 100]; % waktu 
h0 = 0; % nilai awal

[t,h] = ode45(@tanki,tspan,h0);
plot(t,h)
function dhdt = tanki(t,h)
    A = 5; R = 5; qin = 1;
    dhdt = qin/A - 2*h/(A*R);
end