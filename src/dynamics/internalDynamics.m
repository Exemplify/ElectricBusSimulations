
%% Determine Effeciencies for the gear ratios
rpm2r = convert.rpm2rads;

%% Determine Motor Operating Points

change_up =  0.9*(rpm2r(vehicleProperties.maxSpeed)/vehicleProperties.GR1);
change_down = 0.9*(vehicleProperties.maxTorque*vehicleProperties.GR2);
change_down_min = rpm2r(100);

t = dynamics.torque.dual;
p = t.* dynamics.rads.dual;
dynamics.energy.unadjusted = trapz(p(p>0)).* route.deltaTime;

t(t> 0) = t(t>0)./vehicleProperties.gearEfficiency; 
t(t<0) = t(t<0).*vehicleProperties.gearEfficiency;
dynamics.torque.dual = t;

% if(max(t) > (vehicleProperties.maxTorque*vehicleProperties.GR1))
%     max(t)
% end

if(options.limitByMaxPower)
    limitMaxPower;


v = dynamics.rads.dual;
t = dynamics.torque.dual;

gear_ratios = gearShifting(v, abs(t), change_up, change_down, change_down_min);


t(gear_ratios == 1) = t(gear_ratios == 1)./vehicleProperties.GR1;
v(gear_ratios == 1) = v(gear_ratios == 1).*vehicleProperties.GR1;
t(gear_ratios == 2) = t(gear_ratios == 2)./vehicleProperties.GR2;
v(gear_ratios == 2) = v(gear_ratios == 2).*vehicleProperties.GR2;




%% Determine Efficiencies

v_i = floor((abs(v)./rpm2r(vehicleProperties.maxSpeed)).*700);
t_i = 600 - floor((abs(t)./vehicleProperties.maxTorque).*600);

t_i(t_i<=0) = 1;  


eff = zeros(size(v_i));

for i=1:length(eff)
    if(dynamics.power.dual(i) ~= 0)
        eff(i) = route.ef_map(t_i(i), v_i(i));
    end
end

dynamics.efficiency = eff;

%% Calulate power into motor/ out of inverter

p = dynamics.power.dual;
ppos = p(p>0)./eff(p>0);
pneg = p(p<0).*eff(p<0);

%% power at battery from motor

ppos = ppos./(vehicleProperties.inverterEfficiency.*vehicleProperties.batteryEfficiency); 
pneg = pneg .* vehicleProperties.inverterEfficiency.*vehicleProperties.batteryEfficiency; 

p(p>0) = ppos;
p(p<0) = pneg;

end

%% Reasign Power

dynamics.power.dual = p;
dynamics.power = separateStruct(dynamics.power, p);
dynamics.torque = separateStruct(dynamics.torque, p);
dynamics.rads = separateStruct(dynamics.rads, p);


%% clean up

clear eff_map v t eff change_up change_down change_down_min rpm2r gear_ratios v_i t_i p i

function splitStruct = separateStruct(splitStruct, p)
    splitStruct.positive = splitStruct.dual(p>0);
    splitStruct.negative = splitStruct.dual(p<0);
end


function gear_ratios = gearShifting(v, t, change_up, change_down, change_down_min)
gear_ratios = zeros();
gear = 1;

for i=1:length(v)
    if(gear == 1)
        gear_ratios(i) = 1;
        if(v(i) > change_up)
            gear = 2;
            gear_ratios(i) = 2;
        end 
    end
    if(gear == 2)
        gear_ratios(i) = 2;
        
        if(t(i) > change_down || v(i) < change_down_min)
            gear = 1;
            gear_ratios(i) = 1;
        end 
    end
end 
end