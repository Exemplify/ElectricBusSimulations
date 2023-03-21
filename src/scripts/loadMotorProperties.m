
if(options.highPowerMotor)
    vehicleProperties.maxPower = 200e3;
    vehicleProperties.maxTorque = 2800;
    vehicleProperties.maxSpeed = 2500;
    vehicleProperties.GR1 = 6;
    vehicleProperties.GR2 = 2.25; 
else
    vehicleProperties.maxPower = 170e3;
    vehicleProperties.maxTorque = 2150;
    vehicleProperties.maxSpeed = 2700;
    vehicleProperties.GR1 = 8; 
    vehicleProperties.GR2 = 2.5;
end