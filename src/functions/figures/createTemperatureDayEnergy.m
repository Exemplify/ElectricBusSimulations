function createTemperatureDayEnergy(ymatrix1)
%CREATEFIGURE(ymatrix1)
%  YMATRIX1:  bar matrix data

%  Auto-generated by MATLAB on 05-Mar-2023 22:35:06

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0617283950617284 0.123388581952118 0.925925925925925 0.848987108655618]);
hold(axes1,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(ymatrix1);
set(bar1(2),'DisplayName','Coldest Day');
set(bar1(1),'DisplayName','Hottest Day');

% Create ylabel
ylabel('Energy (MJ)');

% Create xlabel
xlabel('Hour of Day');

box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontName','Times','FontSize',24,'XTick',...
    [1 2 3 4 5 6 7 8 9 10 11 12 13],'XTickLabel',...
    {'6:00','7:00','8:00','9:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00'});
% Create legend
legend(axes1,'show');

