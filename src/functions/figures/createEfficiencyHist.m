function createEfficiencyHist(data1, data2)
%CREATEFIGURE(data1, data2)
%  DATA1:  histogram data
%  DATA2:  histogram data

%  Auto-generated by MATLAB on 26-Feb-2023 23:09:42

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.097667638483965 0.128571428571429 0.861516034985423 0.796428571428572]);
hold(axes1,'on');

% Create histogram
histogram(data1,'DisplayName','170kW Motor','Parent',axes1,'NumBins',6);

% Create histogram
histogram(data2,'DisplayName','200kW Motor','Parent',axes1,'NumBins',6);

% Create ylabel
ylabel('Frequency Count','FontSize',16);

% Create xlabel
xlabel('Efficiency (%)');

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontName','Times','FontSize',24,'XTickLabel',...
    {'55','60','65','70','75','80','85'});
% Create legend
legend1 = legend(axes1,'show');

