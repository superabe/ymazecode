function [ SpikeRaster ] = getSpikeRaster(Timestamp,Event,Win,Bin)
%PREEVENTHISTO Peri-Envent Time Histogram
%   Detailed explanation goes here
if (nargin < 4)
    Bin = 0.05;
end

if ~(Win(1,1) < Win(1,2)) %win1 < win2
    errordlg('Window setting error!');
    return;
end

numBin = (Win(1,2)-Win(1,1))/Bin;
numTrial= length(Event);
SpikeRaster = zeros(numTrial,numBin);


for i=1:numTrial
    
    SpikeinTrial = Timestamp((Timestamp >= (Event(i)+Win(1,1))) & (Timestamp <= (Event(i)+Win(1,2))));
    DisfromEvent = SpikeinTrial - Event(i);
    DisfromWin = floor((DisfromEvent - Win(1,1))/Bin)+1;
    Location = DisfromWin(DisfromWin<=numBin & DisfromWin >0);
 
    for j=1:size(Location,2)
    SpikeRaster(i,Location(1,j)) = SpikeRaster(i,Location(1,j))+1;
    end
end
    
end