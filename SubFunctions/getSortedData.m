function [ SortedData ] = getSortedData( TimeStamp,Electrode,Unit)
%   re-arrage spikes & events as sorted data
%   Version 1.0.1 : fixed bug in the last channel, Jun 13 2013

alldata = [double(TimeStamp)./30000;double(Electrode);double(Unit)];
alldata = rot90(alldata);
alldata = sortrows(alldata,[2,3,1]);
SortedData = divideData(alldata);

end


function [SortedData] = divideData(alldata)

uCh = unique([alldata(:,2) alldata(:,3)],'rows'); %uCh = unique Channel
uIndex = (uCh(:,1)<129 & uCh(:,2) ~=0 & uCh(:,2) ~= 255)| (uCh(:,1) >= 129);
uCh = uCh(uIndex,:);

for i = 1:size(uCh,1)
    
    SortedData{i}.Electrode = uCh(i,1);
    SortedData{i}.Unit = uCh(i,2);
    TStemp = alldata(:,1);
    TSIndex = alldata(:,2)== uCh(i,1) & alldata(:,3)== uCh(i,2);
    SortedData{i}.Timestamp = rot90(TStemp(TSIndex));
    
end

end