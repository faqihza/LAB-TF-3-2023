clear
clc

data = readmatrix("data_linear.xlsx");
t = data(1,:);
y_real = data(2,:);


tebakan_awal = [6 5]; %[m b]
options = optimoptions('lsqcurvefit','Display','iter');
hasil_akhir = lsqcurvefit(@linear,tebakan_awal,t,y_real,[],[],options);

figure(1)
scatter(t,y_real)
hold on
plot(t,linear(hasil_akhir,t))
hold off

% y = m*x + b
function y = linear(params,x)
    m = params(1);
    b = params(2);
    y = m*x + b;
end