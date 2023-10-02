function checkClasses
%CHECKCLASSES - Unit test for Support Package classes
%   This is a very simple script that loads all of the classes and deletes
%   them. For testing purposes only.
        
    %   MATLAB Support Package for NI ELVIS II
    %   Version 1.0
    %   Copyright 2011 The MathWorks, Inc.

a = elvis.VarPowSupply('test');
delete(a);
a = elvis.Fgen('test');
delete(a);
a = elvis.FgenBNC('test');
delete(a);

types = {'dcvoltage','acvoltage','dccurrent','accurrent','diode','continuity','resistance'};
for i = 1:length(types)
    a = elvis.Multimeter(types{i},'test');
    a.readData;
    delete(a);
end

fprintf('No errors!\n');
end