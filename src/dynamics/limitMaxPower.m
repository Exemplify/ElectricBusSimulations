%% Linearly reduce Torque and velocity
torque = dynamics.torque.dual;
rads = dynamics.rads.dual;

p = torque.*rads;
power_indicies_pos = p > vehicleProperties.maxPower;
power_indicies_neg = p < -vehicleProperties.maxPower;

powerRatio = p(power_indicies_pos)./vehicleProperties.maxPower;
torque(power_indicies_pos) = torque(power_indicies_pos).*(1./(powerRatio.^0.5));
rads(power_indicies_pos) = rads(power_indicies_pos).*(1./(powerRatio.^0.5));

powerRatioNeg = p(power_indicies_neg)./-vehicleProperties.maxPower;
torque(power_indicies_neg) = torque(power_indicies_neg).*(1./powerRatioNeg);

p = torque.*rads;

dynamics.power.dual = p;
dynamics.torque.dual = torque; 
dynamics.rads.dual = rads;
dynamics.energy.adjusted = trapz(p(p>0)).* route.deltaTime;

clear p powerPositive power_indicies_pos powerRatio torque rads;
