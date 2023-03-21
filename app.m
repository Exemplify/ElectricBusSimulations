clear; 
clc;

%% Compute Single Route without Auxilieries
loadOptions; 
vehicleProperties.gearEfficiency = 1;
options.useAuxiliaries = false;
processRoute;
%% Process Break
%% Compute each Route without the effect of internal dynamics or the effect of auxilieries 
% To determine the statistical properties of the route requirements

loadOptions
options.limitByMaxPower = false;
options.useAuxiliaries = false;

computeAllRoutes;
max(r_tot.dynamics.power.positive)
mean(r_tot.dynamics.power.positive)
std(r_tot.dynamics.power.positive)
quantile(r_tot.dynamics.power.positive, [0.90, 0.95, 0.99])
%% Process Break
%% Compute each Route for each Auxiliary does not include HVAC
loadOptions
options.useVehicleDynamics = false;

computeAllRoutes;

%% Process Break
%% Determine Energy Table for the Circuit Variations and the motor specified in the options
loadOptions;
energyTable = calcRouteVariations(vehicleProperties, options);
%% Process Break
%% Determine energy table for the 170kW motor at different occupancies

% Low Power Motor
loadOptions;
options.useAuxiliaries = false;
vehicleProperties.mass = vehicleProperties.maxLoad + vehicleProperties.batteryMass;
[energyTable170kWMax] = calcRouteVariations(vehicleProperties, options);

loadOptions;
options.useAuxiliaries = false;
vehicleProperties.mass = vehicleProperties.midLoad + vehicleProperties.batteryMass;
[energyTable170kWMid] = calcRouteVariations(vehicleProperties, options);


loadOptions;
options.useAuxiliaries = false;
vehicleProperties.mass = vehicleProperties.minLoad + vehicleProperties.batteryMass;
[energyTable170kWMin] = calcRouteVariations(vehicleProperties, options);



%% Process Break
%% Determine Energy for High and Low Power Motor without Auxiliaries

% Low Power Motor
loadOptions;
options.useAuxiliaries = false;
[energyTable170kW, eff_table170kW] = calcRouteVariations(vehicleProperties, options);
% High Power Temperature
options.highPowerMotor = true;
options.useAuxiliaries = false;
loadMotorProperties;
[energyTable200kW, eff_table200kW] = calcRouteVariations(vehicleProperties, options);

%% Process Break
%% Determine Energy for the drive train consumption without the auxilieries or hvac contributions

loadOptions;
options.useAuxiliaries = false;
energyTableDT = calcRouteVariations(vehicleProperties, options);

mainRouteDT = mean(table2array(energyTableDT(:, {'total1', 'total3'})),'all');
minorRouteDT = mean(table2array(energyTableDT(:, {'total2', 'total4'})),'all');

energyDT = mainRouteDT + minorRouteDT;

loadOptions;
options.useAuxiliaries = true;
energyTableDT = calcRouteVariations(vehicleProperties, options);

mainRouteDT = mean(table2array(energyTableDT(:, {'total1', 'total3'})),'all');
minorRouteDT = mean(table2array(energyTableDT(:, {'total2', 'total4'})),'all');

energyDTAux = mainRouteDT + minorRouteDT;

energyAux = energyDTAux - energyDT;
energyHvac = 60035917;
auxTotal = energyHvac + energyAux;
energyPerRoute = auxTotal + energyDT;
dailyEnergy = energyPerRoute*6;


%% Process Break
%% Calculate Battery Mass and Energy for vehicle properties at max load

loadOptions
desiredNumberOfCycles = [3.75, 5.8, 7.5];

[cycleEnergy, batteriesMass, batterySizingTable] = calcFinalRouteEnergy(desiredNumberOfCycles, options, vehicleProperties);
%% Process Break
%% With Battery Mass and Energy determine final model details 
% Requires previous section to run
energyPerRoute = cycleEnergy(3);
batteryMass = batteriesMass(3); 
numCylces = 6;
numberBusses = 26;


dailyEnergy = energyPerRoute*numCylces;
batteryCapacityKWH = (batteryMass * vehicleProperties.energyDensity)/3600000;
grossVehicleMass = batteryMass + vehicleProperties.maxLoad;
chargingPower = dailyEnergy/(numCylces*3.6);
fleetEnergy = dailyEnergy*numberBusses/3600;

%% Process Break
%% Sensitivity Analysis at a single sensitivity instance and for a single efficiency

baseEnergy = [150.952561361859 ,153.173039153320];

loadOptions; 
eff = {'gearEfficiency'};
sensitivityChange = 0.8;
vehicleProperties.(eff{1}) = vehicleProperties.(eff{1}) * sensitivityChange;
[energy, mass] = calcFinalRouteEnergy([3.75, 7.5], options, vehicleProperties);
percentageChange = 100.*(baseEnergy - energy)./baseEnergy;
c3row = [ vehicleProperties.(eff{1}), energy(1), mass(1), percentageChange(1)];
c6row = [ vehicleProperties.(eff{1}), energy(2), mass(2), percentageChange(2)];
