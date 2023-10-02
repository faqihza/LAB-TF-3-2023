function msg = getErrorString( errorcode )
%GETERRORSTRING Convert NIDAQmx error code to a MATLAB error
%   ME = elvis.getErrorString(errorcode) takes an error code from a NIDAQmx 
%   function, retrieves the associated desciptive error string, and returns 
%   it.
        
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.

errorcode = int32(errorcode);

[buffersize ~] = daq.ni.NIDAQmx.DAQmxGetErrorString(errorcode,' ',uint32(0));

if(buffersize <= 0) %NIDAQ error
    error('NIELVIS:errorConvFailed','Unable to convert NIDAQmx error');
end

[status msg] = daq.ni.NIDAQmx.DAQmxGetErrorString(errorcode,blanks(buffersize),uint32(buffersize));

if status ~= 0 %NIDAQmx error;
    error('NIELVIS:errorConvFailed','Unable to convert NIDAQmx error');
end

end

