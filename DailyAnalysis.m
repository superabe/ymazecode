function [ RankSumCell,ResRelatedCell ] = DailyAnalysis(TSCell,RCell,ETSCell,EWin,WWin,Bin,nDivide,alpha)
%DAILYANALYSIS 
%   1, delay-related analysis
%   2, response-related analysis
%   TSCell:Timestamp Cell
%   RCell:Response Cell
%   ETSCell:Event Timestamp Cell
%   EWindow: Event Window; example:[-10,0]

if (nargin < 8)
    alpha = 0.05;
end
%% Delay-Related Analysis
%Todo: Verify the nNeurons & Units are insistent across blocks
%  calculate the delay SpikeRaster
nNeuron = length(TSCell{1})- 4; %Todo 


for nBlock = 1:3
    
    for i = 1:nNeuron
        % verify consistence of neuron
        if ~(TSCell{1}{i}.Electrode == TSCell{2}{i}.Electrode && TSCell{2}{i}.Electrode == TSCell{3}{i}.Electrode...
             && TSCell{1}{i}.Unit == TSCell{2}{i}.Unit && TSCell{2}{i}.Unit == TSCell{3}{i}.Unit) 
        errordlg('inconsistence of neuron');    
        end   
        %
        
        EventSRCell{nBlock}{i} = getSpikeRaster(TSCell{nBlock}{i}.Timestamp,ETSCell{nBlock},EWin,Bin); %Todo:preallocate EventSR
        [ p,h,trend ] = EventRelated( TSCell{nBlock}{i}.Timestamp,ETSCell{nBlock},EWin,WWin,Bin,nDivide,alpha );
        %testing codes
        if (h == 1)
        dispstr = ['Block:' num2str(nBlock) ' Ele:' num2str(TSCell{nBlock}{i}.Electrode) ...
                  ' Unit' num2str(TSCell{nBlock}{i}.Unit) ' Event-Related p:' num2str(p) ' h:' num2str(h) ' Trend:' num2str(trend)];
        disp(dispstr);
       
        
        %plot delay-relared PETH
            plothere = 0;
            if (plothere == 1);
                if (trend == 1) 
                subplot(2,1,1);
                plotRaster(TSCell{nBlock}{i}.Timestamp,ETSCell{nBlock},[EWin(1)-10,EWin(2)+10]);
                subplot(2,1,2);
                plotHistogram(TSCell{nBlock}{i}.Timestamp,ETSCell{nBlock},[EWin(1)-10,EWin(2)+10],Bin*5,[],'b');
                end 
            end%end plot
        
        end
       
        %testing codes
    end
clear i nBlock;    
    
end

%   MPH-sensitive; Compare Event SpikeRaster across blocks
for nNeu = 1:nNeuron
    [ p12,h12,trend12 ] = RankSumTest(EventSRCell{1}{nNeu},EventSRCell{2}{nNeu},alpha);
    [ p23,h23,trend23 ] = RankSumTest(EventSRCell{2}{nNeu},EventSRCell{3}{nNeu},alpha);
    RankSumCell{nNeu} = [p12,h12,trend12,p23,h23,trend23]; %Todo: preallocate RankSumCell
    
    %testing codes
    if (h12 == 1)
    dispstr = ['Ele:' num2str(TSCell{1}{nNeu}.Electrode) ' Unit:' num2str(TSCell{1}{nNeu}.Unit) ' MPH-sensetive'...
               ' p12:' num2str(p12) ' h12:' num2str(h12) ' trend12:' num2str(trend12) ...
               ' p23:' num2str(p23) ' h23:' num2str(h23) ' trend23:' num2str(trend23)];
    disp(dispstr);
    
    
    %plot MPH-sensitive PETH
        plothere = 0;
        if(plothere ==1)
            plotWin = [EWin(1)-10,EWin(2)+10];

            % ascertain ylimt for plots
            [ Histogram1 ] = getHistogram(TSCell{1}{nNeu}.Timestamp,ETSCell{1},plotWin,Bin*5);
            [ Histogram2 ] = getHistogram(TSCell{2}{nNeu}.Timestamp,ETSCell{2},plotWin,Bin*5);
            [ Histogram3 ] = getHistogram(TSCell{3}{nNeu}.Timestamp,ETSCell{3},plotWin,Bin*5);

            ylimt = ceil(max( [ max(Histogram1) max(Histogram2) max(Histogram3)] ));
            %

            subplot(2,3,1);
            plotRaster(TSCell{1}{nNeu}.Timestamp,ETSCell{1},plotWin);
            subplot(2,3,4);
            plotHistogram(TSCell{1}{nNeu}.Timestamp,ETSCell{1},plotWin,Bin*5,ylimt,'b');

            subplot(2,3,2);
            plotRaster(TSCell{2}{nNeu}.Timestamp,ETSCell{2},plotWin);
            subplot(2,3,5);
            plotHistogram(TSCell{2}{nNeu}.Timestamp,ETSCell{2},plotWin,Bin*5,[],'b');

            subplot(2,3,3);
            plotRaster(TSCell{3}{nNeu}.Timestamp,ETSCell{3},plotWin);
            subplot(2,3,6);
            plotHistogram(TSCell{3}{nNeu}.Timestamp,ETSCell{3},plotWin,Bin*5,ylimt,'b');

            clear ylimt
        end
    end 
   
    %testing codes
