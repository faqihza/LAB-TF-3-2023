clear
clc

data = readmatrix("data_orde1.xlsx");
t = data(1,:);
y_real = data(2,:);

tebakan_awal = [6 5]; %[k tau]
options = optimoptions('lsqcurvefit',...
    'Display','iter');
hasil_akhir = lsqcurvefit(@orde1,...
    tebakan_awal,t,y_real,[],[],options);

figure(1)
scatter(t,y_real)
hold on
plot(t,orde1(hasil_akhir,t))
hold off

% y = m*x + b
function y = orde1(params,x)
    k = params(1);
    tau = params(2);
    y = k.*(1 - exp(-x./tau));
end