% Clean up commands
clc;
clear;
close;


%% Connect to the Arduino
% Retrieve a list of available serial devices
X = serialportlist;
% Select the last device, Your Arduino is typically the last device
% connected
P = X(end);
% If this doesn't work for you, refer to the debugging section for a solution
% Open up a serial connection to the Arduino over that port
ArduinoObj = serialport(P,9600);

%% Create User interface objects - Gauge and Button 
% We are creating these to have a visually 
% reaction to the Arduino data and to help
% end our script when we're done. 
% Create gauge to showcase the Potentiometer data
fig = uifigure;

% Creating a UI Button to end the script
B1 = uibutton(fig, ... % Creates the button
    "state",... % Specify it's style
    "Text","Check Arduino",... % Set the text
    "Position",[200 300 100 50]); % Set its position

L1 = uilabel(fig, ...
    "Text", ['Arduino has been running' newline 'for X ms'],...
    "HorizontalAlignment",'center',...
    "Position",[100 200 300 50]); % Set its position

% Creating a UI Button to end the script
B2 = uibutton(fig, ... % Creates the button
    "state",... % Specify it's style
    "Text","End Script",... % Set the text
    "Position",[200 100 100 50]); % Set its position




while(1) % Starts an endless loop

    %% Retrieve latest message from Serial Port
    % The arduino is set up to constantly send the potentiometer 
    % postion to the serial monitor so we'll need to deal with this.
    if B1.Value == 1
        % Clear the serial port buffer
        flush(ArduinoObj);  
        % Now read the latest line written to the serial monitor
        ArdMsg = readline(ArduinoObj); 
        % The command will wait 10 seconds before timing out so your 
        % Arduino has that long to send another line of data.
        i = str2num(ArdMsg);
        X = sprintf('Arduino has been running\nfor %i ms', i);
        L1.Text = X;
        B1.Value = 0; % Unclick the button
    end

    pause(.1); % Slow down to make output readable

    %% Check button to determine if script should end
    if B2.Value == 1
        break; % Breaks the loop
    end
end

%% Clean up the remnants of the script

% Close the Arduino Object so it's now accessible
clear ArduinoObj;

% Closes the UI window (FYI, This is a brute force approach, 
% not how you're normally supposed to do this.)
close all force;
