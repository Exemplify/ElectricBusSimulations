clear; 
clc; 
load("energyTotals.mat");

%% Total energy calculations

totalEnergyPerRoute = energyPerRoute/1e6;
totalEnergyPerDay = dailyEnergy/1e6;

%% Fast Charger Sizing to replenish one cycle in 10min

chargingTimeHours = 10 /60; 
energyChargedMegaJoules = totalEnergyPerRoute;

chargingPowerKW = energyChargedMegaJoules./(3.6.*chargingTimeHours)


%% Fast Charging Energy returned in 10 minutes as charging power increases

chargingTimeHours = 10/60; 
chargingPowerKW = 20:5:300;
chargingEfficiency = 1;

energyChargedMegaJoules = chargingEfficiency.*(chargingPowerKW.*chargingTimeHours.*3.6);

figure;
b = bar(chargingPowerKW,energyChargedMegaJoules);
xlabel('Power (kW)')
ylabel('Energy (MJ)')
set(b.Parent, 'FontName','Times','FontSize',24)

%% Minimum energy calculations

chargingPowerKW = 80:40:240;
chargingTimeHours = 10/60; 
energyChargedMegaJoules = (chargingPowerKW.*chargingTimeHours.*3.6);
energyOfRouteWithCharging = max(totalEnergyPerRoute - energyChargedMegaJoules, 0);
energyRequired3Cylces = energyOfRouteWithCharging*3  + totalEnergyPerRoute*3 + min( ...
    energyChargedMegaJoules, totalEnergyPerRoute)
energyRequired6Cycles = energyOfRouteWithCharging*6 + min( ...
    energyChargedMegaJoules, totalEnergyPerRoute)

%%
% chargingPowerKW = 10:10:250;
% energyOfRouteWithCharging = totalEnergyPerRoute - 1.*( ...
%     chargingPower.*chargingTimeHours.*3.6);
% batteryEnergyRequired3Cylces = energyOfRouteWithCharging*3  + totalEnergyPerRoute*3;
% batteryRequiredPerDay = energyOfRouteWithCharging*6 + totalEnergyPerRoute;

%%
round(energyRequired3Cylces)
round(energyRequired6Cycles)
energyRemaining = totalEnergyPerDay;
count = 0;

%%
for x = 1:6
    energyRemaining = energyRemaining - totalEnergyPerRoute
    count = count +1
end

%%
for x = 1:6
    energyRemaining = energyRemaining - totalEnergyPerRoute
    energyRemaining = energyRemaining + energyChargedMegaJoules
    count = count +1
end

%%

%% overnight charging calculations

chargingPowerKW = 20:1:50;
chargingEfficiency = 1;     

chargingTimeHours = totalEnergyPerDay./chargingPowerKW./3.6;
figure;
b = bar(chargingPowerKW,chargingTimeHours);

xlabel('Power (kW)')
ylabel('Time (Hours)')
set(b.Parent, 'FontName','Times','FontSize',24)







