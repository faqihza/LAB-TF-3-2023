clear
clc

% membuat analog output pada ai0
s = daq.createSession('ni');
s.Rate = 250000;
s.IsContinuous = true;

addAnalogOutputChannel(s,'Dev1','ao0','Voltage');

% buat data
amplitudePeakToPeak_ch1 = 20;
sineFrequency = 5; % 10 Hz
totalDuration = 1; % 1 seconds
outputSignal(:,1) = createSine(amplitudePeakToPeak_ch1/2, ...
                        sineFrequency, s.Rate, 'bipolar', totalDuration);
% outputSignal(end+1,:) = 0;

subplot(2,1,1);
time = linspace(0,1,250000);
plot(time,outputSignal);
% keluarkan data
queueOutputData(s,outputSignal);
startBackground(s);


% Osiloskop
osilos = daq.createSession('ni');
osilos.Rate = 250000;
osilos.DurationInSeconds = 1;
addAnalogInputChannel(osilos,'Dev1','ai0','Voltage');

% setting durasi
time = linspace(0,1,250000);

% lakukan pengukuran
inData = startForeground(osilos);

% menampilkan plot
subplot(2,1,2);
plot(time,inData)

