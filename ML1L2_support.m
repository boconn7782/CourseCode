% MATLAB Lab #1 Part 2 Support
% B.O'Connell
% 2021-09-15
% Weather Downloader 
% This program will provide N days of weather data
% from a NOAA weather station, specifically the 
% Mt. Washington weather station based on a 
% user inputted date, D, and number of days, N. 

clear;  % Clears the command window
clc;    % Clears the workspace
close;  % Closes any figures

% Give user information about the program
fprintf(...
    ['This program will provide weather data from\n'...
    ,'a NOAA weather station based on a user inputted\n'...
    ,'date and number of days.'...
    ,'Enter the date in the format of\n'...
    ,'year-month-day (ex: 1990-06-01 ).\n']);
% This could have been done using disp() but
% using arrays of text [] and MATLAB's line break (...)
% with fprintf is a good technique for printing a lot 
% of text to the command window and splitting it 
% across multiple lines.

% Ask for start date for the weather data
D = input('Enter a date: ','s');
N = input('Enter number of days: ');

% Prepare and format all information as required to use
% the GHCN (Global Historical Climatology Network)
% https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt
dataset =  'daily-summaries';
station = 'USW00014755'; % Mt. Washington station ID
% For more information on this weather station:
% https://www.ncdc.noaa.gov/cdo-web/datasets/GHCND/stations/GHCND:USW00014755/detail
startDate = char(datetime(D,'InputFormat','yyyy-MM-dd','Format','y-MM-dd'));
endDate =   char(datetime(D,'InputFormat','yyyy-MM-dd','Format','y-MM-dd')+(N-1));
dataTypes = 'TMAX,TMIN,AWND,FMTM,TAVG';
format =    'csv'; 
base = 'https://www.ncei.noaa.gov/access/services/data/v1?dataset=';
call = strcat(base,dataset,'&dataTypes=',dataTypes,...
    '&stations=',station,'&startDate=',startDate,...
    '&endDate=',endDate,'&format=',format);
% Make a request of the GHCN and store the returned data
Data = webread(call);

% Break the data into usable arrays
DT = Data.('DATE'); 
% Wind provided in 10ths of meters per second
WD = (Data.('AWND')*.1)*(1000/(60*60)); % Converted to kph
% Temperature provided 10ths of degrees C
LT = (Data.('TMIN')*.1); % Converted to deg C
HT = (Data.('TMAX')*.1); % Converted to deg C
TA = (Data.('TAVG')*.1); % Converted to deg C

% plot data (poorly)
plot(DT, WD, DT, LT, DT, HT, DT, TA);
legend('Winds','Low','High');




