classdef VarPowSupply < elvis.private.Instrument
    %VARPOWSUPPLY Provdes access to the variable power supply
    %   vps = elvis.VarPowerSupply constructs a VPS object for an 
    %   automatically-detected NI ELVIS device. Use this constructor if only 
    %   one device is connected to the system.
    %   
    %   gen = elvis.VarPowerSupply(devicename) constructs a VPS object for a 
    %   NI ELVIS device with the specified name (ex. 'Dev1').
    %
    %   The positive and negative voltages can be changed as properties of
    %   the device (Vpos and Vneg). Both values can be any number between
    %   0 and +-12V.
    %
    %   Example usage:
    %       vps = elvis.VarPowSupply;
    %       vps.Vpos = 3;
    %       vps.Vneg = -12;
        
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties
        Vpos = 0 %The Supply+ voltage (0 - 12 volts)
        Vneg = 0 %The Supply- voltage (-12 - 0 volts)
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    methods
        function obj = VarPowSupply(devicename)
            %Creates task and channels
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.Instrument(devicename);
            
            status = obj.NIDAQmx.CreateAOVoltageChan(obj.Task,[obj.DeviceName '/vpsPos'],'vpsPos',0,12);
            obj.checkStatus(status);
            status = obj.NIDAQmx.CreateAOVoltageChan(obj.Task,[obj.DeviceName '/vpsNeg'],'vpsNeg',-12,0);
            obj.checkStatus(status);
        end
        
        function delete(obj)
            try %zero outputs if possible
                obj.Vpos = 0;
                obj.Vneg = 0;
            catch
            end
        end
        
        function set.Vpos(obj,val)
            %Sets positive supply voltage
            validateattributes(val,{'numeric'},{'scalar','real','>=',0,'<=',12});
            
            status = obj.NIDAQmx.WriteAnalogF64(obj.Task,1,[val,obj.Vneg]);
            obj.checkStatus(status);
            
            obj.Vpos = val;
        end
        
        function set.Vneg(obj,val)
            %Sets negative supply voltage
            validateattributes(val,{'numeric'},{'scalar','real','>=',-12,'<=',0});
            
            status = obj.NIDAQmx.WriteAnalogF64(obj.Task,1,[obj.Vpos,val]);
            obj.checkStatus(status);
            
            obj.Vneg = val;
        end
    end
    
end

