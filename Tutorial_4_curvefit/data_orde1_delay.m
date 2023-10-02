clear
clc

% data
t = 0:0.1:10;
S = tf('s');
K = 1.4;
tau = 1.5;
td = 1;
sys = K*exp(-td*S)/(tau*S+1);
[y,t] = step(sys,t);

% noise
r = 0.1.*randn(length(t),1);
% data + noise
y = y+r;
y = (y >= 0).*y;
figure(1)
scatter(t,y)

data = [t,y]';

writematrix(data,'data_orde1_delay.xlsx','WriteMode','replacefile');


