function [ dividedTS ] = divideTimestamp( TimestampCells, PauseTime )
%DIVIDETIMESTAMP Divide paused Timestamp
%   PauseTime: Manually enter the time of pause
%   Version 1.0.0 only supports daat with one pause time 
numChannel = length(TimestampCells);

for i = 1:numChannel
    dividedTS{1,1}{1,i}.Electrode = TimestampCells{1,i}.Electrode;
    dividedTS{1,1}{1,i}.Unit = TimestampCells{1,i}.Unit;
    dividedTS{1,1}{1,i}.Timestamp = TimestampCells{1,i}.Timestamp(TimestampCells{1,i}.Timestamp<PauseTime);
    
    dividedTS{1,2}{1,i}.Electrode = TimestampCells{1,i}.Electrode;
    dividedTS{1,2}{1,i}.Unit = TimestampCells{1,i}.Unit;
    dividedTS{1,2}{1,i}.Timestamp = TimestampCells{1,i}.Timestamp(TimestampCells{1,i}.Timestamp>PauseTime);
    
end


end

