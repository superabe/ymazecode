function [ nNeuron ] = getnNeu( TSCell )
%GETNNEU get the num of Neuron(unit) from a TSCell
%   Detailed explanation goes here
nNeuron = 0;
for i = 1:length(TSCell)
    
    if ~isempty(TSCell{i});
        if(TSCell{i}.Electrode <=128 && ~(TSCell{i}.Unit == 0 ||TSCell{i}.Unit == 255))
           nNeuron = nNeuron+1;
        end
    end
end
end

