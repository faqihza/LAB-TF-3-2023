classdef DMMCurrentAC < elvis.private.DMMSuper
    %DMMCURRENTAC Class for accessing DMM AC current function
    %   dmm = elvis.DMMCurrentAC creates an object that allows access to
    %   the digital multimeter's AC current function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMCurrentAC(devicename) creates a DMMCurrentAC
    %   object associated with the NI ELVIS II device with the specified
    %   device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   Values returned by readData are in RMS amps.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties(Constant)
        RangeValStrings = {'2A','500mA'}
        Units = 'RMS Amps'
    end
    
    properties(SetAccess = protected,Hidden)
        RangeValNumbers = {2,.5}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = DMMCurrentAC(devicename)
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.DMMSuper(devicename);
            
            status = obj.NIDAQmx.CreateAICurrentRMSChan(obj.Task,[obj.DeviceName '/dmm'],'dmm',0,2);
            obj.checkStatus(status);
            
            obj.Range = '2A';
        end
    end
    
    methods (Access = protected)
        function setRange(obj,index)
            status = obj.NIDAQmx.SetAIMax(obj.Task,'dmm',obj.RangeValNumbers{index});
            obj.checkStatus(status);
            obj.getSample; %first measurement always seems to be really inaccurate
        end
    end
    
end