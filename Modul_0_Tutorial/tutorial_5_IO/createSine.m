function sine = createSine(amplitude, frequency, sampleRate, type, duration)
    sampleRatePerCycle = floor(sampleRate/frequency);
    period = 1/frequency;
    s = period/sampleRatePerCycle;
    t = (0 : s : period-s)';

    if strcmpi(type, 'bipolar')
        y = amplitude*sin(2*pi*frequency*t);
    elseif strcmpi(type, 'unipolar')
        y = amplitude*sin(2*pi*frequency*t) + amplitude;
    end

    numCycles = round(frequency*duration);
    sine = repmat(y, numCycles, 1);
end