end

%% Response-Related Analysis
% re-defind EWin Bin...
LRWin = [-3,5];
%

for nBlock = 1:3
    
    [ResRelatedCell{nBlock}] = ResponseRelatedforBlock( TSCell{nBlock},RCell{nBlock},ETSCell{nBlock},LRWin,Bin,alpha );
   
           
    %testing codes
    for i = 1 : length(ResRelatedCell{nBlock})
        
        if(ResRelatedCell{nBlock}(i).h == 1)
            report = ['In Block:' num2str(nBlock) ' #U' num2str(i) ' Ele:' num2str(TSCell{nBlock}{i}.Electrode)...
                ' Unit:' num2str(TSCell{nBlock}{i}.Unit) ' is response-related'...
                ' p=' num2str(ResRelatedCell{nBlock}(i).p) ' favor:' ResRelatedCell{nBlock}(i).favor];
            disp(report);
            
            %plot
            plothere = 1;
            if(plothere == 1)
                [LETS1,RETS1] = getLRtime(ETSCell{1},RCell{1});
                subplot(3,3,1);
                plotRaster(TSCell{1}{i}.Timestamp,LETS1,LRWin,'b');
                subplot(3,3,4);
                plotRaster(TSCell{1}{i}.Timestamp,RETS1,LRWin,'r');
                
                [LETS2,RETS2] = getLRtime(ETSCell{2},RCell{2});
                subplot(3,3,2);
                plotRaster(TSCell{2}{i}.Timestamp,LETS2,LRWin,'b');
                subplot(3,3,5);
                plotRaster(TSCell{2}{i}.Timestamp,RETS2,LRWin,'r');
                
                [LETS3,RETS3] = getLRtime(ETSCell{1},RCell{1});
                subplot(3,3,3);
                plotRaster(TSCell{3}{i}.Timestamp,LETS3,LRWin,'b');
                subplot(3,3,6);
                plotRaster(TSCell{3}{i}.Timestamp,RETS3,LRWin,'r');
                
                
                
                
                [ LSR1] = getSpikeRaster(TSCell{1}{i}.Timestamp,LETS1,LRWin,Bin);
                [ LMean1,SEM ] = MeannSEM(LSR1,4);
                LMean1 = LMean1./Bin;
                [ RSR1] = getSpikeRaster(TSCell{1}{i}.Timestamp,RETS1,LRWin,Bin);
                [ RMean1,SEM ] = MeannSEM(RSR1,4);
                RMean1 = RMean1./Bin;
                
                [ LSR2] = getSpikeRaster(TSCell{2}{i}.Timestamp,LETS2,LRWin,Bin);
                [ LMean2,SEM ] = MeannSEM(LSR2,4);
                LMean2 = LMean2./Bin;
                [ RSR2] = getSpikeRaster(TSCell{2}{i}.Timestamp,RETS2,LRWin,Bin);
                [ RMean2,SEM ] = MeannSEM(RSR2,4);
                RMean2 = RMean2./Bin;
                
                [ LSR3] = getSpikeRaster(TSCell{3}{i}.Timestamp,LETS3,LRWin,Bin);
                [ LMean3,SEM ] = MeannSEM(LSR3,4);
                LMean3 = LMean3./Bin;
                [ RSR3] = getSpikeRaster(TSCell{3}{i}.Timestamp,RETS3,LRWin,Bin);
                [ RMean3,SEM ] = MeannSEM(RSR3,4);
                RMean3 = RMean3./Bin;
               
                %ylimt = ;
                LRplotW = LRWin(1)+Bin:Bin:LRWin(2); %Todo
                subplot(3,3,7);
                plot(LRplotW,LMean1,'b',LRplotW,RMean1,'r');
                
                subplot(3,3,8);
                plot(LRplotW,LMean2,'b',LRplotW,RMean2,'r');
                
                subplot(3,3,9);
                plot(LRplotW,LMean3,'b',LRplotW,RMean3,'r');
               
            end
            
            %end plot
        end
    end
    %testing codes
end

end

