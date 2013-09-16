function [ MeanFR,norMeanFR ] = MeanFRs( TSCell )
%MEANFRS Calculate Mean Firing Rate for a session 
%   norMeanFR: normalized (TODO: other algorithm for normalization)
numNeuron = getnNeu(TSCell);
MeanFR = zeros(numNeuron,3);
norMeanFR = zeros(numNeuron,3);

for i=1:numNeuron
    
    for nBlock = 1:3
       
        numSpike = length(TSCell{nBlock}{i}.Timestamp);
        MeanFR(i,nBlock) = numSpike ./ (TSCell{nBlock}{i}.Timestamp(end)- TSCell{nBlock}{i}.Timestamp(1));
        
    end
    
    norMeanFR(i,1) = 1;
    norMeanFR(i,2) = MeanFR(i,2)./MeanFR(i,1);
    norMeanFR(i,3) = MeanFR(i,3)./MeanFR(i,1);
    
end
end

