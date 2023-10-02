classdef FgenBNC < elvis.Fgen
    %FGENBNC Class for accessing the NI ELVIS II BNC function generator 
    %   gen = elvis.FgenBNC constructs an Fgen object for an automatically-detected
    %   NI ELVIS device. Use this constructor if only one device is connected 
    %   to the system.
    %   
    %   gen = elvis.FgenBNC(devicename) constructs an FgenBNCobject for a NI ELVIS
    %   device with the specified name (ex. 'Dev1').
    %
    %   Note that this class outputs to the BNC connected on the left side
    %   of the ELVIS. Use Fgen to output to the board Fgen connection.
    %
    %   The settings of the output function can be directly set as
    %   properties of this class. The function type (sine, triangle, and
    %   square waves), amplitude, freqency and DC offset are all accessable
    %   in this way. Use <a href="matlab:help elvis.Fgen.start">gen.start</a> to start output and <a href="matlab:help elvis.Fgen.stop">gen.stop</a> to stop it.
    %   Properties can be changed even if the function generator is
    %   running. These changes will take effect immediately.
    %
    %   Example usage:
    %       gen = elvis.FgenBNC;
    %       gen.Amplitude = 3;
    %       gen.Frequency = 24444;
    %       gen.start;
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    
    methods
        function obj = FgenBNC(devicename)
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.Fgen(devicename);
        end
    end
    

    methods(Access = protected)
        function addChannel(obj)
            status = obj.NIDAQmx.CreateAOFuncGenChan(obj.Task,[obj.DeviceName '/fgenBNC'],'fgen',elvis.private.Const.DAQmx_Val_Sine,1,1,0);
            obj.checkStatus(status);
        end
    end
end