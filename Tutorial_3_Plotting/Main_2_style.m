clear
clc

%% Styles

% 1. Line style

x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);

figure(1);
plot(x,y1,'-.',x,y2,'--',x,y3,':');

% 2. Color

x = 0:pi/100:2*pi;
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);

figure(2);
plot(x,y1,'b-.',x,y2,'r--',x,y3,'k:');

% 3. Marker

x = 0:pi/10:2*pi;
y1 = sin(x);
y2 = sin(x+pi/4);
y3 = sin(x+pi/2);

figure(3);
plot(x,y1,'b-.o',x,y2,'r--d',x,y3,'m:pentagram');

% 4. Manual styling

x = linspace(0,2*pi,20);
y = sin(x);
z = cos(x);
figure(4)
plot(x,y,...
    'LineStyle','--',...
    'LineWidth',2,...
    'Color',[0.1 0.5 0.1],...
    'Marker','d',...
    'MarkerSize',20,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor',[1 1 0]);
hold on
plot(x,z,...
    'LineStyle',':',...
    'LineWidth',2,...
    'Color',[0 0 1],...
    'Marker','pentagram',...
    'MarkerSize',20,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[1 1 0]);
hold off


