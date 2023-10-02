clear
clc

%% Annotation

x = 0:pi/100:pi;
y = x.^2.*sin(x);

figure(1);
clf %clear figure
plot(x,y);

% Menambah line
line([2 2],[0 2.^2.*sin(2)],...
    'LineStyle','--',...
    'Color','r');

% menambah persamaan
text(1,1.5,'x^2sin(x)');
text(0.5,3,...
    '$$\int_{0}^{2}x^2\sin(x)dx$$',...
    'Interpreter','latex',...
    'FontSize',24);

% menambah anotasi
annotation('Arrow',...
    'X',[0.4 0.5],...
    'Y',[0.68 0.5]);

% Patch
x1 = linspace(0,2,100);
y1 = x1.^2.*sin(x1);
x1 = [x1 2 0];
y1 = [y1 0 0];
patch(x1,y1,'c');

% 
% x = [x 2 0];
% y = [y 0 0];
% patch(x,y,'c');