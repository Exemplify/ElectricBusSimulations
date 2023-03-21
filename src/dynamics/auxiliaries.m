

%% Static Power Gain from lights, Radio etc. 


p = dynamics.power.dual + vehicleProperties.auxiliaryKilowatts;


%% Power affected by temperature and HVAC systems
if(options.useTemperature)

    [e_t, p_t] = calcTempModel(vehicleProperties.lowTempPoints , vehicleProperties.highTempPoints , route.temp, route.deltaTime);

    p = p +p_t;
    
    dynamics.hvac_power = p_t;
    dynamics.hvac_energy = e_t;
end 
%% Reassign Power

p = p./vehicleProperties.batteryEfficiency;

dynamics.power.dual = p; 
dynamics.power.positive = p(p>0); 
dynamics.power.negative = p(p<0); 

clear p e_t p_t 