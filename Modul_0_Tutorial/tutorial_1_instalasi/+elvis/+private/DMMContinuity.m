classdef DMMContinuity < handle
    %DMMCONTINUITY Class for accessing DMM continuity function
    %   dmm = elvis.DMMContinuity creates an object that allows access to
    %   the digital multimeter's continuity function. This will
    %   automatically connect to a single connected NI ELVIS II device. Do
    %   not use this constructor if multiple ELVISs are connected.
    %
    %   dmm = elvis.DMMContinuity(devicename) creates a DMMContinuity
    %   object associated with the NI ELVIS II device with the specified
    %   device name.
    %
    %   Use the readData method to get a single value from the device.
    %   Change the Range property to change the range (valid range
    %   properties are stored in the RangeValStrings constant property).
    %
    %   For continuity testing, readData will return a 0 or 1, with 1
    %   indicating continuity. The threshold for continuity is 15 ohms.
    
    %   DMMContinuity uses the same interface as other DMM classes;
    %   however, it is actually a wrapper for the DMMResistance class. It
    %   does not implement DMMSuper, at least not directly. Range values
    %   are there for compatibility reasons only; they don't affect
    %   anything. RangeValNumbers is designed so output is always "in
    %   range".
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    
    properties
        %Range of measurement to use. Value is maximum value to be measured
        %and is restricted to the strings in RangeValStrings.
        Range = 'N/A'
    end
    
    properties(SetAccess = private)
        %The strings allowed as settings for Range.
        RangeValStrings = {'N/A'}
        Units = 'N/A'
    end
    
    properties(SetAccess = private,Hidden)
        %The numbers associated with RangeValStrings.
        RangeValNumbers = {2}
    end
    
    properties(Access = private)
        ResistanceObj
    end
    
    methods
        function obj = DMMContinuity(devicename)
            if exist('devicename','var')
                obj.ResistanceObj = elvis.private.DMMResistance(devicename);
            else
                obj.ResistanceObj = elvis.private.DMMResistance;
            end
            
            obj.ResistanceObj.Range = '100ohm';
        end
        
        function delete(obj)
            if isobject(obj.ResistanceObj) && isvalid(obj.ResistanceObj)
                delete(obj.ResistanceObj);
            end
        end
        
        
        function val = readData(obj)
        %READDATA reads a sample from the DMM
        %   data = dmm.readData reads a single sample from the digital
        %   multimeter. The value returned is 0 for no continuity or 1 for
        %   continuity.
            res = obj.ResistanceObj.readData;
            if res <= 15
                val = 1;
            else
                val = 0;
            end
        end
        
        function set.Range(obj,val)
            if ~strcmpi(val,obj.Range)
                error('NIELIVS:badRange',['Invalid range value. Valid values are:' char(10) '''N/A''']);
            end
            obj.Range = val;
        end
    end
    
    methods(Hidden)
        function reserveTask(obj)
            obj.ResistanceObj.reserveTask;
        end
        
        function unreserveTask(obj)
            obj.ResistanceObj.unreserveTask;
        end
    end
    
end

