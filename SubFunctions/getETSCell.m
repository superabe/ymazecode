function [ ETSCell ] = getETSCell( BehCell,EventName)
%GETETSCELL Summary of this function goes here
%   Event: 1 tBack;   2 tStart;    3 tTunnel;   4 tChoice
%          5 tReward; 6 tToChoice; 7 tToTunnel; 8 tToStart
%

AllEvent = {'tBack' 'tStart' 'tTunnel' 'tChoice' 'tReward' 'tToChoice' 'tToTunnel' 'tToStart'};
IndexEvent = strcmp(EventName,AllEvent);
IndexE = 1:8;
IndexE = IndexE(IndexEvent);

ETSCell = [ {BehCell{1}{1}(:,IndexE)} {BehCell{2}{1}(:,IndexE)} {BehCell{3}{1}(:,IndexE)}];

end

