

% witstemp2022.TimestampUTC0 = witstemp2022.TimestampUTC0;
% witstemp2022.Properties.VariableNames = ["Time", "Temp"];

%% 
import2021TempData;
witstemp2021.TimestampUTC0 = witstemp2021.TimestampUTC0 +hours(2);
witstemp2021.Properties.VariableNames = ["Time", "Temp"];

%%
witstempTT = timetable(witstemp2021.Time, witstemp2021.Temp, 'VariableNames', {'Temp'});
start_date = datetime(2021, 1, 1, 0, 0, 0);
end_date = datetime(2021, 12, 31, 23, 59, 0);
date_range = start_date: minutes(1):end_date;
%%
minute_temp = retime(witstempTT, date_range , 'linear' );
hourly_temp = retime(minute_temp, 'hourly', 'mean');
daily_temp = retime(minute_temp, 'daily', 'mean');

save("data/wits_temp_2021.mat", "minute_temp", "daily_temp", "hourly_temp")