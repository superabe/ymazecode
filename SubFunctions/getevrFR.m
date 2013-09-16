function [ evrFR ] = getevrFR( SpikeRaster, Bin )
%FR everage Firing rate of a SpikeRaster
%   Detailed explanation goes here
evrFR = sum(sum(SpikeRaster,2)./size(SpikeRaster,2),1)./size(SpikeRaster,1)/Bin;

end

