function createBreakdownTorque(X1, YMatrix1)
%CREATEFIGURE(X1, YMatrix1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 19-Feb-2023 19:45:18

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.0982456140350877 0.128571428571429 0.870175438596491 0.796428571428572]);
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'LineWidth',1.5);
set(plot1(1),'DisplayName','Lower Gear');
set(plot1(2),'DisplayName','Upper Gear');

% Create ylabel
ylabel('Torque (Nm)');

% Create xlabel
xlabel('Speed (rpm)','FontSize',14);

hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontName','Times','FontSize',12);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.810526315789474 0.788095238095238 0.146978556284895 0.112698412698413]);

