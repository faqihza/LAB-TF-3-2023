function msg = getErrorInfo
%GETERRORINFO Retreive NIDAQmx extended error string for the last error
%   msg = elvis.getErrorInfo returns the extended error string from the last
%   NIDAQmx error that occured. 
        
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.

[buffersize ~] = daq.ni.NIDAQmx.DAQmxGetExtendedErrorInfo(' ',uint32(0));

if(buffersize <= 0) %NIDAQmx error
    error('NIELVIS:errorRetrieveFailed','Unable to retrieve NIDAQmx error');
end

[status msg] = daq.ni.NIDAQmx.DAQmxGetExtendedErrorInfo(blanks(buffersize),uint32(buffersize));

if status ~= 0 %NIDAQmx error;
    error('NIELVIS:errorConvFailed','Unable to convert NIDAQmx error');
end

end

