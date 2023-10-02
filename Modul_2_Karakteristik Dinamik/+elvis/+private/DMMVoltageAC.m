classdef DMMVoltageAC < elvis.private.DMMSuper
    %DMMVOLTAGEAC Class for accessing DMM AC voltage function
    %   dmm = elvis.DMMVoltageAC creates an object that allows access to
    %   the digital multimeter's AC voltage function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMVoltageAC(devicename) creates a DMMResistance
    %   object associated with the NI ELVIS II device with the specified
    %   device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   Values returned by readData are in RMS volts.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties(Constant)
        RangeValStrings = {'20V','2V','200mV'}
        Units = 'RMS Volts'
    end
    
    properties(SetAccess = protected,Hidden)
        RangeValNumbers = {20,2,.2}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = DMMVoltageAC(devicename)
            %Connect to device, create task and channel
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.DMMSuper(devicename);
            
            status = obj.NIDAQmx.CreateAIVoltageRMSChan(obj.Task,[obj.DeviceName '/dmm'],'dmm',0,20);
            obj.checkStatus(status);
            
            obj.Range = '20V';
        end
    end
    
    methods (Access = protected)
        function setRange(obj,index)
            %updates range as necessary
            status = obj.NIDAQmx.SetAIMax(obj.Task,'dmm',obj.RangeValNumbers{index});
            obj.checkStatus(status);
            obj.getSample; %first measurement always seems to be really inaccurate
        end
    end
    
end