clear
clc

% data
t = 0:0.1:10;
S = tf('s');
K = 2;
psi = 0.133;
wn = 5;
sys = K*(wn^2)/(S^2 + 2*psi*wn*S + wn^2);
[y,t] = step(sys,t);

% noise
r = 0.1.*randn(length(t),1);

% data + noise
y = y+r;

figure(1)
plot(t,y)

data = [t,y]';

writematrix(data,'data_orde2.xlsx','WriteMode','replacefile');


