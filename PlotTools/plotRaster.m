function plotRaster(Timestamp,Event,Win,EventName,tickColor,tickHight)
%PLOTRASTER Raster plot for a Spike Raster
%   Detailed explanation goes here

if (nargin < 6)
    tickHight = 0.7;
end
if(nargin < 5)
    tickColor = 'b';
end
if (nargin < 4)
    EventName = 'Event';
end

numTrial = length(Event);
for i=1:numTrial
    
    SpikeinTrial{i,1} = Timestamp((Timestamp >= (Event(i)+Win(1,1))) & (Timestamp <= (Event(i)+Win(1,2))));
    DisfromEvent{i,1} = SpikeinTrial{i,1} - Event(i,1);
end

% figure;
% hold on;
for i=1:numTrial
    
    for j = 1:length(DisfromEvent{i,1})
        line([DisfromEvent{i,1}(j),DisfromEvent{i,1}(j)],[i-1,i-1+tickHight],'Color',tickColor)
    end
end

%% set properties of the plot
ylim([0 numTrial]);
line([0,0],[0,numTrial],'Color','Black','LineStyle','--');
set(gca,'YDir','reverse'); %reverse the Y axis 
set(gca,'YTick', []);%disable Y ticks
set(gca,'ycolor',[1,1,1]); %set Y axis white
%set(gca,'ycolor',get(get(gca,'parent'),'color'));%set Y axis invisible
set(gca,'TickDir','Out');
xlabel(['Time From ', EventName, ' (sec)']);

end

