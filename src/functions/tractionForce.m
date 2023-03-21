function [route] = tractionForce(route, vehicleProperties)
%TRACTIONFORCE Determine the total traction force applied at the wheels of
%the vehicle

F = vehicleProperties.mass * route.acceleration;
Fg = gravitationalForce(vehicleProperties.mass, route.roadGrade);
Fa = aerodynamicDrag(route.speed);
Fr = rollingResistance(vehicleProperties.mass, route.speed);

route.force = F + Fa + Fg + Fr;
route.forces.gravitation = Fg; 
route.forces.aerodynamics = Fa;
route.forces.rolling = Fr;
route.forces.acceleration = F; 
end

