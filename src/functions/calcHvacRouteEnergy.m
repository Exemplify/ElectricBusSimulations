function [route_energy, temp_tables] = calcHvacRouteEnergy(hourly_temp, minute_temp, options, vehicleProperties)
%CALCHVACROUTEENERGY Summary of this function goes here
%   Detailed explanation goes here
hourRange = [6,18];

[max_temp_day, min_temp_day] = detemineTempDays(hourly_temp, hourRange);

combined_mean_table_max = calcDailyTempEnergy(max_temp_day, minute_temp, options, vehicleProperties);

combined_mean_table_min = calcDailyTempEnergy(min_temp_day, minute_temp, options, vehicleProperties);

maxTempPrimaryRoute = mean(table2array(combined_mean_table_max(:, ["Var3" ,"Var9" ])),2);
minTempPrimaryRoute = mean(table2array(combined_mean_table_min(:, ["Var3" ,"Var9" ])),2);
maxTempSecondaryRoute = mean(table2array(combined_mean_table_max(:, ["Var6" ,"Var12" ])),2);
minTempSecondaryRoute = mean(table2array(combined_mean_table_min(:, ["Var6" ,"Var12" ])),2);

maxMean = mean(maxTempSecondaryRoute + maxTempPrimaryRoute);
minMean = mean(minTempPrimaryRoute + minTempSecondaryRoute);

route_energy = mean([maxMean, minMean]);
temp_tables.max = combined_mean_table_max;
temp_tables.min = combined_mean_table_min;

end

