function [ output_args ] = plot3Dall( allneuron1,allneuron2, allneuron3, allneuron4, baseline_period, test_period, Bbin, Tbin )
% Plot the time course of all the neurons from four types of treatments:
% MPH, PP2, SOV, SALINE
% All the neurons from one treatment are treated as one group. 
% 
[result1, ratematrix1] = NaiveAnalysisAll(allneuron1,baseline_period, test_period, Bbin, Tbin);
[result2, ratematrix2] = NaiveAnalysispp2(allneuron2,baseline_period, test_period, Bbin, Tbin);
[result3, ratematrix3] = NaiveAnalysisAll(allneuron3,baseline_period, test_period, Bbin, Tbin);
[result4, ratematrix4,Bbins, Tbins] = NaiveAnalysisAll(allneuron4,baseline_period, test_period, Bbin, Tbin);
%% plot1
data1 = ratematrix1(:,1:Bbins + Tbins);
sem1 = std(data1)/sqrt(size(data1,1));
x = 1:Bbins + Tbins;
y1 = mean(data1);
error1 = errorbar(x, y1, sem1);
line1 = line(x, y1);
set(error1                            , ...
  'Marker'          , 's'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'b'         , ...
  'MarkerFaceColor' , [.3 .8 .2]);
set(line1                         , ... 
   'LineStyle',       '-.'        , ...
   'LineWidth',       2);
hE_c                   = get(error1     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);
hold on;
%% plot2
data2 = ratematrix2(:,1:Bbins + Tbins);
sem2 = std(data2)/sqrt(size(data2,1));
x = 1:Bbins + Tbins;
y2 = mean(data2);
error2 = errorbar(x, y2, sem2);
line2 = line(x, y2);
set(error2                            , ...
  'Marker'          , '^'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'b'         , ...
  'MarkerFaceColor' , [.3 .2 .7]);
set(line2                         , ... 
   'LineStyle',       '--'        , ...
   'LineWidth',       2);
hE_c                   = get(error2     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);
%% plot3
data3 = ratematrix3(:,1:Bbins + Tbins);
sem3 = std(data3)/sqrt(size(data3,1));
x = 1:Bbins + Tbins;
y3 = mean(data3);
error3 = errorbar(x, y3, sem3);
line3 = line(x, y3);
set(error3                            , ...
  'Marker'          , 'o'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'b'         , ...
  'MarkerFaceColor' , [.7 .2 .2]);
set(line3                         , ... 
   'LineStyle',       '-'        , ...
   'LineWidth',       2);
hE_c                   = get(error3     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);

%% plot4
data4 = ratematrix4(:,1:Bbins + Tbins);
sem4 = std(data4)/sqrt(size(data4,1));
x = 1:Bbins + Tbins;
y4 = mean(data4);
error4 = errorbar(x, y4, sem4);
line4 = line(x, y4);
set(error4                            , ...
  'Marker'          , 'd'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'b'         , ...
  'MarkerFaceColor' , [.6 .6 .6]);
set(line4                         , ... 
   'LineStyle',       ':'        , ...
   'LineWidth',       2);
hE_c                   = get(error4     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);

%%


% Add labels
hTitle  = title ('Neuron Activity Change for 3h');
hXLabel = xlabel('Time(min)');
hYLabel = ylabel('Relative Firing Rate');
text(Bbins - 0.5,0.7,'\uparrow','fontsize',30);
text(Bbins + 0.1,0.7,'Injection','fontsize',15);
% Add legend
hLegend = legend([error1, error2, error3,error4], ...
  'MPH' , ...
  'PP2'      , ...
  'SOV'       , ...
  'SALINE'    , ...
  'location', 'NorthWest' );

% Adjust font
set( gca                             , 'FontName'   , 'Helvetica' );
set([hTitle, hXLabel, hYLabel]       , 'FontName'   , 'AvantGarde');
set([hLegend, gca]                   , 'FontSize'   , 8           );
set([hXLabel, hYLabel]               , 'FontSize'   , 10          );
set( hTitle                          , 'FontSize'   , 12          , ...
                                       'FontWeight' , 'bold'      );


% Adjust axes properties
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'YTick'       , 0:0.5:5, ...
  'XLim'        , [0,Bbins + Tbins + 1], ...
  'XTickLabel',['-10';' 0 ';' 30';' 60';' 90';'120';'150';'180'], ...
  'LineWidth'   , 1         );



end

