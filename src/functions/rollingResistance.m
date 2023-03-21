function [Fr] = rollingResistance(mass, velocity)
%ROLLINGRESISTANCE calculates the force required by a vehicle to overcome
%the rolling resistance
g = 9.81; 
u0 = 0.006;
u1 = 4.5e-6; 

ur = u0 + u1.*velocity.^2; 
Fr = ur.*mass.*g;
end

