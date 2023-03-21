% Define the temperature range and create a temperature vector
T = -10:0.1:40;


[~, P] = calcTempModel([0, 26; 20, 0], [24, 0; 30, 28], T, 0.1);

% Plot the power consumption as a function of temperature
figure
plot(T, P./1000, 'LineWidth', 2);
xlabel('Temperature (°C)');
ylabel('Power Consumption (kW)');
grid on
