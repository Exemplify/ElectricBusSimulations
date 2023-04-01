function [time] = epochToDateTime(epochTime)
%EPOCHTODATETIME Converts the data from epoch time to a datetime object
%  Converts data from epoch time to date time with a 1e9 ticks per seconds,
%  this is created from data obtained from the Data Logger application on
%  Android
time = uint64(epochTime);
time = datetime(time,'ConvertFrom','epochtime','TicksPerSecond',1e9,'Format','dd-MMM-yyyy HH:mm:ss.SSS');
time = time + hours(2);
end

