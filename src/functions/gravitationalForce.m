function [fg] = gravitationalForce(mass, roadgrade)
%GRAVITATIONALFORCE Summary of this function goes here
%   Detailed explanation goes here
g = 9.81;
fg = mass.*g.*sin(roadgrade);
end

