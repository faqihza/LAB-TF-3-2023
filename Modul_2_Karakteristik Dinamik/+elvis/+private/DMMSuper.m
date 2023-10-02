classdef DMMSuper < elvis.private.Instrument
    %DMMSUPER Base class for all DMM objects
    %   Builds on elvis.Instrument to include aspects common to the various
    %   DMM instruments. This class is abstract and cannot be invoked 
    %   directly.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties
        %Range of measurement to use. Value is maximum value to be measured
        %and is restricted to the strings in RangeValStrings.
        Range
    end
    
    properties(Constant,Abstract)
        %The strings allowed as settings for Range.
        RangeValStrings
        Units
    end

    properties(SetAccess = protected,Hidden,Abstract)
        %The numbers associated with RangeValStrings.
        RangeValNumbers
    end
    
    methods
        function obj = DMMSuper(devicename)
            obj = obj@elvis.private.Instrument(devicename);
        end
        
        function data = readData(obj)
        %READDATA reads a sample from the DMM
        %   data = dmm.readData reads a single sample from the digital
        %   multimeter. The value returned is in base units (ie. volts,
        %   amps, ohms).
            data = obj.getSample;
        end
        
        function set.Range(obj,val)
            %Converts string to index and then calls setRange
            index = find(strcmpi(val,obj.RangeValStrings),1);
            if isempty(index)
                msg = ['Invalid range value. Valid values are:' char(10)]; %build error message with valid ranges
                for i = 1:(length(obj.RangeValStrings)-1)
                    msg = [msg '''' obj.RangeValStrings{i} ''', '];
                end
                msg = [msg '''' obj.RangeValStrings{length(obj.RangeValStrings)} ''''];
                error('NIELIVS:badRange',msg);
            elseif strcmpi(val,obj.Range)
                obj.Range = val;
                return;
            end
            
            obj.setRange(index);
            
            obj.Range = val;
        end
    end
    
    methods(Access = protected)
        function newTask(obj)
            %Creates a brand new task
            status = obj.NIDAQmx.ClearTask(obj.Task);
            obj.checkStatus(status);
            obj.createTask;
        end
        
        function data = getSample(obj)
            %Gets a single sample from the ELVIS II using ReadAnalogScalarF64
            %May have to be reimplemented for some measurements
            [status data] = obj.NIDAQmx.ReadAnalogScalarF64(obj.Task);
            obj.checkStatus(status);
        end
    end
    
    methods(Abstract,Access = protected)
        setRange(obj,index) %Backend for setting range on device
    end
    
end

