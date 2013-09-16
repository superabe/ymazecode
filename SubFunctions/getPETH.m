function [ Histogram ] = getPETH(Timestamp,Event,Win,Bin)
%GETHISTOGRAM get peri-event time histogram
%   Detailed explanation goes here
if (nargin < 4)
    Bin = 0.1;
end

edges = Win(1):Bin:Win(2);
Histogram= zeros(1,length(edges));

numTrial = length(Event);
for i=1:numTrial
    
    SpikeinTrial{i,1} = Timestamp((Timestamp >= (Event(i)+Win(1,1))) & (Timestamp <= (Event(i)+Win(1,2))));
    DisfromEvent{i,1} = SpikeinTrial{i,1} - Event(i,1);
    Histogram = Histogram+histc(DisfromEvent{i,1},edges);
end
    Histogram = Histogram./numTrial./Bin;
end

