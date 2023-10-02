function setup
%SETUP Setup script for the Support Package for NI ELVIS
%   This function checks that NI-DAQmx is installed correctly and adds the
%   package directory to the MATLAB path (necessary to use the package
%   without setting the package directory as the current folder). Run this
%   before using other classes in the package.
        
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.
    
%% check system
NL = char(10);

if ~strcmp(computer,'PCWIN') %check MATLAB and Windows
    error('NIELVIS:unsupportedSystem',['Incompatible system detected' NL ...
        'The Support Package requires 32 bit MATLAB on a Windows system']);
end

mversion = version('-release'); %check 10b+
if ~(str2num(mversion(3:4)) >= 11 || strcmp(mversion,'2010b')) %#ok<ST2NM>
    error('NIELVIS:unsupportedMATLAB',['Unsupported MATLAB Release' NL...
        'The Support Package requires MATLAB R2010b or later']);
end


if ~license('test','data_acq_toolbox') %check daq
    warning('NIELVIS:noDAT',['Data Acquisition Toolbox not detected' NL...
        'The Support Package requires that the Data Acquisition Toolbox is installed']);
end

%% see if NI-DAQmx is accessable
try
    temp = elvis.private.NIDAQmx;
catch E
    error('NIELVIS:libloadFailed',['NI-DAQmx load failed with error:\n\n"%s"\n\n' ...
    'Is NI-DAQmx installed?\nSee README.pdf for troubleshooting instructions\n'],E.message);
end
fprintf('NI-DAQmx has been successfully detected!\n\n');
delete(temp);


%% add package to MATLAB path
packageParentDir = fileparts(fileparts(mfilename('fullpath')));
addpath(packageParentDir);
fprintf('Added "%s" to MATLAB path\n', packageParentDir);

%% save the path
result = savepath;
if result==1
    warning('NIELVIS:couldNotSavePath',['Unable to save updated MATLAB path\n',...
        '  To save the path, you can: \n',...
        '   1) Exit MATLAB \n',...
        '   2) Right-click the MATLAB icon and select "Run as administrator" \n',...
        '   3) Re-run elvis.setup \n']);
else
    fprintf('Saved updated MATLAB path.\n');
    fprintf(['\nSetup successful. You can now use the functions in the MATLAB Support\n'...
        'MATLAB Support Package for ELVIS II.\n']);
end
end