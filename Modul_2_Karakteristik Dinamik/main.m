clear
clc

%% program untuk VCC
% import pustaka elvis dan variable power supplies
import elvis.VarPowSupply;

% membuat objek baru dari variable power supplies
vps = VarPowSupply;

% ubah tegangan positif menjadi Vpp 12 volt
vps.Vpos = 12;
vps.Vneg = -12;

%% program untuk membuat sinyal kotak
% membuat analog output pada ai0
s = daq.createSession('ni');
s.Rate = 1000;
s.IsContinuous = true;

addAnalogOutputChannel(s,'Dev1','ao0','Voltage');

% membuat sinyal kotak
vmax = 5;
vmin = -5;
half_period = 15;
repeat = 4;
tsampling = 1/s.Rate;

[y_input,t_input] = gensin(vmax,vmin,half_period,repeat,tsampling);

subplot(2,1,1);
plot(t_input,y_input);
grid on
ylim([-10 10]);


%% program untuk menangkap sinyal
% Osiloskop
osilos = daq.createSession('ni');
osilos.Rate = 1000;
osilos.DurationInSeconds = 2*half_period*repeat;
addAnalogInputChannel(osilos,'Dev1','ai0','Voltage');

% setting durasi
t_output = 0:tsampling:2*half_period*repeat;

%% eksekusi gensin dan osiloskop
% keluarkan data
queueOutputData(s,y_input);
startBackground(s);

% lakukan pengukuran
y_output= startForeground(osilos);

% menampilkan plot
subplot(2,1,2);
plot(t_output,y_output)

%% selesai
delete(vps)