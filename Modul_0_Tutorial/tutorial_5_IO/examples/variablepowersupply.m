clear
clc

vps = elvis.VarPowSupply;
vps.Vpos = 4;  %Set positive supply to 5V
vps.Vneg = 0; %Set negative supply to -5V

% clean up if done with the session
% delete(vps);