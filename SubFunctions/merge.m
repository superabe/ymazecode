function [ neuron ] = merge( data )
%MERGE Summary of this function goes here
%   Detailed explanation goes here

m = 1;
for i = 1:length(data)
    for j = 1:length(data{i})
        m = m + 1;
    end
end
neuron = cell(1,m - 1);
m = 1;
for i = 1:length(data)
    for j = 1:length(data{i})
        neuron{m} = data{i}{j};
        m = m + 1;
    end
end
end

