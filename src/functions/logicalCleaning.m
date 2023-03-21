function [speed, time] = logicalCleaning(route, options)
%CLEANGPSDATA Summary of this function goes here

time = route.time; 
speed = route.speed;


if(nargin < 2)
    options.stationaryThreshold = 0.3; 
    options.maxAcceleration = 2.5;
    options.maxSpeed = 40;
end 

% Condition 1: speeds less than 1kmph
speed(speed < options.stationaryThreshold) = 0;
% gpsSpeed = movmean(gpsSpeed, 5);
% Condition 2: speeds greater than 140kmph 
time = time(speed<options.maxSpeed);
speed = speed(speed<options.maxSpeed);

% % Condition 3: acceleration less than max acceleration
exitflag = true;
while(exitflag)
    timediff = diff(time);
    acc = diff(speed)./timediff;
    speedLength = length(speed);
    count = 1;
    for i=1:length(acc) 
        if(i+1 < speedLength && abs(acc(i)) > options.maxAcceleration)
            speed(i+1) = [];
            time(i+1) = []; 
            break;
        end 
        count = count+1;
    end 
    if(count>=length(acc))
        exitflag = false;
    end
end 

speed = pchip(time, speed, route.time);
end

