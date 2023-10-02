clear
clc

% data
t = 0:0.1:10;
y = t + 0.4;

% noise
r = 0.3.*randn(1,length(t));

% data + noise
y = y+r;

figure(1)
scatter(t,y)

data = [t;y];

writematrix(data,'data_linear.xlsx','WriteMode','replacefile');


