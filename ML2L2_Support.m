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


%% eliminate extraneous noise
[R,C] = size(B);
B(:,3) = smoothdata(B(:,2),'Gaussian',.03*R); % Creates a force column
% Plot position vs raw force( Col 1 vs col 2) and Position vs calculated load (col 1 vs col 3)
plot(B(:,1),B(:,2), B(:,1),B(:,3));

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
% < Toughness - Perform a Reimann's Sum>
%   Add 4th column to dataset to track Change in Energy 
%   FOR each row(i) in dataset
%       Change in energy(i) = (Defl. - Last Defl.)((Load + Last Load)/2)
%   ENDFOR
%   Toughness = Sum of the Change in Energy column

%% Plot the updated data


% Print performance metrics
