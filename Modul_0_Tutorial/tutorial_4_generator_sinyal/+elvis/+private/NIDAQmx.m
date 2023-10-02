classdef NIDAQmx < handle
    %NIDAQMX Mini-adaptor for the NIDAQmx driver
    %   Provides transparent access a subset of the NIDAQmx's functions.
    %   Keeps track of the nicaiu.dll library. Also cleans up the functions
    %   a bit; note that this may make this class unsuitable for
    %   applications unrelated to the Support Package. See NIDAQmx help for
    %   more information on functions.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    

    methods
        function obj = NIDAQmx
            obj.lib('load');
        end
        
        function delete(obj)
            obj.lib('unload');
        end
    end
    
    methods
        function [status task] = CreateTask(~,taskname)
            task = libpointer('voidPtr');
            status = calllib('ni','DAQmxCreateTask',taskname,task);
        end
        
        function status = ClearTask(~,task)
            status = calllib('ni','DAQmxClearTask',task);
        end
        
        function status = StartTask(~,task)
            status = calllib('ni','DAQmxStartTask',task);
        end
        
        function status = StopTask(~,task)
            status = calllib('ni','DAQmxStopTask',task);
        end
        
        function status = ReserveTask(~,task)
            status = calllib('ni','DAQmxTaskControl',task,elvis.private.Const.DAQmx_Val_Task_Reserve);
        end
        
        function status = UnreserveTask(~,task)
            status = calllib('ni','DAQmxTaskControl',task,elvis.private.Const.DAQmx_Val_Task_Unreserve);
        end
        
        function status = CreateAICurrentChan(~,task,channel,name,min,max)
            status = calllib('ni','DAQmxCreateAICurrentChan',task,channel,name,elvis.private.Const.DAQmx_Val_Cfg_Default,min,max,elvis.private.Const.DAQmx_Val_Amps,elvis.private.Const.DAQmx_Val_Default,0,char(0));
        end
        
        function status = CreateAICurrentRMSChan(~,task,channel,name,min,max)
            status = calllib('ni','DAQmxCreateAICurrentRMSChan',task,channel,name,elvis.private.Const.DAQmx_Val_Cfg_Default,min,max,elvis.private.Const.DAQmx_Val_Amps,elvis.private.Const.DAQmx_Val_Default,0,char(0));
        end  
        
        function status = CreateAIResistanceChan(~,task,channel,name,min,max,exciteval)
            status = calllib('ni','DAQmxCreateAIResistanceChan',task,channel,name,min,max,elvis.private.Const.DAQmx_Val_Ohms,elvis.private.Const.DAQmx_Val_2Wire,elvis.private.Const.DAQmx_Val_Internal,exciteval,char(0));
        end
        
        function status = CreateAIVoltageChan(~,task,channel,name,min,max)
            status = calllib('ni','DAQmxCreateAIVoltageChan',task,channel,name,elvis.private.Const.DAQmx_Val_Cfg_Default,min,max,elvis.private.Const.DAQmx_Val_Volts,char(0));
        end
        
        function status = CreateAIVoltageRMSChan(~,task,channel,name,min,max)
            status = calllib('ni','DAQmxCreateAIVoltageRMSChan',task,channel,name,elvis.private.Const.DAQmx_Val_Cfg_Default,min,max,elvis.private.Const.DAQmx_Val_Volts,char(0));
        end
        
        function status = CreateAOVoltageChan(~,task,channel,name,min,max)
            status = calllib('ni','DAQmxCreateAOVoltageChan',task,channel,name,min,max,elvis.private.Const.DAQmx_Val_Volts,char(0));
        end
        
        function status = CreateAOFuncGenChan(~,task,channel,name,funct,freq,amp,offset)
            status = calllib('ni','DAQmxCreateAOFuncGenChan',task,channel,name,funct,freq,amp,offset);
        end
        
        function [status data] = ReadAnalogScalarF64(~,task)
            [status, ~, data] = calllib('ni','DAQmxReadAnalogScalarF64',task,3,0,libpointer('uint32Ptr'));
        end
        
        function status = WriteAnalogF64(~,task,sampsperchan,data)
            status = calllib('ni','DAQmxWriteAnalogF64',task,sampsperchan,1,3,elvis.private.Const.DAQmx_Val_GroupByChannel,data,0,libpointer('uint32Ptr'));
        end
        
        function [status type] = GetDevProductType(~,devicename)
            buffer = calllib('ni','DAQmxGetDevProductType',devicename,'',0);
            if buffer < 0
                status = buffer;
                type = '';
                return;
            end
            [status, ~, type] = calllib('ni','DAQmxGetDevProductType',devicename,blanks(buffer),buffer);
        end
        
        function status = SetAIMax(~,task,channel,val)
            status = calllib('ni','DAQmxSetAIMax',task,channel,val);
        end
        
        function status = SetAIExcitSrc(~,task,channel,val)
            status = calllib('ni','DAQmxSetAIExcitSrc',task,channel,val);
        end
        
        function status = SetAIExcitVal(~,task,channel,val)
            status = calllib('ni','DAQmxSetAIExcitVal',task,channel,val);
        end
        
        function status = SetAIExcitVoltageOrCurrent(~,task,channel,val)
            status = calllib('ni','DAQmxSetAIExcitVoltageOrCurrent',task,channel,val);
        end
        
        function status = SetAOFuncGenType(~,task,channel,type)
            status = calllib('ni','DAQmxSetAOFuncGenType',task,channel,type);
        end
        
        function status = SetAOFuncGenAmplitude(~,task,channel,amp)
            status = calllib('ni','DAQmxSetAOFuncGenAmplitude',task,channel,amp);
        end
        
        function status = SetAOFuncGenFreq(~,task,channel,freq)
            status = calllib('ni','DAQmxSetAOFuncGenFreq',task,channel,freq);
        end

        function status = SetAOFuncGenOffset(~,task,channel,offset)
            status = calllib('ni','DAQmxSetAOFuncGenOffset',task,channel,offset);
        end
    end
    
    
    methods (Access = private)    
        function lib(~,state)
            %Keeps track of library load status to avoid libload conflicts
            persistent libsloaded;
            if isempty(libsloaded)
                libsloaded = 0;
            end
            
            if strcmp(state,'load')
                libsloaded = libsloaded + 1;
                if ~libisloaded('ni')
                    warning('Off','MATLAB:loadlibrary:TypeNotFound');
                    loadlibrary('nicaiu.dll',@elvis.private.NIDAQmx_hdr,'alias','ni');
                    warning('On','MATLAB:loadlibrary:TypeNotFound');
                end
            else
                libsloaded = libsloaded - 1;
                if libsloaded == 0
                    unloadlibrary('ni');
                end
            end
        end
    end
    
end

