function [ Mean,SEM ] = MeannSEM(SpikeRaster,FilterWin)
%MEANNSEM Calculate the Mean & SEM of the Spike Density Function of a SpikeRaster
%   Detailed explanation goes here
if nargin == 1;
    FilterWin = 4;
end


nTrial = size(SpikeRaster,1);
SpDenFun = zeros(nTrial,size(SpikeRaster,2)); %SpDenFun: Spike Density Function

for i=1:nTrial
    SpDenFun(i,:)=GFilter(SpikeRaster(i,:),FilterWin);
end
    Mean = sum(SpDenFun,1)/nTrial;
    if (nTrial <30)
        flag = 0;
    else
        flag = 1;
    end
    SEM = std(SpDenFun,flag,1)./sqrt(nTrial);
  
end

