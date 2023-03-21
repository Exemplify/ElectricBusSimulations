function [max_temp_day,min_temp_day] = detemineTempDays(hourly_temp, hourRange)
%DETEMINETEMPDAYS determines the hottest and coldest days for the given
%year of temperature data.

start_hour = hourRange(1);
end_hour = hourRange(2);

in_range = (hour(hourly_temp.Time) >= start_hour) & (hour(hourly_temp.Time) <= end_hour);
hourly_temp_in_range = hourly_temp(in_range, :);
daily_temp_in_range = retime(hourly_temp_in_range, 'daily', 'mean');


[~, max_temp_idx] = max(daily_temp_in_range.Temp);
[~, min_temp_idx] = min(daily_temp_in_range.Temp);

max_temp_day = daily_temp_in_range(max_temp_idx,:); 
min_temp_day = daily_temp_in_range(min_temp_idx,:);
end

