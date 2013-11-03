function [ testmatrix1, testmatrix2 ] = plotBar(  allneuron1,allneuron2, allneuron3, allneuron4, baseline_period, test_period, Bbin, Tbin )
% Plot the percentage of all the neurons from four types of treatments:
% MPH, PP2, SOV, SALINE
% All the neurons from one treatment are SUBDIVIDED TO 4 GROUPS:
% Up regulated, Remained unchange, down regulated, fulltered. 
[result1] = NaiveAnalysisAll(allneuron1,baseline_period, test_period, Bbin, Tbin);
[result2] = NaiveAnalysispp2(allneuron2,baseline_period, test_period, Bbin, Tbin);
[result3] = NaiveAnalysisAll(allneuron3,baseline_period, test_period, Bbin, Tbin);
[result4] = NaiveAnalysisAll(allneuron4,baseline_period, test_period, Bbin, Tbin);

mymatrix1 = zeros(4,3);
testmatrix1 = zeros(4,4);
for i = 1:4
    result = eval(['result' num2str(i)]);    %eval 可以把字符串当变量用
    mymatrix1(i, 1) = length(result(result(:,2) == 1,1));
    mymatrix1(i, 2) = length(result(result(:,2) == -1,1));
    mymatrix1(i, 3) = length(result(result(:,2) == 0,1));
    testmatrix1(i,1:3) = mymatrix1(i, 1:3);
    testmatrix1(i, 4) = sum(testmatrix1(i, 1:3));
    mymatrix1(i,:) = mymatrix1(i,:)/sum(mymatrix1(i,:));
end



figure;
h = bar(mymatrix1);
Xlabel = xlabel('4 Groups');
Ylabel = ylabel('Percent');
legend(h,['Increased';'Decreased';'Unchanged'],'location','NorthWest');
set(gca, 'xticklabel', ['MPH';'PP2';'SOV';'Sal'], 'ylim',[0,0.6]);

mymatrix2 = zeros(4,2);
testmatrix2 = zeros(4,2);
for i = 1:4
    result = eval(['result' num2str(i)]);
    mymatrix2(i, 1) = length(result(result(:,2) == 1,1)) + length(result(result(:,2) == -1,1));
    mymatrix2(i, 2) = length(result(result(:,2) == 0,1));
    testmatrix2(i,:) = mymatrix2(i, :);
    mymatrix2(i,:) = mymatrix2(i,:)/sum(mymatrix2(i,:));
end
figure;
h1 = bar(mymatrix2);
Xlabel = xlabel('4 Groups');
Ylabel = ylabel('Percent');
legend(h1,['Changed  ';'Unchanged'],'location','NorthWest');
set(gca, 'xticklabel', ['MPH';'PP2';'SOV';'Sal'], 'ylim',[0,1]);


end

