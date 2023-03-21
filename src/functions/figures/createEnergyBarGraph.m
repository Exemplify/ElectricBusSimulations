function createEnergyBarGraph(ymatrix1)
%CREATEFIGURE(ymatrix1)
%  YMATRIX1:  bar matrix data

%  Auto-generated by MATLAB on 04-Mar-2023 12:20:57

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0871613663133098 0.128801431127013 0.899882214369846 0.796198568872988]);
hold(axes1,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(ymatrix1);
set(bar1(2),'DisplayName','Primary Route');
set(bar1(1),'DisplayName','Secondary Route');

% Create ylabel
ylabel('Energy (MJ)');

% Create xlabel
xlabel('Speed Profile Scale Factor (%)');

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontName','Times','FontSize',24,'XTickLabel',[110 100 90 80 70 60]);
% Create legend
legend(axes1,'show');