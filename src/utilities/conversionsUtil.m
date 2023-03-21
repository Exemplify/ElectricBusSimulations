convert.kgfm2nm = @(kgfm)kgfm.*9.80665; 
convert.nm2kgfm = @(nm)nm.*(1/9.80665);
convert.rad2rpm = @(rad)rad.*9.549296585513721;
convert.rpm2rads = @(rpm)rpm.*(1./9.549296585513721);
convert.rad2vel = @(r,R)r.*R;
convert.vel2rad = @(v,R)v./R;
convert.ms2kmh = @(ms)ms.*(3.6);
convert.kmh2ms = @(kmh)kmh./(3.6);
convert.torque2force = @(t,R)t./R;
convert.force2torque = @(f,R)f.*R;
convert.rpm2vel = @(rpm, R)convert.rad2vel(convert.rpm2rads(rpm), R);
convert.vel2rpm = @(ms, R)convert.rad2rpm(convert.vel2rad(ms, R));
convert.rpm2kmh = @(rpm, R) convert.ms2kmh(convert.rpm2vel(rpm, R));
convert.kmh2rpm = @(kmh, R) convert.vel2rpm(convert.kmh2ms(kmh),R);

