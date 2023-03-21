function [energyTable, effeciencyTable] = calcRouteVariations(vehicleProperties, options)
%CALCROUTEVARIATIONS Summary of this function goes here
%   Detailed explanation goes here



    energyTable = table('RowNames',{'110%','100%','90%','80%','70%','60%'},...
    'VariableTypes',{'double', 'double','double','double','double', 'double', ...
    'double','double','double','double', 'double', 'double'}, ...
    'VariableNames',{'expended1', 'regen1', 'total1', 'expended2', 'regen2', 'total2' ...
    'expended3', 'regen3', 'total3','expended4', 'regen4', 'total4',},'Size',[6,12]);

    effeciencyTable = table();
    
    names = {'110', '100', '90', '80', '70', '60'};
    options.scaleFactor = 1.1;
    for index=1:6
        % Main
        computeAllRoutes;
        
        [expended1, regen1, total1] = dstrc(r1.dynamics.energy, 'expended', 'regenerated', 'total');
        [expended2, regen2, total2] = dstrc(r2.dynamics.energy, 'expended', 'regenerated', 'total');
        [expended3, regen3, total3] = dstrc(r3.dynamics.energy, 'expended', 'regenerated', 'total');
        [expended4, regen4, total4] = dstrc(r4.dynamics.energy, 'expended', 'regenerated', 'total');
        
        tabIndex = [num2str(options.scaleFactor * 100) '%'];
        
        
        energyTable{tabIndex,:} = [expended1, regen1, total1, expended2, regen2, total2, expended3, regen3, total3, expended4, regen4, total4];
  
        effeciencyTable.(names{index}) = r_tot.dynamics.efficiency';

        % Post Processing 
        options.scaleFactor = options.scaleFactor-0.1;
    end
end

