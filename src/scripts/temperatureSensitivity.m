clear; 
clc;
%% Determine sensitivity for the hvac model with one change to one property

 
load("wits_temp_2022.mat")
loadOptions;
vehicleProperties.highTempPoints(2,2) =  vehicleProperties.highTempPoints(2,2)*0.8;
hvac_energy2022 = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties);
load("wits_temp_2021.mat")
hvac_energy2021 = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties);
hvac_energy_route = mean([hvac_energy2021, hvac_energy2022]);

loadOptions; 
options.combinedHvacEnergy = hvac_energy_route;
[energy, mass] = calcFinalRouteEnergy([3.75, 7.5], options, vehicleProperties);
percentageChange = 100.*(energy - baseEnergy)./baseEnergy;


%% Determine Sensitivity for high Temp points 
baseEnergy = [1.502870039336621e02,1.525008599525095e02];
changes = {'maxTemp','maxTempPower', 'minTemp', 'minTempPower'};


for col = [0,1,2,3]
    sensitivityHvacTableC3 = table('VariableNames', {'Efficiency', 'Energy', 'Mass', 'PercentageChange'}, ...
        'VariableTypes', {'double', 'double', 'double', 'double'}, 'Size', [9, 4]);
    sensitivityHvacTableC6 = table('VariableNames', {'Efficiency', 'Energy', 'Mass', 'PercentageChange'}, ...
        'VariableTypes', {'double', 'double', 'double', 'double'}, 'Size', [9, 4]);
    index = 1;
    for sensitivityChange = 0.8:0.05:1.2
        load("wits_temp_2022.mat")
        loadOptions;
        col_idx = mod(col,2)+1;

        if( (col+1)/2 <= 1)
            disp('High Temp')
            vehicleProperties.highTempPoints(2,col_idx) =  vehicleProperties.highTempPoints(2,col_idx)*sensitivityChange;
            label = vehicleProperties.highTempPoints(2,col_idx);
        
        else
            disp('Low Temp')
            vehicleProperties.lowTempPoints(1,col_idx) =  vehicleProperties.lowTempPoints(1,col_idx)*sensitivityChange;
            label = vehicleProperties.lowTempPoints(1,col_idx);
        end
        
        hvac_energy2022 = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties);
        load("wits_temp_2021.mat")
        hvac_energy2021 = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties);
        hvac_energy_route = mean([hvac_energy2021, hvac_energy2022]);
        disp(['Hvac Energy is ', num2str(hvac_energy_route)])
        loadOptions;
        options.combinedHvacEnergy = hvac_energy_route;
        [energy, mass] = calcFinalRouteEnergy([3.75, 7.5], options, vehicleProperties);
        percentageChange = 100.*(energy - baseEnergy)./baseEnergy;
        
        sensitivityHvacTableC3{index, :} = [ label, energy(1), mass(1), percentageChange(1)];
        sensitivityHvacTableC6{index, :} = [ label, energy(2), mass(2), percentageChange(2)];
        index = index+1;
        disp(['Sensitivity Complete: ', num2str(sensitivityChange)])
    end

    sensitivitiesHvacC3.(changes{col+1}) = sensitivityHvacTableC3;
    sensitivitiesHvacC6.(changes{col+1}) = sensitivityHvacTableC6;
end 


%% Determine effect of temperature changes as the percentage change wont work

changes = {'maxTemp','maxTempPower', 'minTemp', 'minTempPower'};


for col = [0,2]
    sensitivityHvacTableC3 = table('VariableNames', {'Efficiency', 'Energy', 'Mass', 'PercentageChange'}, ...
        'VariableTypes', {'double', 'double', 'double', 'double'}, 'Size', [9, 4]);
    sensitivityHvacTableC6 = table('VariableNames', {'Efficiency', 'Energy', 'Mass', 'PercentageChange'}, ...
        'VariableTypes', {'double', 'double', 'double', 'double'}, 'Size', [9, 4]);
    index = 1;
    for sensitivityChange = -10:2.5:10
        load("wits_temp_2022.mat")
        loadOptions;
        col_idx = mod(col,2)+1;

        if( (col+1)/2 <= 1)
            disp('High Temp')
            vehicleProperties.highTempPoints(2,col_idx) =  vehicleProperties.highTempPoints(2,col_idx) + sensitivityChange;
            label = vehicleProperties.highTempPoints(2,col_idx);
        else
            disp('Low Temp')
            vehicleProperties.lowTempPoints(1,col_idx) =  vehicleProperties.lowTempPoints(1,col_idx) + sensitivityChange;
            label = vehicleProperties.lowTempPoints(1,col_idx);
        end
        
        hvac_energy2022 = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties);
        load("wits_temp_2021.mat")
        hvac_energy2021 = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties);
        hvac_energy_route = mean([hvac_energy2021, hvac_energy2022]);
        disp(['Hvac Energy is ', num2str(hvac_energy_route)])
        loadOptions;
        options.combinedHvacEnergy = hvac_energy_route;
        [energy, mass] = calcFinalRouteEnergy([3.75, 7.5], options, vehicleProperties);
        percentageChange = 100.*(energy - baseEnergy)./baseEnergy;
        
        sensitivityHvacTableC3{index, :} = [ label, energy(1), mass(1), percentageChange(1)];
        sensitivityHvacTableC6{index, :} = [ label, energy(2), mass(2), percentageChange(2)];
        index = index+1;
        disp(['Sensitivity Complete: ', num2str(sensitivityChange)])
    end

    sensitivitiesHvacC3.(changes{col+1}) = sensitivityHvacTableC3;
    sensitivitiesHvacC6.(changes{col+1}) = sensitivityHvacTableC6;
end 



%%
% 
% for h = 6:18
%     loadOptions;
%     options.scaleFactor = 1.1;
%     options.useTemperature = true;
%     options.useVehicleDynamics = false;
%     temp_hour.Time = min_temp_day.Time + hours(h);
%     temperature;
%     for index=1:6
%         % Main
%         computeAllRoutes
%         % processRoute
%         energyReporting;
%         % Post Processing 
%         options.scaleFactor = options.scaleFactor-0.1;
%     end
%     combined_mean_table_min(h-5, :) = array2table(mean(table2array(energyTable),1));
% end
% 
% %%
% 

%%

%% Clean up
clear barometer gps ef_map_image dataType
