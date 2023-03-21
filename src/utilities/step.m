function [u] = step(t,shift)


if(nargin == 1)
    shift = 0;
end 

u = ones(size(t));
u(t<shift) = 0;
u(t==shift) = 0.5;
end

