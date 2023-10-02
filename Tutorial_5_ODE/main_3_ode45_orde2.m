clear
clc

tspan = [0,100]; % waktu simulasi
x0 = [0 0]; % kondisi awal
f = 5; % input 

b = 1; % konstanta gesek
k = 1; % konstanta pegas
m = 5; % massa 

[t,x] = ode45(@(t,x) springmass(t,x,f,b,k,m), tspan, x0);

y = [1 0]*x';
plot(t,y)

function dxdt = springmass(t,x,f,b,k,m)
    dxdt(1,:) = [  0    1 ]*x + [ 0 ]*f;
    dxdt(2,:) = [-k/m -b/m]*x + [1/m]*f;
end

