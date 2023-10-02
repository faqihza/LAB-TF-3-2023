clear % membersihkan history
clc % membersihkan command window

import elvis.Fgen;

% membuat objek FGEN (function generator) 
generator_sinyal = Fgen;

generator_sinyal.Amplitude = 4;         %set amplitude to 4V
generator_sinyal.Frequency = 2000;         %set frequency to 2Hz
generator_sinyal.start;                 %start the function generator
generator_sinyal.Function = 'triangle'; %change the waveform type

finishtime = 10; %seconds
starttime = tic;
elapsedtime = 0;

while true
    elapsedtime = toc(starttime);
    if elapsedtime >= finishtime
        generator_sinyal.stop;
        break;
    end
end

delete(generator_sinyal);