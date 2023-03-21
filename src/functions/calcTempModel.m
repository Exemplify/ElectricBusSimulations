function [energy, power] = calcTempModel(lowTempPoints, highTempPoints, temperature, deltaTime)
%DETERMINETEMPMODEL Summary of this function goes here
%   Detailed explanation goes here

% Calculate the slope of the low temp line
lowTempCoefs(1) = (lowTempPoints(2,2) - lowTempPoints(1,2)) / (lowTempPoints(2,1) - lowTempPoints(1,1));
lowTempCoefs(2) = lowTempPoints(1,2) - lowTempCoefs(1) * lowTempPoints(1,1);

% Calculate the slope of the high temp line
highTempCoefs(1) = (highTempPoints(2,2) - highTempPoints(1,2)) / (highTempPoints(2,1) - highTempPoints(1,1));
highTempCoefs(2) = highTempPoints(1,2) - highTempCoefs(1) * highTempPoints(1,1);

maxTemp = highTempPoints(2,1);
minTemp = lowTempPoints(1,1); 
highTempPower = highTempPoints(2,2);
lowTempPower = lowTempPoints(1,2);
idealTempLow = lowTempPoints(2,1);
idealTempHigh = highTempPoints(1,1);

T = temperature;

p_t = zeros(size(temperature));
p_t(T >= maxTemp) = highTempPower;
p_t(T < maxTemp) = highTempCoefs(1).*T(T < maxTemp) + highTempCoefs(2);
p_t(T < idealTempHigh) = 0;
p_t(T < idealTempLow) = lowTempCoefs(1).*T(T<idealTempLow)+lowTempCoefs(2);
p_t(T < minTemp) = lowTempPower;
p_t = p_t.*1000;
power = p_t;
energy = trapz(p_t)*deltaTime;

end



