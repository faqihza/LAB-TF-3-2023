classdef Fgen < elvis.private.Instrument
    %FGEN Class for accessing the NI ELVIS II board function generator
    %   gen = elvis.Fgen constructs an Fgen object for an automatically-detected
    %   NI ELVIS device. Use this constructor if only one device is connected 
    %   to the system.
    %   
    %   gen = elvis.Fgen(devicename) constructs an Fgen object for a NI ELVIS
    %   device with the specified name (ex. 'Dev1').
    %
    %   Note that this class outputs to the Fgen pin on the board. To
    %   output to the BNC connecter instead, use FgenBNC.
    %
    %   The settings of the output function can be directly set as
    %   properties of this class. The function type (sine, triangle, and
    %   square waves), amplitude, freqency and DC offset are all accessable
    %   in this way. Use <a href="matlab:help elvis.Fgen.start">gen.start</a> to start output and <a href="matlab:help elvis.Fgen.stop">gen.stop</a> to stop it.
    %   Properties can be changed even if the function generator is
    %   running. These changes will take effect immediately.
    %
    %   Example usage:
    %       gen = elvis.Fgen;
    %       gen.Amplitude = 3;
    %       gen.Frequency = 24444;
    %       gen.start;
    
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties
        %The type of waveform to output
        Function = 'sine'
        %The zero-to-peak amplitude of the waveform in volts (0 <= Amplitude <= 5)
        Amplitude = 1
        %The frequency of the waveform in Hertz (.186Hz <= Frequency <= 5MHz)
        Frequency = 1
        %The DC offset of the waveform in volts (0 <= Offset <= 5)
        Offset = 0
    end
    
    properties (SetAccess = private)
        %Whether the function generator is running or not
        Running = 0;
    end
    
    properties (SetAccess = private)
        %Possible values for the Function property
        FgenFunctions = {'sine', 'triangle', 'square'}
    end
    
    properties (Access = protected)
        Task
        DeviceName
        NIDAQmx
    end
    
    
    methods
        function obj = Fgen(devicename)
            %Connects to device, creates task and channel
            if ~exist('devicename','var')
                devicename = 'noarg';
            end
            obj = obj@elvis.private.Instrument(devicename);
            
            obj.addChannel;
        end
        
        function delete(obj)
            try %try to stop output if possible
                obj.stop;
            catch
            end
        end
        
        
        function start(obj) 
        %START starts function generator output
        %   gen.start starts the function generator output. This will
        %   generate a waveform on the FGEN pin according to gen's
        %   properties.
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status); %Reset amplitude and start task
            status = obj.NIDAQmx.SetAOFuncGenAmplitude(obj.Task,'fgen',obj.Amplitude);
            obj.checkStatus(status);
            status = obj.NIDAQmx.StartTask(obj.Task);
            obj.checkStatus(status);
            
            obj.Running = 1;
        end
        
        function stop(obj)   
        %STOP stops function generator output
        %   gen.stop stops the function generator output. This will ground
        %   the FGEN pin.
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status); %Set amplitude to 0 ans stop task
            status = obj.NIDAQmx.SetAOFuncGenAmplitude(obj.Task,'fgen',0);
            obj.checkStatus(status);
            status = obj.NIDAQmx.StartTask(obj.Task);
            obj.checkStatus(status);
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status);
            
            obj.Running = 0;
        end
        
        function set.Function(obj,val)
            validateattributes(val,{'char'},{'row'});
            
            %Set the function type
            if ~any(strcmpi(val,obj.FgenFunctions)) %Check string
                msg = ['Invalid function value. Valid values are:' char(10)];
                for i = 1:(length(obj.FgenFunctions)-1)
                    msg = [msg '''' obj.FgenFunctions{i} ''', '];
                end
                msg = [msg '''' obj.FgenFunctions{length(obj.FgenFunctions)} ''''];
                error('NIELIVS:badFunction',msg);
            elseif strcmpi(val,obj.Function)
                obj.Function = val;  
                return;
            end
            
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status);
            
            switch lower(val)
                case obj.FgenFunctions{1} %sine
                    status = obj.NIDAQmx.SetAOFuncGenType(obj.Task,'fgen',elvis.private.Const.DAQmx_Val_Sine);
                case obj.FgenFunctions{2} %triangle
                    status = obj.NIDAQmx.SetAOFuncGenType(obj.Task,'fgen',elvis.private.Const.DAQmx_Val_Triangle);
                case obj.FgenFunctions{3} %square
                    status = obj.NIDAQmx.SetAOFuncGenType(obj.Task,'fgen',elvis.private.Const.DAQmx_Val_Square);
            end
            obj.checkStatus(status);
            
            if obj.Running
                status = obj.NIDAQmx.StartTask(obj.Task);
                obj.checkStatus(status);
            end
            
            if obj.Frequency > 10^6 %only possible when switching from sine funct
                obj.Frequency = 10^6; %bring freq in range
            end
            
            obj.Function = val;                    
        end
        
        function set.Amplitude(obj,val)
            %Set fgen amplitude
            validateattributes(val,{'numeric'},{'scalar','real','>=',0,'<=',5});
            
            
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAOFuncGenAmplitude(obj.Task,'fgen',val);
            obj.checkStatus(status);
            if obj.Running
                status = obj.NIDAQmx.StartTask(obj.Task);
                obj.checkStatus(status);
            end
            
            obj.Amplitude = val;
        end
        
        function set.Frequency(obj,val)
            %Set fgen frequency
            if strcmpi(obj.Function,obj.FgenFunctions{1}) % if sine (max value varies by funct)
                validateattributes(val,{'numeric'},{'scalar','real','>=',.186,'<=',5*10^6});
            else %triangle & square
                validateattributes(val,{'numeric'},{'scalar','real','>=',.186,'<=',10^6});
            end
            
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAOFuncGenFreq(obj.Task,'fgen',val);
            obj.checkStatus(status);
            if obj.Running
                status = obj.NIDAQmx.StartTask(obj.Task);
                obj.checkStatus(status);
            end  
            
            obj.Frequency = val;
        end
        
        function set.Offset(obj,val)
            %Set fgen DC offset
            validateattributes(val,{'numeric'},{'scalar','real','>=',-5,'<=',5});
            
            status = obj.NIDAQmx.StopTask(obj.Task);
            obj.checkStatus(status);
            status = obj.NIDAQmx.SetAOFuncGenOffset(obj.Task,'fgen',val);
            obj.checkStatus(status);
            if obj.Running
                status = obj.NIDAQmx.StartTask(obj.Task);
                obj.checkStatus(status);
            end 
            
            obj.Offset = val;
        end
    end
    
    methods(Access = protected)
        function addChannel(obj)
            status = obj.NIDAQmx.CreateAOFuncGenChan(obj.Task,[obj.DeviceName '/fgen'],'fgen',elvis.private.Const.DAQmx_Val_Sine,1,1,0);
            obj.checkStatus(status);
        end
    end
    
end

