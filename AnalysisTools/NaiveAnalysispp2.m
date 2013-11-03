function [ result, ratematrix, Bbins, Tbins ] = NaiveAnalysispp2( allneuron,baseline_period, test_period, Bbin, Tbin )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
neuron = divide(allneuron);   % divide all the neruons
Bbins =  baseline_period / Bbin;
Tbins =  test_period / Tbin;
ratematrix = zeros(length(neuron), Bbins + Tbins + 2); % construct a matrix to store the firing rate
BaselineCI = zeros(length(neuron), 2); % Confidence Interval of baseline.
Alpha = 0.01;    %
result = zeros(length(neuron), 3);
for i = 1:length(neuron)
    baseline = neuron{i}{1};
    baseline = baseline(baseline >=baseline(1) & baseline <= baseline(1) + baseline_period);
    ratematrix(i,1:Bbins) = hist(baseline, Bbins) / Bbin;       %binwidth 100s
    %if i < 22 || i > 31
        test = neuron{i}{3};
    %else
     %   test = neuron{i}{2};
    %end
    test = test(test >= test(1) & test <= test(1) + test_period);
    ratematrix(i,Bbins + 1: Bbins + Tbins) = hist(test, Tbins)/Tbin;        %binwidth 360s
    ratematrix(i,Bbins + Tbins + 1) = mean(ratematrix(i,1:Bbins + Tbins));
    ratematrix(i,end) = mean(ratematrix(i,1:Bbins));
    
    % Normalization
    ratematrix(i,1:Bbins + Tbins + 1) = ratematrix(i,1:Bbins + Tbins + 1)/ratematrix(i,end);
    %% Signifcance Test
    % Calculate the 99% percent CI.
    [MUHAT,SIGMAHAT,MUCI,SIGMACI] = normfit(ratematrix(i,1:Bbins), Alpha);
    MUCI(MUCI < 0) = 0;
	BaselineCI(i,:) = MUCI;
    
    lower_bound = ratematrix(i,Bbins + 1: Bbins + Tbins) - BaselineCI(i, 1);
    upper_bound = ratematrix(i,Bbins + 1: Bbins + Tbins) - BaselineCI(i, 2);
    for j = 1:28
        if upper_bound(j) > 0 && upper_bound(j + 1) > 0  && upper_bound(j + 2) > 0  % two consecutive bins bigger than the upper_bound.
            result(i,2) = 1;                               % '1' represents elevated activity.
            result(i,3) = j + 5;                           % return the first  bin appears hyperactivity
            break;
        end
    end
    for j = 1:28
        if lower_bound(j) < 0 && lower_bound(j + 1) < 0 && lower_bound(j + 2) < 0
            if result(i,2) == 1
                result(i,2) = 2;
                result(i,3) = j + 5;
            else
                result(i,2) = -1;
                result(i,3) = j + 5;
            end
            break
        end
    end
    result(:,1) = 1:length(neuron);
end
% % Sort by rows descendingly
%ratematrix = sortrows(ratematrix, -36);
% %% plot the ratematrix
% h = bar3(ratematrix(:,1:35)');
% for i = 1:length(neuron)
%     line([i, i],[0,35],[BaselineCI(i,1),BaselineCI(i,1)],'color','r','linestyle','--','linewidth', 2);
%     line([i, i],[0,35],[BaselineCI(i,2),BaselineCI(i,2)],'color','r','linestyle','--','linewidth', 2);
% end
% title('Neurons with increased firing rate after MPH injection');
% xlabel('Neurons');
% ylabel('Time');
% zlabel('Relative change in Firing rate')
% view([-90,0]); % set the view to y-z plane
% 




