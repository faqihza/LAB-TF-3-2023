classdef DMMCurrentDC < elvis.private.DMMSuper
    %DMMCURRENTDC Class for accessing DMM DC current function
    %   dmm = elvis.DMMCurrentDC creates an object that allows access to
    %   the digital multimeter's DC current function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMCurrentDC(devicename) creates a DMMCurrentDC
    %   object associated with the NI ELVIS II device with the specified
    %   device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   Values returned by readData are in amps.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties(Constant)
        RangeValStrings = {'2A'}
        Units = 'Amps'
    end
    
    properties(SetAccess = protected,Hidden)
        RangeValNumbers = {2}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = DMMCurrentDC(devicename)
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.DMMSuper(devicename);
            
            status = obj.NIDAQmx.CreateAICurrentChan(obj.Task,[obj.DeviceName '/dmm'],'dmm',0,2);
            obj.checkStatus(status);
            
            obj.Range = '2A';
        end
    end
    
    methods (Access = protected)
        function setRange(obj,index)
            status = obj.NIDAQmx.SetAIMax(obj.Task,'dmm',obj.RangeValNumbers{index});  
            obj.checkStatus(status);
        end
    end
    
end