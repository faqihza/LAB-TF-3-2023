clear % membersihkan history
clc % membersihkan command window

import elvis.Multimeter;

dmm = elvis.Multimeter('dcvoltage');

sampling = 100; % millisec
N = 100;
starttime = tic;
elapsedtime = 0;
nexttime = elapsedtime + sampling*0.001;

data_pengukuran = zeros(1,100);

idx = 1;

while true
    elapsedtime = toc(starttime);
    if elapsedtime >= nexttime
        data_pengukuran(idx) = dmm.readData;
        nextime = elapsedtime + sampling*0.001;
        idx = idx+1;
    end
    
    if idx > N
        break
    end
end

delete(dmm);
