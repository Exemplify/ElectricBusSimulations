%% Intilisation

importData;
conversionsUtil
%% Preprocessing
preprocessRouteData;

%% dynamics calculations
if(options.useVehicleDynamics)
    vehicleDynamics; 
    %% Internal Characteristics
    internalDynamics;
else 
    dynamics.energy.adjusted = 0;
    dynamics.energy.unadjusted = 0;
    dynamics.efficiency = zeros(size(dynamics.power.dual));
end

if(options.useAuxiliaries)
    auxiliaries;
end

%% Energy Calculations

p = dynamics.power.dual;
dynamics.power.positive = p(p>0); 
dynamics.power.negative = p(p<0); 



dynamics.energy.dual = cumtrapz(dynamics.power.dual).*route.deltaTime;
dynamics.energy.positive = cumtrapz(dynamics.power.positive).*route.deltaTime;
dynamics.energy.negative = cumtrapz(dynamics.power.negative).*route.deltaTime;

dynamics.energy.expended = trapz(dynamics.power.positive).*route.deltaTime;
dynamics.energy.regenerated = trapz(dynamics.power.negative).*route.deltaTime;
dynamics.energy.total = trapz(dynamics.power.dual)*route.deltaTime;

clear p
