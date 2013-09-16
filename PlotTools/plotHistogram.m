function [h] = plotHistogram( Timestamp,EventTS,Win,Bin,ylimit,Color,EventName)
%PLOTHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
if (nargin < 7)
    EventName = 'Event';
end
if (nargin < 6)
    Color = 'b';
end



edges = Win(1):Bin:Win(2);
[ Histogram ] = getPETH(Timestamp,EventTS,Win,Bin);


%% set properties for the plot
h=bar(edges,Histogram,'histc');
set(h,'facecolor',Color);

if (nargin < 5 || isempty(ylimit))
    ylimit = ceil(max(Histogram));
end

xlim([Win(1),Win(2)]);
ylim([0, ylimit]);
set(gca,'TickDir','Out');
xlabel(['Time From ', EventName, ' (sec)']);
ylabel('Firing Rate (sp/s)');

clear h;
end


