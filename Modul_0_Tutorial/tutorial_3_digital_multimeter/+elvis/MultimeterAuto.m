classdef MultimeterAuto < handle
    %MULTIMETERAUTO "Smart" wrapper class for DMM objects
    %   dmm = elvis.Multimeter(type) returns an object of the specified
    %   type for accessing the digital multimeter. Valid types are:
    %   'dcvoltage', 'acvoltage', 'dccurrent', 'accurrent', 'resistance'.
    %   An object created in this way will automatically connect to a
    %   single connected NI ELVIS II device. Use this if only one device is
    %   connected to the system.
    %
    %   dmm = elvis.Multimeter(type,devicename) returns an object of the
    %   specified type for accessing the digital multimeter on the device
    %   with the specified devicename (ex. 'Dev1'). Use this if multiple NI
    %   devices are connected to the system. See NIDAQmx documentation for
    %   more information on device names.
    %
    %   This class is a more intellegent version of the objects returned by
    %   elvis.Multimeter. Data from the multimeter is periodically
    %   refreshed and stored in the Value property. Autoranging (setting
    %   the range automatically according to input) is available by setting
    %   the Autoranging property to 1. A simple graphical interface is also
    %   available by using the <a href="matlab:help elvis.MultimeterAuto.showGUI">showGUI</a> and <a href="matlab:help elvis.MultimeterAuto.hideGUI">hideGUI</a> methods.
    %
    %   This class is intended for users. Build scripts and functions on
    %   the objects returned by elvis.Multimeter.
    %
            
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
    
    properties(SetAccess = private)
        Type %The multimeter function
        Value = 0 %Current data value from multimeter
    end
    
    properties
        Range%The multimeter range
    end
    properties(Dependent,SetAccess = private)
        RangeValStrings %Acceptable values for the multimeter range
    end
    properties
        Autoranging%Whether the multimeter is autoranging or not
    end
    
    
    properties(Access = private)
        DMMObject
        Timer
        
        %Graphic handles
        Figure = -1
        DataDisp
        RangeDisp
        AutoDisp
        
        %Data buffer
        Data = zeros(1,3);
    end
    
    methods
        function obj = MultimeterAuto(type,devicename)
            if exist('devicename','var') %Create a multimeter object
                obj.DMMObject = elvis.Multimeter(type,devicename);
            else
                obj.DMMObject = elvis.Multimeter(type);
            end
            obj.DMMObject.reserveTask;
            obj.Range = obj.DMMObject.Range;
            obj.Autoranging = 1;
            obj.Type = type;
            
            obj.showGUI; %build initial GUI
            
            obj.Timer = timer('ExecutionMode','fixedSpacing','ObjectVisibility','off',...
                'Period',.1,'TimerFcn',@(~,~)obj.refresh);
            start(obj.Timer);
        end
        
        function delete(obj)
            %Delete various objects as necessary
            if isobject(obj.Timer) && isvalid(obj.Timer)
                stop(obj.Timer);
                delete(obj.Timer);
            end
            if isobject(obj.DMMObject) && isvalid(obj.DMMObject)
                delete(obj.DMMObject);
            end
            if ishandle(obj.Figure)
                delete(obj.Figure)
            end
        end
        
        function showGUI(obj)
        %SHOWGUI shows the MultimeterAuto GUI
        %   dmm.showGUI reveals the graphical interface.
            if ~ishandle(obj.Figure)
                title = ['Multimeter - ' obj.Type];
                obj.Figure = figure('Resize','off','Position',[500 300 300 90],...
                    'Toolbar','none','MenuBar','None','HandleVisibility','off',...
                    'Name',title,'IntegerHandle','off','NumberTitle','off');
                obj.DataDisp = uicontrol(obj.Figure,'Style','Text','String','0',...
                    'Position',[5 35 290 50],'FontSize',30);
                uicontrol(obj.Figure,'Style','Text','String','Range:',...
                    'Position',[5 5 60 30],'FontSize',13);
                obj.RangeDisp = uicontrol(obj.Figure,'Style','Text','String',obj.DMMObject.Range,...
                    'Position',[65 5 95 30],'FontSize',13,'HorizontalAlignment','left');
                uicontrol(obj.Figure,'Style','Text','String','Autoranging:',...
                    'Position',[160 5 105 30],'FontSize',13);
                obj.AutoDisp = uicontrol(obj.Figure,'Style','checkbox',...
                    'Position',[265 5 30 35],'Value',obj.Autoranging,...
                    'Callback',@(~,~)obj.autoCallback);
                obj.Autoranging = obj.Autoranging;
            else
                set(obj.Figure,'visible','on');
            end
        end
        
        function hideGUI(obj)
        %HIDEGUI hides the MultimeterAuto GUI
        %   dmm.hideGUI hides the graphical interface.
            if ishandle(obj.Figure)
                set(obj.Figure,'visible','off');
            end
        end
        
        function val = get.RangeValStrings(obj)
            %Transparent access to DMM object's RVS property
            val = obj.DMMObject.RangeValStrings;
        end
        
        function set.Range(obj,val)
            %Sets the DMM object's range and updates values as necessary
            if ~strcmpi(val,obj.Range)
                obj.DMMObject.Range = val;
            end
            obj.Range = val; %only gets this far if DMMobj doesn't complaing
            if ishandle(obj.RangeDisp)
                set(obj.RangeDisp,'String',obj.Range);
            end
        end
        
        function set.Autoranging(obj,val)
            %Handles error checking, GUI update for autoranging
            validateattributes(val,{'numeric'},{'scalar','binary'});
            obj.Autoranging = val;
            if ishandle(obj.AutoDisp)
                set(obj.AutoDisp,'Value',val);
            end
        end
    end
    
    
    methods(Access = private)
        function refresh(obj)
            drawnow;
            
            %Get new data from the multimeter
            obj.Data(3) = obj.Data(2);
            obj.Data(2) = obj.Data(1);
            obj.Data(1) = readData(obj.DMMObject);
            
            obj.Value = median(obj.Data); %keeps fluctuations due to slipping probes to a miniumum
            
            %autorange
            if obj.Autoranging && any(strcmpi(obj.Type,{'resistance','acvoltage','accurrent','diode','continuity'}))
                obj.autorange(obj.Value) %for "always positive" inputs
            elseif obj.Autoranging && any(strcmpi(obj.Type,{'dcvoltage','dccurrent'}))
                obj.autorange(abs(obj.Value)) %For signed inputs
            end
            
            %update display if valid
            if ishandle(obj.DataDisp)
                index = find(strcmpi(obj.Range,obj.DMMObject.RangeValStrings),1);
                if (any(strcmpi(obj.Type,{'resistance','acvoltage','accurrent','diode'})) && (obj.Value <= 0)) ||...
                        (any(strcmpi(obj.Type,{'dcvoltage','dccurrent'})) && abs(obj.Value) == 0)
                    set(obj.DataDisp,'String','-0.'); %underrange
                elseif abs(obj.Value) > obj.DMMObject.RangeValNumbers{index};
                    set(obj.DataDisp,'String','+Over'); %overrange
                else
                    set(obj.DataDisp,'String',num2str(obj.Value,'%03.4g\n'));
                end
            end
        end
        
        function autorange(obj,val)
            rindex = find(strcmpi(obj.Range,obj.DMMObject.RangeValStrings),1);
            if val > obj.DMMObject.RangeValNumbers{rindex} %step up?
                if rindex ~= 1
                    obj.Range = obj.DMMObject.RangeValStrings{rindex - 1};
                end
            else %or step down?
                newindex = length(obj.DMMObject.RangeValNumbers);
                for i = rindex:newindex
                    if val < obj.DMMObject.RangeValNumbers{i}
                        newindex = i;
                    else
                        break;
                    end
                end
                %newindex is smallest index that's properly in range,
                %including the current index
                obj.Range = obj.DMMObject.RangeValStrings{newindex};
            end
        end
        
        function autoCallback(obj)
            if ishandle(obj.AutoDisp)
                obj.Autoranging = get(obj.AutoDisp,'Value');
            end
        end
    end
    
end

