% MATLAB Lab #2 Part 2
% <first Initial>.<Last Name>
% <Date of creation>
% <Name of program>
% <Description of program>

clear; % Clears the command window
clc; % Clears the workspace
close; % Closes any figures

% Imports some compression data
B = load('BridgeData.txt');
% eliminate extraneous noise
B(:,3)=smoothdata(B(:,2));
plot(B(:,1),B(:,2),B(:,1),B(:,3));
% Trim unnecessary information
% Identify performance metrics
% Plot the updated data
% Print performance metrics