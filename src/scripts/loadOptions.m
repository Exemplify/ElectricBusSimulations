dataType.route1 = 0; 
dataType.route2 = 1; 
dataType.route3 = 2; 
dataType.route4 = 3; 
options.dataTypes = dataType;

%% Cleaning Options 

cleanOptions.maxChanges = 5;
cleanOptions.stationaryThreshold = 0.3; 
cleanOptions.maxAcceleration = 2.5;
cleanOptions.maxSpeed = 40;
options.cleanOptions = cleanOptions;

%% Define Options

options.interpLength = 2000;
options.dataType = dataType.route1;
options.limitByMaxPower = true;
options.scaleFactor = 1;                                      
options.highPowerMotor = false;
options.useTemperature = false;
options.useAuxiliaries = true;
options.useVehicleDynamics = true;
options.combinedHvacEnergy = 49722891; % this is with battery losses already considered

vehicleProperties.minLoad = 13775;
vehicleProperties.midLoad = 15888;
vehicleProperties.maxLoad = 18000;
vehicleProperties.batteryMass = 800;
vehicleProperties.mass = vehicleProperties.maxLoad + vehicleProperties.batteryMass;

vehicleProperties.wheelRadius = 0.3;
vehicleProperties.gearEfficiency = 0.95;
vehicleProperties.inverterEfficiency = 0.98;
vehicleProperties.batteryEfficiency = 0.96;
vehicleProperties.auxiliaryKilowatts = 700;
vehicleProperties.energyDensity = 936000;

vehicleProperties.lowTempPoints = [0, 26; 20, 0];
vehicleProperties.highTempPoints = [24, 0; 30, 28];

loadMotorProperties;

