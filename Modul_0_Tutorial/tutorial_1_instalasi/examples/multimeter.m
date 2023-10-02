dmm = elvis.Multimeter('dcvoltage');
dmm.Range = '1V'; %Set range to 1V

for i = 1:10 %display data for 10 seconds
    dmm.readData;
    pause(1);
end

% clean up if done with the session
% delete(dmm);
