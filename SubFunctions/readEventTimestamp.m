function [ EventTimestamp ] = readEventTimestamp()
%READEVENTTIMESTAMP read EventTimestamp from txt file
%   Detailed explanation goes here
[FileName,PathName] = uigetfile('*.txt','TXT-files (*.txt)');

fid = fopen(strcat(PathName,FileName));
C=textscan(fid, '%s %n %s %n %s %s %n %s %s %n %n %n %n %n %n %n %n %n %n');
fclose(fid);

end

