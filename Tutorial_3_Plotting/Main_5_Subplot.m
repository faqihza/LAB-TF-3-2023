clear
clc

%% Subplot

% satu kolom
x = 0:pi/100:4*pi;
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);
y4 = sin(x+pi);

figure(1);
clf
% plot pertama di subplot 4,1
subplot(4,1,1);
plot(x,y1);
grid on
% axis untuk batasan [xmin xmax ymin ymax]
axis([0 4*pi -1.5 1.5]);
% axis([0 4*pi -1.5 1.5]);
title('$$\sin(x)$$','Interpreter','latex');

subplot(4,1,2);
plot(x,y2);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x+\frac{\pi}{4})$$','Interpreter','latex');

subplot(4,1,3);
plot(x,y3);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x+\frac{\pi}{2})$$','Interpreter','latex');
subplot(4,1,4);
plot(x,y4);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x+\frac{\pi}{2})$$','Interpreter','latex');

% dua kolom

figure(2);
clf
subplot(2,2,1);
plot(x,y1);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x)$$','Interpreter','latex');
subplot(2,2,2);
plot(x,y2);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x+\frac{\pi}{4})$$','Interpreter','latex');
subplot(2,2,3);
plot(x,y3);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x+\frac{\pi}{2})$$','Interpreter','latex');
subplot(2,2,4);
plot(x,y4);
grid on
axis([0 4*pi -1.5 1.5]);
title('$$\sin(x+\frac{\pi}{2})$$','Interpreter','latex');