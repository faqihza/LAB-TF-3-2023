classdef DMMVoltageDC < elvis.private.DMMSuper
    %DMMVOLTAGEDC Class for accessing DMM DC voltage function
    %   dmm = elvis.DMMVoltageDC creates an object that allows access to
    %   the digital multimeter's DC voltage function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMVoltageDC(devicename) creates a DMMResistance
    %   object associated with the NI ELVIS II device with the specified
    %   device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   Values returned by readData are in volts.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties(Constant)
        RangeValStrings = {'60V','10V','1V','100mV'}
        Units = 'Volts'
    end
    
    properties(SetAccess = protected,Hidden)
        RangeValNumbers = {60,10,1,.1}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = DMMVoltageDC(devicename)
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.DMMSuper(devicename);
            
            status = obj.NIDAQmx.CreateAIVoltageChan(obj.Task,[obj.DeviceName '/dmm'],'dmm',0,60);
            obj.checkStatus(status);
            
            obj.Range = '60V';
        end
    end
    
    methods (Access = protected)
        function setRange(obj,index)
            status = obj.NIDAQmx.SetAIMax(obj.Task,'dmm',obj.RangeValNumbers{index});
            obj.checkStatus(status);
        end
    end
    
end

