clear
clc

% data
t = 0:0.1:10;
S = tf('s');
K = 2;
tau = 2;
sys = K/(tau*S+1);
[y,t] = step(sys,t);

% noise
r = 0.1.*randn(length(t),1);

% data + noise
y = y+r;

figure(1)
scatter(t,y)

data = [t,y]';

writematrix(data,'data_orde1.xlsx','WriteMode','replacefile');


