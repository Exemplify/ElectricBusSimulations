function createPowerScatter(X1, Y1, Q)
%CREATEFIGURE(X1, Y1)
%  X1:  scatter x
%  Y1:  scatter y

%  Auto-generated by MATLAB on 06-Feb-2023 20:41:08

% Create figure
figure('OuterPosition',[488 389 994 513]);

% Create axes
axes1 = axes('Position',...
    [0.0838445807770961 0.147619047619048 0.901261802201635 0.777380952380956]);
hold(axes1,'on');

% Create scatter
scatter(X1,Y1);

% Create yline
yline(Q(1),'Alpha',0.8,'LineStyle','-.','LineWidth',1.5,...
    'FontName','Times New Roman',...
    'FontSize',12,...
    'Label','90th Percentile');

% Create yline
yline(Q(2),'Alpha',0.8,'LineStyle','-.','LineWidth',1.5,...
    'FontName','Times New Roman',...
    'FontSize',12,...
    'Label','95th Percentile');

% Create yline
yline(Q(3),'Alpha',0.8,'LineStyle','-.','LineWidth',1.5,...
    'FontName','Times New Roman',...
    'FontSize',12,...
    'Label','99th Percentile');

% Create ylabel
ylabel('Power (kW)');

% Create xlabel
xlabel('Angular Velocity (rad/s)');

hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontName','Times','FontSize',24);
