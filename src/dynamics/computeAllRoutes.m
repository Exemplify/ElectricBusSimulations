[cleanOptions, dataType] = dstrc(options, 'cleanOptions', 'dataTypes');

%% Route 1
options.dataType = dataType.route1;
processRoute; 
r1.dynamics = dynamics; 
r1.route = route; 

%% Route 2
options.dataType = dataType.route2;
processRoute; 
r2.dynamics = dynamics; 
r2.route = route; 

%% Route 3
options.dataType = dataType.route3;
processRoute; 
r3.dynamics = dynamics; 
r3.route = route; 
%% Route 4
options.dataType = dataType.route4;
processRoute;
r4.dynamics = dynamics;
r4.route = route;

%% Group Data
r_tot = concat_r({r1,r2,r3,r3});