function Location = importGps(filename, dataLines)
%IMPORTFILE Import data from a text file
%  LOCATION = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  LOCATION = IMPORTFILE(FILE, DATALINES) reads data for the specified
%  row interval(s) of text file FILENAME. Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  Location = importfile("C:\Users\mbrit001\Documents\Timothy\masters\gps Investigation\gps-data\DGBraamCirc2-2021-12-22_11-45-35\Location.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 25-Jan-2022 17:35:11

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 11);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["time", "seconds_elapsed", "bearingAccuracy", "speedAccuracy", "verticalAccuracy", "horizontalAccuracy", "speed", "bearing", "altitude", "longitude", "latitude"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
Location = readtable(filename, opts);

end