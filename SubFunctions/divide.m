function [ neuron ] = divide( data,threshold )
% Autodivide timestamp of neurons with the setting threshold.
% The input data should be only timestamp.
if nargin < 2
    threshold = 300;
end
neuron = cell(size(data));
for i = 1:length(data)
    delta = data{i}(2:end) - data{i}(1:end - 1);
    temp = data{i}(2:end);
    pausetime = temp(delta >= threshold);
    if isempty(pausetime)
        fprintf('There is no pause.')
        break;
    else
        pausetime = [0, pausetime, data{i}(end)];
        neuron{i} = cell(1,length(pausetime) - 1);
        for j = 1:length(pausetime) - 1
            neuron{i}{j} = data{i}(data{i} >= pausetime(j) & data{i} < pausetime(j + 1));
        end
    end
end
end

