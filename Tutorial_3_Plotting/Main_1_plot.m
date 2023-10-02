% clear
% clc
% 
% %% membuat plotting
% 
% 1. Simple Line Plot

x = 0:pi/100:2*pi;
y = sin(x);

figure(1); % membuat figure dengan nomor 1
plot(x,y);
% 
% % 2. Multiple Line

x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = cos(x);
y3 = sin(x + pi/4);

figure(2);
plot(x,y1,x,y2,x,y3);

figure(3);
plot(x,y1);
hold on
plot(x,y2);
plot(x,y3);
hold off
% 
% 3. plot dari matrix
x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);

figure(4);
m = [y1;y2;y3]';
plot(x,m);






