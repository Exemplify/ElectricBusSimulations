function [interpRouteEnergy,interpCyclesMass, batterySizingTable] = calcFinalRouteEnergy(cyclesRequired, options, vehicleProperties)

%% Setup Battery Sizing constants and scaffolding
numIterations = 41;
stepSize = 50;
%% Load and preprocess data
conversionsUtil;
batterySizingTable = table();

%% Iterate over route with varying battery size

for I=1:numIterations
    vehicleProperties.mass = vehicleProperties.maxLoad + I*stepSize;
    batterySize = I*stepSize;
    batteryCap= I*stepSize*vehicleProperties.energyDensity;
    energyTable = calcRouteVariations(vehicleProperties, options);

    circuitsEnergyMean = mean(table2array(energyTable));
    mainCircuit = mean(circuitsEnergyMean(1, [3, 9]));
    minorCiruit = mean(circuitsEnergyMean(1, [6, 12]));
    
    combinedRouteEnergy= (minorCiruit + mainCircuit);
    totalEnergyPerRoute = (options.combinedHvacEnergy + combinedRouteEnergy);
    numberOfCycles = batteryCap/totalEnergyPerRoute;
    batterySizingTable(I, :) = {batterySize, batteryCap, totalEnergyPerRoute, numberOfCycles};
end

interpCyclesMass = round(interp1(batterySizingTable.Var4, batterySizingTable.Var1, cyclesRequired));
interpRouteEnergy = interp1(batterySizingTable.Var1, batterySizingTable.Var3, round(interpCyclesMass))./1e6;

end

