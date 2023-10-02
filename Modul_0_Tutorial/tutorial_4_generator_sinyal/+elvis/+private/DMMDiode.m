classdef DMMDiode < elvis.private.DMMSuper
    %DMMDIODE Class for accessing DMM diode function
    %   dmm = elvis.DMMDiode creates an object that allows access to
    %   the digital multimeter's diode function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMDiode(devicename) creates a DMMDiode object associated 
    %   with the NI ELVIS II device with the specified device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   Diode testing uses a 100 microamp test current. Values returned by
    %   readData are in volts.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties(Constant)
        RangeValStrings = {'10V','1V'}
        Units = 'Volts'
    end
    
    properties(SetAccess = protected,Hidden)
        RangeValNumbers = {10,1}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = DMMDiode(devicename)
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.DMMSuper(devicename);
            
            % set up channel
            status = obj.NIDAQmx.CreateAIVoltageChan(obj.Task,[obj.DeviceName '/dmm'],'dmm',0,10);
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAIExcitSrc(obj.Task,[obj.DeviceName '/dmm'],elvis.private.Const.DAQmx_Val_Internal);
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAIExcitVoltageOrCurrent(obj.Task,[obj.DeviceName '/dmm'],elvis.private.Const.DAQmx_Val_Current);
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAIExcitVal(obj.Task,[obj.DeviceName '/dmm'],.0001);
            obj.checkStatus(status);
            
            obj.Range = '10V';
        end
    end
    
    methods (Access = protected)
        function setRange(obj,index)
            status = obj.NIDAQmx.SetAIMax(obj.Task,'dmm',obj.RangeValNumbers{index});
            obj.checkStatus(status);
        end
    end
    
end