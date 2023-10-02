clear
clc

data = readmatrix("data_orde2.xlsx");
t = data(1,:);
y_real = data(2,:);

tebakan_awal = [1 3 3]; %[k psi wn]
options = optimoptions('lsqcurvefit',...
    'Display','iter');
hasil_akhir = lsqcurvefit(@orde2,...
    tebakan_awal,t,y_real,[],[],options);

figure(1)
scatter(t,y_real)
hold on
plot(t,orde2(hasil_akhir,t))
hold off

% y = m*x + b
function y = orde2(params,x)
    k = params(1);
    psi = params(2);
    wn = params(3);
    y = k*(1 - exp(-psi*wn.*x).*(cos(wn*sqrt(1-psi^2).*x)+(psi)/(sqrt(1-psi^2)).*sin(wn*sqrt(1-psi^2).*x)));
end