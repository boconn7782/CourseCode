% MATLAB Lab #3 Part
% <first Initial>.<Last Name>
% <Date of creation>
% Bridge Data Analysis - Cont'd
% <Description of program>

clear;  % Clears the command window
clc;    % Clears the workspace
close;  % Closes any figures


% Imports some compression data
B = load('BridgeData.txt');


% eliminate extraneous noise
[R,C]=size(B); % Get size of dataset, use 5% for window
B(:,3)=smoothdata(B(:,2),'gaussian',.05*R);
% plot(B(:,1),B(:,2),B(:,1),B(:,3)); %Plots raw and smooth data


% Trim unnecessary information
M=.01*max(B(:,3)); % Identify 1% of the max load, use for threshold
%   Look for threshold break from front and back
i = 1;
while B(i,3) <  M
    i = i + 1;
end

j = length(B);
while B(j,3) <  M
    j = j - 1;
end

B2 = B(i:j,:); % Trim to rows i through j
< Convert piston position to bridge deflection >
plot(B2(:,1),B2(:,2),B2(:,1),B2(:,3)); % Plots trimmed data


% Identify performance metrics
% Plot the updated data
xlabel('Deflection(in)');
ylabel('Load(lbf)');
legend('Raw Data','Smoothed Data');
title('Displacement vs Load: Compression Test Results');

% Print performance metrics


