function obj = Multimeter(type,devicename)
    %MULTIMETER Creates a NI ELVIS II multimeter object
    %   dmm = elvis.private.Multimeter(type) returns an object of the specified
    %   type for accessing the digital multimeter. Valid types are:
    %   'dcvoltage', 'acvoltage', 'dccurrent', 'accurrent', 'resistance', 'diode', 'continuity'
    %   An object created in this way will automatically connect to a
    %   single connected NI ELVIS II device. Use this if only one device is
    %   connected to the system.
    %
    %   dmm = elvis.private.Multimeter(type,devicename) returns an object of the
    %   specified type for accessing the digital multimeter on the device
    %   with the specified devicename (ex. 'Dev1'). Use this if multiple NI
    %   devices are connected to the system. See NIDAQmx documentation for
    %   more information on device names.
    %   
    %   Objects returned by Multimeter have a standard interface. Use
    %   <a href="matlab:help elvis.private.DMMSuper.readData">readData</a> to read a value from the device in base units (ex. volts,
    %   not millivolts). Set the Range property to one of the strings in
    %   RangeValStrings to change the measurement range. The multimeter
    %   will not properly read values above this range, so set this to the
    %   lowest value greater than the expected value to be measured.
    %
    %   Example usage:
    %       dmm = elvis.Multimeter('resistance');
    %       dmm.Range = '100ohms';
    %       data = dmm.readData;
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.

if ~exist('devicename','var')
    switch lower(type)
        case 'dcvoltage'
            obj = elvis.private.DMMVoltageDC;
        case 'acvoltage'
            obj = elvis.private.DMMVoltageAC;
        case 'dccurrent'
            obj = elvis.private.DMMCurrentDC;
        case 'accurrent'
            obj = elvis.private.DMMCurrentAC;
        case 'resistance'
            obj = elvis.private.DMMResistance;
        case 'diode'
            obj = elvis.private.DMMDiode;
        case 'continuity'
            obj = elvis.private.DMMContinuity;
        otherwise
            typeerror;
    end
else
    switch lower(type)
        case 'dcvoltage'
            obj = elvis.private.DMMVoltageDC(devicename);
        case 'acvoltage'
            obj = elvis.private.DMMVoltageAC(devicename);
        case 'dccurrent'
            obj = elvis.private.DMMCurrentDC(devicename);
        case 'accurrent'
            obj = elvis.private.DMMCurrentAC(devicename);
        case 'resistance'
            obj = elvis.private.DMMResistance(devicename);
        case 'diode'
            obj = elvis.private.DMMDiode(devicename);
        case 'continuity'
            obj = elvis.private.DMMContinuity(devicename);
        otherwise
            typeerror;
    end
end

end

function typeerror %just consolidates the type error
error('NIELVIS:invalidType',['Invalid multimeter type. Acceptable values are:' char(10)...
    '''dcvoltage'', ''acvoltage'', ''dccurrent'', ''accurrent'', ''resistance'',''diode'',''continuty''']);
end