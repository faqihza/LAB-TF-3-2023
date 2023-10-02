clear % membersihkan history
clc % membersihkan command window

import elvis.MultimeterAuto;

dmm = elvis.MultimeterAuto('dcvoltage');

pause(10) % tampilkan dalam waktu 10 detik

dmm.hideGUI;
delete(dmm);
