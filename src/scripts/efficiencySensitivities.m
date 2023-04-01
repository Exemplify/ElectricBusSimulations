clear; 
clc

%% Load and preprocess data
conversionsUtil;

%%
efficiencies = {'gearEfficiency', 'inverterEfficiency', 'batteryEfficiency', 'auxiliaryKilowatts', 'energyDensity'};


%%
for eff = efficiencies
    sensitivityTableC3 = table('VariableNames', {'Efficiency', 'Energy', 'Mass', 'PercentageChange'}, ...
        'VariableTypes', {'double', 'double', 'double', 'double'}, 'Size', [9, 4]);
    sensitivityTableC6 = table('VariableNames', {'Efficiency', 'Energy', 'Mass', 'PercentageChange'}, ...
        'VariableTypes', {'double', 'double', 'double', 'double'}, 'Size', [9, 4]);
    index = 1;
    disp(eff{index});
    for sensitivityChange = 0.8:0.05:1.2
        loadOptions; 
        vehicleProperties.(eff{1}) = vehicleProperties.(eff{1}) * sensitivityChange;
        [energy, mass] = calcFinalRouteEnergy([3.75, 7.5], options, vehicleProperties);
        percentageChange = 100;
        sensitivityTableC3{index, :} = [ vehicleProperties.(eff{1}), energy(1), mass(1), percentageChange(1)];
        sensitivityTableC6{index, :} = [ vehicleProperties.(eff{1}), energy(2), mass(2), percentageChange(2)];
        index = index+1;
        disp(['Sensitivity: ' num2str(sensitivityChange) ' for ' eff])
    end

    sensitivitiesC3.(eff{1}) = sensitivityTableC3;
    sensitivitiesC6.(eff{1}) = sensitivityTableC6;
end


%% determine percentange change
% 

for eff = efficiencies
    baseEnergyC3 = sensitivitiesC3.(eff{1}).Energy(5) ;
    baseEnergyC6 = sensitivitiesC6.(eff{1}).Energy(5) ;

    sensitivitiesC3.(eff{1}).PercentageChange =  100*(baseEnergyC3 - sensitivitiesC3.(eff{1}).Energy)./baseEnergyC3;
    sensitivitiesC6.(eff{1}).PercentageChange =  100*(baseEnergyC6 - sensitivitiesC6.(eff{1}).Energy)./baseEnergyC6;
end
