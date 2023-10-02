classdef TestNIDAQmx < handle
    %TESTNIDAQMX Dummy adaptor for the NIDAQmx driver
    %   Mirrors the API of elvis.NIDAQmx without accessing the NI-DAQmx
    %   driver. Allows for testing of ELVIS code without affecting
    %   hardware.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    methods
        function [status task] = CreateTask(~,taskname) %#ok<*INUSD>
            task = libpointer('voidPtr');
            status = 0;
        end
        
        function status = ClearTask(~,task)
            status = 0;
        end
        
        function status = StartTask(~,task)
            status = 0;
        end
        
        function status = StopTask(~,task)
            status = 0;
        end
        
        function status = ReserveTask(~,task)
            status = 0;
        end
        
        function status = UnreserveTask(~,task)
            status = 0;
        end
        
        function status = CreateAICurrentChan(~,task,channel,name,min,max)
            status = 0;
        end
        
        function status = CreateAICurrentRMSChan(~,task,channel,name,min,max)
            status = 0;
        end
        
        function status = CreateAIResistanceChan(~,task,channel,name,min,max,exciteval)
            status = 0;
        end
        
        function status = CreateAIVoltageChan(~,task,channel,name,min,max)
            status = 0;
        end
        
        function status = CreateAIVoltageRMSChan(~,task,channel,name,min,max)
            status = 0;
        end
        
        function status = CreateAOVoltageChan(~,task,channel,name,min,max)
            status = 0;
        end
        
        function status = CreateAOFuncGenChan(~,task,channel,name,funct,freq,amp,offset)
            status = 0;
        end
        
        function [status data] = ReadAnalogScalarF64(~,task)
            status = 0;
            data = 0;
        end
        
        function status = WriteAnalogF64(~,task,sampsperchan,data)
            status = 0;
        end
        
        function [status type] = GetDevProductType(~,devicename)
            status = 0;
            type = 'NI ELVIS II';
        end
        
        function status = SetAIMax(~,task,channel,val)
            status = 0;
        end
        
        function status = SetAIExcitSrc(~,task,channel,val)
            status = 0;
        end
        
        function status = SetAIExcitVal(~,task,channel,val)
            status = 0;
        end
        
        function status = SetAIExcitVoltageOrCurrent(~,task,channel,val)
            status = 0;
        end
        
        function status = SetAOFuncGenType(~,task,channel,type)
            status = 0;
        end
        
        function status = SetAOFuncGenAmplitude(~,task,channel,amp)
            status = 0;
        end
        
        function status = SetAOFuncGenFreq(~,task,channel,freq)
            status = 0;
        end

        function status = SetAOFuncGenOffset(~,task,channel,offset)
            status = 0;
        end
    end    
end

