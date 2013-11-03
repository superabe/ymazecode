function [ neuron ] = getTimestamp( data )
% The input argument "data" is A Timestampcell 
% in which contains three variables: Electrode,
% Unit, Timestamp.
% The return value is a cell in which all the neurons
% are separated in diffenrent cells containing Timestamp alone.
neuron = cell(1, length(data));
for i = 1:length(data)
    neuron{i} = data{i}.Timestamp;
end
end

