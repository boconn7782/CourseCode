% MATLAB Lab #2 Part 2
% <first Initial>.<Last Name>
% <Date of creation>
% <Name of program>
% <Description of program>

clear; % Clears the command window
clc; % Clears the workspace
close; % Closes any figures

%% Imports some compression data
B = load('BridgeData.txt');
plot(B(:,1),B(:,2)

%% eliminate extraneous noise
B(:,3) = smoothdata(B(:,2)); % Creates a force column
% Plot position vs raw force( Col 1 vs col 2) 
% and Position vs calculated load (col 1 vs col 3)
% plot(B(:,1),B(:,2), B(:,1),B(:,3));

%% Trim unnecessary information
% < Determine the Max load >
% < Determine at what point from the beginning where the load exceeds 1% the max >
% i = 1;
% WHILE smoothed data point <  1% of Max
%     i = i + 1;
% ENDWHILE
% < Determine at what point after the dataset drops below 1% the max again >
% j = length of dataset;
% WHILE smoothed data point <  1% of Max
%     j = j - 1;
% ENDWHILE
% < Use those locations to trim the dataset >
% < Convert piston position to bridge deflection >


%% Identify performance metrics
% < M = Strength (Max Load) >
% < Deflection @ Max Load >
% < Deflection @ Break >
% < Toughness >


%% Plot the updated data


% Print performance metrics
