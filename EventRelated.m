function [ p,h,trend ] = EventRelated( Timestamp,Event,EWin,WWin,Bin,nDivide,alpha )
%EVENTRELATED examine a neuron is event-related
%   EWin: Event window
%   WWin: Wider window
if(nargin<7)
    alpha = 0.05;
elseif(nargin<6)
    nDivide = 1;
end
EventSR = getSpikeRaster(Timestamp,Event,EWin,Bin); % Event window SpikeRaster
WSR = getSpikeRaster(Timestamp,Event,WWin,Bin); %Winder window SpikeRaster
diff = getevrFR(EventSR,Bin) - getevrFR(WSR,Bin);
if(diff >=0)
    trend = 1;
else
    trend = -1;
end

EWinW = EWin(1,2) - EWin(1,1); %EWindowWidth
subEWinW = floor(EWinW/nDivide);

p=1;
h=false;
for n=1:nDivide
    subEventSR = getSpikeRaster(Timestamp,Event,[EWin(1,1)+(n-1)*subEWinW,EWin(1,1)+n*subEWinW],Bin); %Event SpikeRaster
    
    [pn,hn] = RankSumTest(subEventSR,WSR,alpha);
    p = min(p,pn);
    h = h|hn;
end
end

