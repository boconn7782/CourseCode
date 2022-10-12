% MATLAB Lab #3 Part 1
% <First Initial>.<Last Name>
% <Name of Script>
% <Description of what the program will do.> 

clc;clear;

% Connect to the Human Reaction Experiment Module
X = serialportlist; % Lists the available ports
P = X(end); % Takes the last value on list, the sensor
E = <Your email address>;
A = HumanReaction(P,E);

% Get participant demographics
A.HRdemographics();

% Set experiment settings
A.HRexpsettings(0,'r'); % default to no noise for now. Enter your dominant hand.

% Run a single experiment
A.HRrun();

% Accept the datapoint
A.HRdatapoint('Y');

% Upload the datapoint
A.HRupload();
