clear
clc

import elvis.MultimeterAuto;
 
% tampilkan multimeter
dmm = elvis.MultimeterAuto('dcvoltage');

% membuat analog output pada ai0
s = daq.createSession('ni');
s.Rate = 8000;
addAnalogOutputChannel(s,'Dev1','ao0','Voltage');

% keluarkan data
vOutput = 5;
queueOutputData(s,vOutput);
startBackground(s)
