function [h] = plotHistogram( Timestamp,Event,Win,Bin,ylimit,Color)
%PLOTHISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
if (nargin < 6)
    Color = 'b';
end



edges = Win(1):Bin:Win(2);
[ Histogram ] = getHistogram(Timestamp,Event,Win,Bin);


%% set properties for the plot
h=bar(edges,Histogram,'histc');
set(h,'facecolor',Color);

if (nargin < 5 || isempty(ylimit))
    ylimit = ceil(max(Histogram));
end

xlim([Win(1),Win(2)]);
ylim([0, ylimit]);
set(gca,'TickDir','Out');
xlabel('Time From Event (sec)');
ylabel('Firing Rate (sp/s)');

clear h;
end


