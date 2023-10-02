classdef Instrument < handle
    %INSTRUMENT Superclass for all NI ELVIS II instruments
    %   Base class for the Support Package NI ELVIS II instruments.
    %   Does basic system checking, sets up the device and NIDAQmx tasks,
    %   and provides some common utility methods. This class is abstract
    %   and cannot be invoked directly.
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    properties (Access = protected,Abstract)
        Task %NIDAQmx task pointer
        DeviceName %The ELVIS device name
        NIDAQmx %elvis.NIDAQmx object
    end
    
    methods
        function obj = Instrument(devicename) 
            
            if strcmp(devicename,'test') %Test Mode
                obj.DeviceName = devicename;
                obj.NIDAQmx = elvis.private.TestNIDAQmx;
                
            else %Real mode
                %If the device name isn't specified, get one or error
                if strcmp(devicename,'noarg')
                    try
                        if ~strcmp(computer,'PCWIN')
                            [dontcare,msg,id] = obj.check; %#ok<ASGLU>
                            error(id,msg);
                        end
                        devices = daqhwinfo('nidaq');
                        devindeces = find(strcmp('NI ELVIS II',devices.BoardNames));
                        devindeces = [devindeces find(strcmp('NI ELVIS II+',devices.BoardNames))];
                        if isempty(devindeces)
                            error('NIELVIS:noDevices',['No NI ELVIS II devices found' char(10)...
                                'If a device is connected, use daqreset to' char(10)...
                                'reset Data Aquisition Toolbox and try again.']);
                        elseif length(devindeces) > 1
                            msg = ['More than one NI ELVIS II device found. Specify a device manually.' char(10)...
                                'Connected ELVIS device names: ''' devices.InstalledBoardIds{devindeces(1)} ''''];
                            for i = 2:length(devindeces)
                                msg = [msg ', ''' devices.InstalledBoardIds{devindeces(2)} ''''];
                            end
                            error('NIELVIS:multipleDevices',msg);
                        end
                        
                        devicename = devices.InstalledBoardIds{devindeces};
                    catch ME %if there's an error, try to get more helpful system-based error if relevant
                        try %#ok<TRYNC>
                            [status,msg,id] = obj.check;
                            if status ~= 0 && ~strcmp(id,{'NIELVIS:badDeviceName','NIELVIS:notELVIS'}) %system error
                                error(id,msg);
                            end
                        end
                        rethrow(ME);
                    end
                end
                
                obj.DeviceName = devicename;
                obj.NIDAQmx = elvis.private.NIDAQmx;
            end
            
            [status msg id] = obj.check; %check the system
            if ~status
                error(id,msg);
            end
            
            obj.createTask
        end
        
        function delete(obj)
            %Stop tasks and unload lib
            if isobject(obj.NIDAQmx) && isvalid(obj.NIDAQmx) 
                obj.NIDAQmx.StopTask(obj.Task);
                obj.NIDAQmx.ClearTask(obj.Task);
                delete(obj.NIDAQmx);
            end
        end
    end
    
    methods (Sealed,Hidden)
        function reserveTask(obj)
            status = obj.NIDAQmx.ReserveTask(obj.Task);
            obj.checkStatus(status);
        end
        
        function unreserveTask(obj)
            status = obj.NIDAQmx.UnreserveTask(obj.Task);
            obj.checkStatus(status);
        end
    end
    
    methods (Sealed,Access = protected)        
        function [status, errorid, errormsg] = check(obj)
            %Check system and device
            
            status = 0;
            
            NL = char(10); %newline
            
            if ~strcmp(computer,'PCWIN') %check MATLAB and Windows
                errorid = 'NIELVIS:unsupportedSystem';
                errormsg = ['Incompatible system detected' NL ...
                    'The Support Package requires 32 bit MATLAB on a Windows system'];
                return;
            end
            
            mversion = version('-release'); %check 10b+
            if ~(str2num(mversion(3:4)) >= 11 || strcmp(mversion,'2010b')) %#ok<ST2NM>
                errorid = 'NIELVIS:unsupportedMATLAB';
                errormsg = ['Unsupported MATLAB Release' NL...
                    'The Support Package requires MATLAB R2010b or later'];
                return;
            end
                
            
            if ~license('test','data_acq_toolbox') %check daq
                errorid = 'NIELVIS:noDAT';
                errormsg = ['Data Acquisition Toolbox not detected' NL...
                    'The Support Package requires that the Data Acquisition Toolbox is installed'];
                return;
            end
            
            [statust, type] = obj.NIDAQmx.GetDevProductType(obj.DeviceName); %check that device is NI ELVIS II
            if statust == -200220
                errorid = 'NIELVIS:badDeviceName';
                errormsg = sprintf('Specified device name ''%s'' is invalid',obj.DeviceName);
                return;
            elseif ~strcmp(type,{'NI ELVIS II','NI ELVIS II+'})
                errorid = 'NIELVIS:notELVIS';
                errormsg = sprintf(['Specified device with name ''%s'' is not a NI ELVIS II.\n'...
                    'Instead, it was identified as a ''%s''.'],obj.DeviceName,type);
                return;
            end
            obj.checkStatus(statust);
            
            status = 1;
            errormsg = '';
            errorid = '';
        end
        
        function checkStatus(~,status) 
            %Checks NI-DAQmx status value
            if status < 0
                error('NIELVIS:nidaqmxError',elvis.util.getErrorString(status));
            elseif status > 0
                warning('NIELVIS:nidaqmxWarning',elvis.util.getErrorString(status));
            end
        end
        
        function createTask(obj)
            %Create a new task with valid name
            for i = 1:1024 %keep making tasks until there's not a name conflict
                [status obj.Task] = obj.NIDAQmx.CreateTask(['ELVISTask' num2str(i)]);
                if status ~= -200089 %duplicate taskname error
                    break;
                end
            end
            obj.checkStatus(status);
        end
    end
    
end

