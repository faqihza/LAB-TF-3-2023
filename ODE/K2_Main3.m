clear
clc

tspan =[0 100]; % waktu 
h0 = 0; % nilai awal
A = 5; R = 5; qin = 1;
[t1,h1] = ode45(@(t,h) tanki(t,h,A,R,qin),...
                tspan,...
                h0);

A = 5; R = 1; qin = 1;
[t2,h2] = ode45(@(t,h) tanki(t,h,A,R,qin),...
                tspan,...
                h0);

plot(t1,h1,t2,h2)
function dhdt = tanki(t,h,A,R,qin)
    dhdt = qin/A - 2*h/(A*R);
end