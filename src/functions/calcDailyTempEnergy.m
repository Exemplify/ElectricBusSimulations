function [combined_mean_table] = calcDailyTempEnergy(day, minute_temp, options, vehicleProperties)
%CALCDAILYTEMPENERGY Determine the energy that the bus uses for the hvac
% model in each hour over the day
    combined_mean_table = array2table(zeros(13,12));
    for h = 6:18
        options.useTemperature = true;
        options.useVehicleDynamics = false;
        vehicleProperties.auxiliaryKilowatts = 0;

        start_time = day.Time + hours(h);
        end_time = start_time + hours(1);
        hour_range = timerange(start_time, end_time, 'closed');
        temp_minutes = minute_temp(hour_range, :);
        options.temp_seconds = retime(temp_minutes, 'secondly', 'linear');
    
        energyTable = calcRouteVariations(vehicleProperties, options);
        combined_mean_table(h-5, :) = array2table(mean(table2array(energyTable)));
    end
end

