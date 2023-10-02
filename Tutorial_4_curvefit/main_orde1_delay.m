clear
clc

data = readmatrix("data_orde1_delay.xlsx");
t = data(1,:);
y_real = data(2,:);

tebakan_awal = [6 5 4]; %[k tau td]
options = optimoptions('lsqcurvefit',...
    'Display','iter');
hasil_akhir = lsqcurvefit(@orde1_delay,...
    tebakan_awal,t,y_real,[],[],options);

figure(1)
scatter(t,y_real)
hold on
plot(t,orde1_delay(hasil_akhir,t))
hold off

% y = m*x + b
function y = orde1_delay(params,x)
    k = params(1);
    tau = params(2);
    td = params(3);
    y = k.*(1 - exp(-(x-td)./tau));
    y = (x >= td).*y;
end