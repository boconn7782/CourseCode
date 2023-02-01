% MATLAB Lab #1 - In Class Debugging Excercise
% <First Initial>.<Last Name>
% <Date of creation>
% NU: Fall Enrollment Statistics
% Calculates and displays Fall Enrollment
% stats from 2016 to 2021

clear;
close;
clc;

% Load total values for Fall Enrollment Statistics
Years = [ 2020, 2019, 2018, 2017, 2016, 2021 ];
Applicants = [64459, 62263, 62272, 54209, 51063, 75244];
Admitted = [13199, 11240, 12042, 14876, 14747, 13829];
Enrolled = [3128, 2996, 2746, 3108, 2676, 4504 ];

% Calculate Percent based on total applicants
PerAdmit = admitted./Applicants*100;
PerAttend = Enrolled/Applicants*100;

% Plot to show year to year trend
plot(Years, PerAdmit, Years, PerAttend);
xticks([2016:2021]);
xlabel('Year');
ylabel('Percent (%)');
title(Northeastern University: Fall Enrollment Statistics);
legend('Percent Enrolled','Percent Admitted');