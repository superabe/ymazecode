function [ p,h,trend ] = RankSumTest(SpikeRaster1,SpikeRaster2,alpha,dim)
%RANKSUMTEST Summary of this function goes here
%   Detailed explanation goes here   
if (nargin < 4)
    dim=2;
end
    x = sum(SpikeRaster1,dim)/size(SpikeRaster1,dim);
    y = sum(SpikeRaster2,dim)/size(SpikeRaster2,dim);
    [p,h] = ranksum(x,y,'alpha',alpha);
    
    if dim ==1 
       odim = 2; 
    else
        odim = 1;
    end
    
    sumx=sum(x,odim);
    sumy=sum(y,odim);
    
    if sumx > sumy
        trend = -1;
    else
        trend = 1;
    end
end

