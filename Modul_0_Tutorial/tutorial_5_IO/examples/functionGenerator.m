fg = elvis.Fgen;
fg.Amplitude = 5;         %set amplitude to 4V
fg.Frequency = 2000;         %set frequency to 2Hz
fg.start;                 %start the function generator
fg.Function = 'triangle'; %change the waveform type

% clean up if done with the session
% delete(fg);