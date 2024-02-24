% Programming 7 Pre-lab 1
% <First Initial>.<Last Name>
% <Date of creation>
% Sending Data to Arduino
% Converts audio data to light level and 
% sends that data to an Arduino to set 
% the intensity levels of an LED
% 

% Clean Up Commands
clc;
clear;
close;

%% Initialize Serial Communication with Arduino
% Retrieve a list of available serial devices
X =  ;
% Select the last device, your Arduino is typically the last device connected
P = ;
% If this doesn't work for you, refer to the debugging section for a solution
% Open up a serial connection to the Arduino over that port
ArduinoObj = ;

%% Create an Audio Object
% This is purely for demo purposes, to make the example more interesting
% This portion is a little complex and not directly related to serial communication. 
% It's just to set up the demo elements of this. 

% Set up an audioplayer object to play some music
load handel % This is a built-in audio file in MATLAB. 
% You can replace it with your own if you like -
% https://www.mathworks.com/help/matlab/ref/audioread.html
% [y,Fs] = audioread(Your Audio File);
disp("Audio Loaded")
%% Convert audio sample levels to representative values from 0 to 255
% Load audio information into an audioplayer object
playerObj = audioplayer(y,Fs); 
% Create a smoothed, unsigned representation of the audio levels
g = smoothdata(abs(y),"gaussian",1000); 
% Currently the representative values range from about 0.04 to .27
% Convert to a desired output range of 0-255
h = interp1([min(g),max(g)],[0,255],g); % Maps from min-max to 0-255
h = round(h); % Rounds all values to the nearest integer

pause(2); % A short pause before playing the music
play(playerObj);

PVal = 250; % Time between serial coms
 

while(isplaying(playerObj)) % Checks if playback is still occuring
    %% Retrieve current audio sample
    cs = get(playerObj,'CurrentSample'); % Identifies the index of current sample being played from y, the audio samples array
    %% Retrieve corresponding representative value from 0 to 255
    L = h(cs); % Retrieves corresponding sample from representative levels based on the index retrieved
    %% Create command for receiver Arduino using that representative value
    % Need to create a command that is a string, starts with the agreed 
    % upon identifier character, and includes the data we want sent.
    M =   ; 
    %% Send command to Arduino
      ; % Write data to the serial object

    pause(PVal/1000); % A short pause keeps the Arduino buffer from getting overloaded
end

% This is just to ensure the last data point sent turns off the LED
writeline(ArduinoObj,"a0"); 

% The same way that MATLAB can't access the Arduino if the Arduino IDE is running, 
% the Arduino IDE can't access it if MATLAB is connected. 
% Running clear breaks the connection once you're done. 
clear ArduinoObj; 



