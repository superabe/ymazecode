function [ result, ratematrix ] = Plot3D( allneuron, baseline_period, test_period, Bbin, Tbin)
% Plot the time course of all the neurons from one type of treatment
% Neurons are divided into three types: 
% Up regulated, Remained unchange, down regulated. 
%
[result, ratematrix, Bbins, Tbins] = NaiveAnalysisAll(allneuron, baseline_period, test_period, Bbin, Tbin);
% %% plot the rate matrix
% figure();
% h1 = bar3(ratematrix(result(result(:,2) == 1, 1),1:Bbins + Tbins)');
% title('Neurons with increased firing rate after MPH injection');
% xlabel('Neurons');
% ylabel('Time');
% zlabel('Relative change in Firing rate')
% 
% figure();
% h2 = bar3(ratematrix(result(result(:,2) == -1, 1),1:Bbins + Tbins)');
% title('Neurons with decreased firing rate after MPH injection');
% xlabel('Neurons');
% ylabel('Time');
% zlabel('Relative change in Firing rate')
% 
% figure();
% h3 = bar3(ratematrix(result(result(:,2) == 0, 1),1:Bbins + Tbins)');
% title('Neurons with firing rate remained after MPH injection');
% xlabel('Neurons');
% ylabel('Time');
% zlabel('Relative change in Firing rate')
% 
% figure();
% h3 = bar3(ratematrix(result(result(:,2) == 2, 1),1:Bbins + Tbins)');
% title('Neurons with firing rate fluttered after MPH injection');
% xlabel('Neurons');
% ylabel('Time');
% zlabel('Relative change in Firing rate')

%
% line1 Relative Firing Rate Increased.
up = ratematrix(result(result(:,2) == 1, 1),1:Bbins + Tbins);
sem = std(up)/sqrt(size(up,1));
x = 1:Bbins + Tbins;
y = mean(up);
figure;
error1 = errorbar(x,y,sem);
Line = line(x,y);
% Adjust line properties
set(error1                            , ...
  'Marker'          , 'o'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'g'        , ...
  'MarkerFaceColor' , [.3 .2 .7] );
set(Line,...
   'LineStyle',       ':'        , ...
   'LineWidth',2);
    
hE_c                   = get(error1     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);

hold on;

%
% line2: Relative Firing Rate Decreased.
down = ratematrix(result(result(:,2) == -1, 1),1:Bbins + Tbins);
sem1 = std(down)/sqrt(size(down,1));
y1 = mean(down);
error2 = errorbar(x, y1, sem1);
line1 = line(x, y1);
set(error2                            , ...
  'Marker'          , '^'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'b'        , ...
  'MarkerFaceColor' , [.7 .2 .2] );
set(line1,...
    'LineStyle',       '--'        , ...
    'LineWidth', 2);
hE_c                   = get(error2     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);

% line3  Relative firing rate remained;
remained = ratematrix(result(result(:,2) == 0, 1),1:Bbins + Tbins);
sem2 = std(remained)/sqrt(size(remained,1));
y2 = mean(remained);
error3 = errorbar(x, y2, sem2);
line2 = line(x, y2);
set(error3                            , ...
  'Marker'          , 's'         , ...
  'MarkerSize'      , 8           , ...
  'MarkerEdgeColor' , 'g'         , ...
  'MarkerFaceColor' , [.3 .8 .2]);
set(line2                         , ... 
   'LineStyle',       '-.'        , ...
   'LineWidth',       2);
hE_c                   = get(error3     , 'Children'    );
errorbarXData          = get(hE_c(2), 'XData'       );
errorbarXData(4:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(7:9:end) = errorbarXData(1:9:end) - 0.2;
errorbarXData(5:9:end) = errorbarXData(1:9:end) + 0.2;
errorbarXData(8:9:end) = errorbarXData(1:9:end) + 0.2;
set(hE_c(2), 'XData', errorbarXData);

% Add labels
hTitle  = title (['Neuron Activity Change After Injection for 3h']);
hXLabel = xlabel('Time(min)');
hYLabel = ylabel('Relative Firing Rate');

% Add legend
hLegend = legend([error1, error3, error2], ...
  [num2str(size(up,1)) ' Neurons' ' Increased'] , ...
  [num2str(size(remained, 1)) ' Neurons' ' Unchanged']     , ...
  [num2str(size(down, 1)) ' Neurons' ' Decreased']       , ...
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

hold off;

end

