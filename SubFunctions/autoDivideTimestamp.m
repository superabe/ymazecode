function [ dividedTS ] = autoDivideTimestamp( TimestampCells, isYmaze, threshold)
%DIVIDETIMESTAMP Divide paused Timestamp
% Acoording to the period of pause.
% Default setting of threshold is 600(10min).
if nargin < 3
    threshold = 600;
end

% set the threshhold.
% if the period between two events is bigger than the threshold.
% it would be recognized as one pause.
numChannel = length(TimestampCells);
MaxId = 0;

%% Caculate the number and value of pausetime
% Find the unit with the highest frequency, the unit firing for the longest
% time
temp_freq = 0;
if isYmaze
    channel = numChannel - 4;
else
    channel = numChannel;
end
for i = 1:channel
    if length(TimestampCells{i}.Timestamp) > temp_freq
        temp_freq = length(TimestampCells{i}.Timestamp);
        MaxId = i;
    end
end
% Calculate the gap between two spike and find the ones bigger than the
% threshold.
delta = TimestampCells{MaxId}.Timestamp(2:end) - TimestampCells{MaxId}.Timestamp(1:end - 1);
delta = [0 delta];
PauseTime = TimestampCells{MaxId}.Timestamp(delta >= threshold) - 10;      %PauseTime with correction. 

% find the end of timestamp
% set this value as the max time

MaxTime = TimestampCells{MaxId}.Timestamp(end);
PauseTime = [0 PauseTime MaxTime + 1];
numPause = length(PauseTime);
dividedTS = cell(1, numPause - 1);
%% Divide the timestamp according the pausetime found earlier.
for j = 1:numPause - 1
    for i = 1:numChannel
            dividedTS{j}{i}.Electrode = TimestampCells{i}.Electrode;
            dividedTS{j}{i}.Unit = TimestampCells{i}.Unit;
            dividedTS{j}{i}.Timestamp = TimestampCells{i}.Timestamp(TimestampCells{i}.Timestamp >= PauseTime(j) & TimestampCells{i}.Timestamp < PauseTime(j + 1));
    end
end            
end

