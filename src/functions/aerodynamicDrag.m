function [Fa] = aerodynamicDrag(velocity)
%AERODYNAMICDRAG determines the aerodynamic drag acting on the vehicle
Cd = 0.698;
Af = 8.325;
p = 1.225;

Fa = 0.5*p*Cd*Af.*(velocity); 
end

