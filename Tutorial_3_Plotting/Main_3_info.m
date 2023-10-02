clear
clc

%% info

% 1. title and label

x = linspace(0,2*pi,20);
y = sin(x);

figure(1)
plot(x,y,...
    'LineStyle',':',...
    'Color',[1 0 0],...
    'LineWidth',1.5,...
    'Marker','o',...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5 0.5 0]);
ax = gca;
ax.XAxisLocation = 'top';
ax.YAxisLocation = 'right';
title('2-D Line Plot');
xlabel('x (rad)',...
    'FontSize',14,...
    'FontWeight','bold',...
    'Color','r');
ylabel('sin(x)');

% 2. legend

x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = cos(x);
y3 = sin(x+pi/4);

figure(2);
plot(x,y1,'b-.',x,y2,'r--',x,y3,'m:');
legend('sin(x)','cos(x)','sin(x+pi/4)',...
    'Location','southoutside',...
    'Orientation','Horizontal');
% 'Location' -> lokasi legenda berdasarkan arah mata angin
% 'Position' -> Koordinat

% 3. legend with latex

x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);

figure(3);
plot(x,y1,'b-.',x,y2,'r--',x,y3,'m:');
xlabel('x (rad)');
legend_handle = legend(...
    '$$\sin(x)$$',...
    '$$\sin(x+\frac{\pi}{2})$$',...
    '$$\sin(x+\frac{\pi}{4})$$');

set(legend_handle,'Interpreter','latex');
