%% Convert to relative time
gps.time = epochToDateTime(gps.time);
barometer.time = epochToDateTime(barometer.time);
barometer.time = posixtime(barometer.time);
gps.time = posixtime(gps.time);

%% Setup Constants
n = 2000;
finalTime = min([barometer.time(end), gps.time(end)]);
initialTime = max([barometer.time(1), gps.time(1)]);
deltaTime = (finalTime-initialTime)/n;
time = linspace(initialTime, finalTime, n);
route.deltaTime = deltaTime;

%% process to common time stamps

route.altitude = movmean(pchip(barometer.time,barometer.relativeAltitude, time),5);
route.speed = movmean(pchip(gps.time, gps.speed , time),5);

route.time = time - initialTime;

route.speed_RAW = route.speed;
route.speed = logicalCleaning(route, cleanOptions);

route.speed = route.speed .* options.scaleFactor;
route.time = route.time ./options.scaleFactor; 
route.deltaTime = route.deltaTime ./options.scaleFactor;

finalSecond = round(route.time(end));
if(options.useTemperature)
 route.temp = interp1((0:finalSecond)', options.temp_seconds.Temp(1:finalSecond+1), route.time);
end
%% Calculate route properties
route.roadGrade = calculateRoadGrade(route); 
route.acceleration = diff(route.speed)./deltaTime;
route.acceleration(end+1) = 0;

%% determine efficiency map 
route.ef_map = ef_map_image(:,:,1);
route.ef_map = (double(route.ef_map) -100)./100;
dynamics.power.dual = zeros(size(route.speed));

%% Clean up constants
clear n finalTime initialTime time deltaTime

