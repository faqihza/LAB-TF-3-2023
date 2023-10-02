classdef DMMResistance < elvis.private.DMMSuper
    %DMMRESISTANCE Class for accessing DMM resistance function
    %   dmm = elvis.DMMResistance creates an object that allows access to
    %   the digital multimeter's resistance function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMResistance(devicename) creates a DMMResistance
    %   object associated with the NI ELVIS II device with the specified
    %   device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   Values returned by readData are in ohms. Negative values indicate
    %   negligible resistance. Note that "negligible" depends on range
    %   settings; at the '100Mohm' setting, a 100ohm resistor is
    %   negligible and will return a negative number.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties(Constant)
        RangeValStrings = {'100Mohm','1Mohm','100kohm','1kohm','100ohm'}
        Units = 'Ohms'
    end
    
    properties(SetAccess = protected,Hidden)
        RangeValNumbers = {10^8,10^6,10^5,10^3,10^2}
        CurrentValues = {5*10^-7,5*10^-6,10^-5,10^-3,10^-3,}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = DMMResistance(devicename)
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.DMMSuper(devicename);
            
            status = obj.NIDAQmx.CreateAIResistanceChan(obj.Task,[obj.DeviceName '/dmm'],'dmm',0,10^8,5*10^-7);
            obj.checkStatus(status);
            
            obj.Range = '100Mohm';
        end
    end
    
    methods (Access = protected)
        function setRange(obj,index)
            status = obj.NIDAQmx.SetAIMax(obj.Task,'dmm',obj.RangeValNumbers{index});
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAIExcitVal(obj.Task,'dmm',obj.CurrentValues{index});
            obj.checkStatus(status);
        end
    end
    
end
