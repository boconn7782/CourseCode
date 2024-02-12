% Programming Lab 5 Homework 1 Support
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


% Introduction telling the user what the script does and what to do
fprintf(...
    ['This program will provide weather data from\n'...
    ,'a NOAA weather station based on a user inputted\n'...
    ,'number of days and a start date of 2007-08-01.'...
    ,'Enter the number of days when prompted.\n']);
% This could have been done using disp(), BUT
% I did it using arrays of text [] and MATLAB's code line break (...), 
% which allows code to continue on a new line, with fprintf to 
% showcase a good technique for printing a lot of formatted text to 
% the command window while splitting the actual script across multiple lines
% to make it easier for the programmer to read and interpret. 



% Establish Time period based on start date and User input for # of days
D = '2007-08-01'; % Date must be in year-month-day and formatted as a character array
N = input('Enter number of days: ');



% Connect with GHCN and download raw data
% Prepare and format all information as required to use
% the GHCN (Global Historical Climatology Network)
% https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt
dataset =  'daily-summaries';
station = 'USW00014755'; % Mt. Washington station ID
% For more information on this weather station:
% https://www.ncdc.noaa.gov/cdo-web/datasets/GHCND/stations/GHCND:USW00014755/detail
startDate = char(datetime(D,'InputFormat','yyyy-MM-dd','Format','y-MM-dd'));
endDate =   char(datetime(D,'InputFormat','yyyy-MM-dd','Format','y-MM-dd')+(N-1));
dataTypes = 'TMAX,TMIN,AWND';
format =    'csv'; 
base = 'https://www.ncei.noaa.gov/access/services/data/v1?dataset=';
call = strcat(base,dataset,'&dataTypes=',dataTypes,...
    '&stations=',station,'&startDate=',startDate,...
    '&endDate=',endDate,'&format=',format);
% Make a request of the GHCN and store the returned data
Data = webread(call);



% Break out the data needed: 
% Dates(DT), wind speeds(WD), low temperatures(LT), and high temperatures(HT)
DT = Data.('DATE'); 
% Wind provided in 10ths of meters per second
WD = (Data.('AWND')*.1)*(1000/(60*60)); % Converted to kph
% Temperature provided 10ths of degrees C
LT = (Data.('TMIN')*.1); % Converted to deg C
HT = (Data.('TMAX')*.1); % Converted to deg C



% plot data (poorly)
plot(DT, WD, DT, LT, DT, HT);




