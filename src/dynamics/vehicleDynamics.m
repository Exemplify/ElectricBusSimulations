%% Calulate External Traction Forces 

route = tractionForce(route, vehicleProperties);
dynamics.power.dual = route.force.*route.speed;

%% Calculate Internal Properties

dynamics.torque.dual = route.force.*vehicleProperties.wheelRadius;
dynamics.rads.dual = route.speed./vehicleProperties.wheelRadius;
