function [ dividedTS ] = NaiveAnalysis_1( TSCell,isPP2, BaselineT,TestingT, Bin)
%NAIVEANALYSIS Naive Homecage Analysis
%   
%   You NEED to load NEV file using loadTimestamp first.

%   TSCell(TimestampCell): The whole timestamp of all neurons recorded from a daily session
%   BaselineT (sec): Set this time as Baseline Time, Example: 600 for 10 min
%   TestT (sec): Set this time as post-treatment Testing Time, Example: 10800 for 3hr
%   Bin (sec): Example: 120 for 120 sec bin

%   Version: 1.0.05

%TODO: Automatically identify the PauseTime

nNeu = getnNeu(TSCell);

[ dividedTS ] = autoDivideTimestamp( TSCell, false,300);
if isPP2
    PTSCell = dividedTS{2}; %Timestamp after pp2 injection in 20min
    sizePHis = 1200 / Bin;
    PP2His = zeros(nNeu, sizePHis);
    BTSCell = dividedTS{1}; %Baseline Timestamp in Cell
    TTSCell = dividedTS{3}; %Testing Timestamp in Cell
else
    BTSCell = dividedTS{1}; %Baseline Timestamp in Cell
    TTSCell = dividedTS{2}; %Testing Timestamp in Cell
end

sizeBHis = BaselineT./Bin;
sizeTHis = TestingT./Bin;
BaselineHis = zeros(nNeu,sizeBHis); %pre-allocate Baseline Histogram
CIalpha = 0.01; %alpha for Confidence Intervel
BaselineCI = zeros(nNeu,2); %Baseline Confidence Intervel
TestingHis = zeros(nNeu,sizeTHis);  %pre-allocate Testing Histogram

for i = 1:nNeu
    if BTSCell{i}.Timestamp(end) - BTSCell{i}.Timestamp(1) > BaselineT
        BaselineTS = BTSCell{i}.Timestamp(BTSCell{i}.Timestamp > BTSCell{i}.Timestamp(end) - BaselineT); %get Baseline Timestamp
        BaselineHis(i,:) = hist(BaselineTS,sizeBHis) / Bin;
    else
        BaselineTS = BTSCell{i}.Timestamp;
        sizeBHis = ceil((BaselineTS(end) - BaselineTS(1))/Bin);
        BaselineHis = zeros(nNeu,sizeBHis); 
        BaselineHis(i,:) = hist(BaselineTS, sizeBHis)/Bin;
    end
    %% get Confidence Intervel of Baseline
    [MUHAT,SIGMAHAT,MUCI,SIGMACI] = normfit(BaselineHis(i,:),CIalpha);
    MUCI(MUCI<0) = 0;
    BaselineCI(i,:) = MUCI; %Baseline of cell i
    %%
    if TTSCell{i}.Timestamp(end) - TTSCell{i}.Timestamp(1) > TestingT
        TestingTS = TTSCell{i}.Timestamp(TTSCell{i}.Timestamp > TTSCell{i}.Timestamp(end) - TestingT);
        TestingHis(i,:) = hist(TestingTS,sizeTHis)/Bin;
    else
        TestingTS = TTSCell{i}.Timestamp;
        sizeTHis = ceil((TestingTS(end) - TestingTS(1))/Bin);
        TestingHis = zeros(nNeu,sizeTHis);
        TestingHis(i,:) = hist(TestingTS, sizeTHis)/Bin;
    end
    %%ti
    if isPP2
        if PTSCell{i}.Timestamp(end) - PTSCell{i}.Timestamp(1) > 1200
            PP2TS = PTSCell{i}.Timestamp(PTSCell{i}.Timestamp > PTSCell{i}.Timestamp(end) - 1200);
            PP2His(i, :) = hist(PP2TS, sizePHis) / Bin;
        else
            PP2TS = PTSCell{i};
            sizePHis =  ceil((PP2TS(end) - PP2TS(1))/Bin);
            PP2His = zeros(nNeu, sizePHis);
            PP2His(i, :) = hist(PP2TS, sizePHis) / Bin;
        end
    end
    %% plot histogram
    plothere = 1;
    if (plothere == 1)
    
    nfigure = ceil(i/6);  % A new figure is created every 6 subplot.
    figure(nfigure);
    
    IntervalTime = 20; %Interval (in min) between basline recording and post-treatment recording
    
    subplot(2,3,i-(nfigure-1)*6);
   
    %axes(i);
    % x-axis is in min
    if isPP2
        LeadingBars = sizePHis*(Bin/60) + sizeBHis*(Bin/60) + 2 * IntervalTime;
        bar(LeadingBars:Bin/60:LeadingBars+(sizeTHis-1)*(Bin/60),TestingHis(i,:),1,'r');
        hold on

        bars = sizeBHis*(Bin/60) +  IntervalTime;
        bar(bars:Bin/60:bars+(sizePHis - 1)*(Bin/60),PP2His(i,:),1,'g');
        hold on

        bar(Bin/60:Bin/60:Bin/60+(sizeBHis-1)*(Bin/60),BaselineHis(i,:),1,'b');
        hold on
    else
        LeadingBars =  sizeBHis*(Bin/60) + IntervalTime ;
        bar(LeadingBars:Bin/60:LeadingBars+(sizeTHis-1)*(Bin/60),TestingHis(i,:),1,'r');
        hold on

        bar(Bin/60:Bin/60:Bin/60+(sizeBHis-1)*(Bin/60),BaselineHis(i,:),1,'b');
        hold on
    end
    
    line([0,(30+sizeTHis*(Bin/60))],[BaselineCI(i,1),BaselineCI(i,1)],'Color','Black','LineStyle','--');
    line([0,(30+sizeTHis*(Bin/60))],[BaselineCI(i,2),BaselineCI(i,2)],'Color','Black','LineStyle','--');
    
    %%TODO
    %line(); %continuously increased bins
    %line(); %continuously decreased bins
    
    set(gca,'TickDir','Out');
    set(gca,'box','off');
    
    
    xlim([0,210]);
    xlabel('Time (min)');
    ylabel('Firing Rate (sp/s)');
    axis on;
    title(['Cell#' num2str(i)]);
    end
    hold on
end
%% statistical test
% The neuron which has 5 consecutive bins out of BaselineCI in post3h is recognized as firing
% rate change due to the drug.
% The result are stored in a arrary _result_ . "1" represents increased;
% "2" represents both increase and decrease. "-1" represents decrease. "0"
% represents no firing rate change.
result = zeros(nNeu,1);
for i = 1:nNeu
    lower_bound = TestingHis(i,:) - BaselineCI(i, 1);
    upper_bound = TestingHis(i,:) - BaselineCI(i, 2);
    for j = 1:length(TestingHis(i,:)) - 4
        if upper_bound(j) > 0 && upper_bound(j + 1) > 0 && upper_bound(j + 2) > 0 && upper_bound(j + 3) > 0 && upper_bound(j + 4) > 0
            result(i) = 1;
            break;
        end
    end
    for j = 1:length(TestingHis(i,:)) - 4
        if lower_bound(j) < 0 && lower_bound(j + 1) < 0 && lower_bound(j + 2) < 0 && lower_bound(j + 3) < 0 && lower_bound(j + 4) < 0
            if result(i) == 1
                result(i) = 2;
            else
                result(i) = -1;
            end
            break
        end
    end       
end
result


end

