% perulangan
clear
clc
% input

% for dan while

% vektor

x = [1 2 10 4 5];
for i=x
    disp(i);
end

for i=1:length(x)
    x(i) = x(i) + 5;
end

% latihan a + b
a = [4 3 2 1];
b = [0 5 8 -5];
c = zeros(1,length(a));

for i=1:length(a)
    c(i) = a(i) + b(i);
end