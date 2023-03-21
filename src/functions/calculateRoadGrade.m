function [radians] = calculateRoadGrade(route)
%CALCULATEROADGRADE Calculates the Road Grade based on the relative
%altitude and velocity of a vehicle
%The calculation works by first determining removing all values where the
%vehicle is stationary. The derivative of the altitude is taken to
%determine changes in the vetical velocity, this is divided by the
%horizontal velocity of a vehicle to get change in vertical displacement
%over the change in horizontal displacement, applying trigonometry we can
%determine the angle of the topography based off this result


altitude = route.altitude;
speed = route.speed;

h = 10;
x = cumtrapz(speed) .* route.deltaTime;
y1 = altitude;

[xUnique, ~, ic] = unique(x); % find location of unique x values
yMeans = accumarray(ic, y1, [], @mean); % create a new vector of y values by averaging multiple occurances

x_int = 0:h:max(x);

y2 = pchip(xUnique, yMeans, x_int);
dydx = diff(y2)/h;

radians = atan(dydx);
radians = pchip(x_int(1:end-1),radians, x);
end

