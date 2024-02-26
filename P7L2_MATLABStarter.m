% Programming 7 Pre-lab 2
% <First Initial>.<Last Name>
% <Date of creation>
% Recieving Data from Arduino
% Listens over the serial port for formatted 
% messages from the Arduino containing potentiometer
% readings and then sets a ui gauge based on them
% 


% Clean up commands
clc;
clear;
close;


%% Connect to the Arduino
% Retrieve a list of available serial devices
  ;
% Select the last device, Your Arduino is typically the last device
% connected
  ;
% If this doesn't work for you, refer to the debugging section for a solution
% Open up a serial connection to the Arduino over that port
ArduinoObj =   ;

%% Create User interface objects - Gauge and Button 
% We are creating these to have a visually 
% reaction to the Arduino data and to help
% end our script when we're done. 
% Create gauge to showcase the Potentiometer data
fig = uifigure;
g = uigauge(fig,... % Creates the figure
    'ScaleColors',{'yellow','red'},... % and adds some fun elements
    'ScaleColorLimits', [60 80; 80 100]);
g.Value = 45; % gives it an inital value

% Creating a UI Button to end the script
b = uibutton(fig, ... % Creates the button
    "state",... % Specify it's style
    "Text","End Script",... % Set the text
    "Position",[300 100 100 50]); % Set its position



while(1) % Starts an endless loop

    %% Retrieve latest message from Serial Port
    % The arduino is set up to constantly send the potentiometer 
    % postion to the serial monitor so we'll need to deal with this.

    % Clear the serial port buffer
       ;  
    % Now read the latest line written to the serial monitor
    ArdMsg =   ; 
    % The command will wait 60 seconds before timing out so your 
    % Arduino has that long to send another line of data.

    %% IF message contains our identifier characters THEN
    if   
        %% Parse message for the sensor data
        % Search string for identifier
        PotVal =    ;
        %% Set Gauge Value based on that Data
        g.Value = PotVal; 
    end

    pause(.1); % Slow down to make output readable

    %% Check button to determine if script should end
    if b.Value == 1
        break; % Breaks the loop
    end
end
