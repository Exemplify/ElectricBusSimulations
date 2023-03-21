clear;
clc

fi = @(varargin)varargin{length(varargin)-varargin{1}};
loadOptions;
options.useAuxiliaries = false;
options.scaleFactor = 1.2;
vehicleProperties.gearEfficiency = 1;
vehicleProperties.batteryEfficiency = 1; 
vehicleProperties.inverterEfficiency = 1;
conversionsUtil;
eff_vals170 = [];
eff_vals200 = [];
%% Imports/Initilisation
for i=0:11
    index = i;
    options.highPowerMotor = mod(i, 2);
    options.scaleFactor = fi(mod(i, 2), options.scaleFactor, options.scaleFactor-0.1);
    loadMotorProperties;
    
    %% Main
    computeAllRoutes
    % processRoute



    %% Post Processing 
    efficiencyReporting;
    eff_vals170 = fi(mod(index, 2), eff_vals170, [eff_vals170, eff.pos]);
    eff_vals200 = fi(mod(index, 2), [eff_vals200, eff.pos], eff_vals200);



%% Determine efficiency values for the different motor powers

mP = vehicleProperties.maxPower./1000;
p = r_tot.dynamics.power.dual;
eff.all = r_tot.dynamics.efficiency;
eff.pos = eff.all(p > 0);
eff.mean = mean(eff.pos);
eff.std = std(eff.pos); 
eff.max = max(eff.pos); 
eff.median = median(eff.pos);

pE = 100*(abs(r_tot.dynamics.energy.unadjusted - r_tot.dynamics.energy.adjusted))/r_tot.dynamics.energy.unadjusted;
tabIndex = [num2str(options.scaleFactor * 100) '%'];

if(index == 0)
    efficiencyTab170MaxLoad = table('RowNames',{'110%','100%','90%','80%','70%','60%'},...
    'VariableTypes',{'double', 'double','double','double','double'}, ...
    'VariableNames',{'mean', 'median', 'std','max','pE'},'Size',[6,5]);
    
    efficiencyTab200MaxLoad = table('RowNames',{'110%','100%','90%','80%','70%','60%'},...
    'VariableTypes',{'double', 'double','double','double','double'}, ...
    'VariableNames',{'mean', 'median','std','max','pE'},'Size',[6,5]);
end

switch(mP)
    case(170)
        efficiencyTab170MaxLoad{tabIndex,:} = [eff.mean, eff.median, eff.std, eff.max, pE];
    case(200)
        efficiencyTab200MaxLoad{tabIndex,:} = [eff.mean, eff.median ,eff.std, eff.max, pE];
end
end

%%
mean(efficiencyTab200MaxLoad.mean)
mean(efficiencyTab170MaxLoad.mean)
createEfficiencyHist(eff_vals170, eff_vals200);