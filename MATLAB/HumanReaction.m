classdef HumanReaction < handle
    % Custom class for use with the Human Reaction experiment in
    % Prof. O'Connell's Cornerstone of Engineering course.
    % This is part of a suite of technologies and associated
    % curriculum developed as part of a Northeastern University
    % 2021 MATLAB Curriculum Grant. 
    % 
    % The human reaction experiment is based on a famous, in their own circles,
    % discrete motor response experiments that tested human reaction by having 
    % them hold a probe and complete circuits based on visual inputs. This version 
    % uses the same experimental procedure but capactive touch sensors to sense 
    % reaction times instead. It uses the Adafruit CAP1188 8-key capactive touch
    % sensor breakout board with copper tape touch pads. 
    %
    % Fitts, Paul M., and James R. Peterson. "Information capacity of discrete 
    % motor responses." Journal of experimental psychology 67, no. 2 (1964): 103.
    % 
    % A = HumanReaction(P,E) creates an object A that represents the human
    % reaction time module. 
    % P is the port, best identified and set using:
    %    X = serialportlist; % Lists the available ports
    %    P = X(end); % Takes the last value on list, the sensor
    % E is a string of the student email address, used to record contributions
    % to the course database. The resulting object communicates with the
    % Arduino. The experiment is controlled by the Arduino but the object
    % initates an instance of the experiment and receives for the reaction
    % time data. It also manages the experimental subject data. 
    % 
    % Last updated: 2022-09-24
    %%

    % Assign properties that will be used to connect to Arduino
    properties
        PortName    % Serial Port connected to UV Sensor
        StudentID   % Unique student ID for data upload tracking
        SubjectID   % Unique ID for the experiment participant
        SubjAge     % Participants's Age
        SubjMjr     % Participant's Major
        SubjHnd     % Participant's Handedness
        ReacTime    % Reaction Time
        FMTime      % Movement Time to any button
        MoveTime    % Movement Time to correct button
        RetTime     % Return Time
        BtnCrct     % Intended Button, randomly selected by experiment
        FirstBtn    % Button Participant presses first
        BtnData     % Record of all button presses during attempt
        NoiseInd    % Indicator of if noise was used or not
        ExpHand     % Indicator if dominant hand was used or not
        timestamp   % Time of data collection
        datapoint   % Datapoint for upload to Course Database
    end

    properties (Access = private)
        Device      % Serial Connection to Human Reaction Module
    end

    %% Create methods that allows for functions/operations in class
    methods
        %% Creates the Human Reaction Module Object
        function obj = HumanReaction(port,NUEmail)
            % Creates an object to handle communication with the 
            % Human Reaction Module and database. Also handles all
            % experimental data. 
            %
            % See class level comments for details on creating the object.
            %

            if nargin == 2
                % Record the Student ID information
                obj.StudentID = NUEmail;
                % Specify baud rate and port
                baud = 38400;
                obj.PortName = port;
                
                % Connect to serial port at baud rate 38400, high baud rate
                % required by the capactive touch sensor
                disp("Creating device")
                obj.Device = serialport(obj.PortName,baud);
                % Define read and write terminator
                configureTerminator(obj.Device,"LF");
                flush(obj.Device);
                pause(1);
                % Output data and the sample number in a struct
                obj.Device.UserData = struct("Data",[],"Count",1);
                pause(1);
            else
                disp("Missing arguments");
            end
        end

        %% Collect Demographic data of the experiment participant
        function obj = HRdemographics(obj)
            % Collects the required demographic information of the
            % experiment participant. Data collected is:
            %   - A unique identifier, to be self selected by participant
            %   - Participant's Age
            %   - Participant's Major
            %   - Participant's Handedness
            %
            % A.HRSubjectDemo() will update the participant demographic 
            % data of the object. It prompts the subject to input this
            % information into the command window. 
            %
            disp("Please enter the following information about the participant: ");
            % Ask participant for a unique identifier
            disp("Select a unique identifier for the participant.");
            disp("Please use one that is memorable and easily repeated. This will enable ");
            disp("easier comparison of data if multiple attempts are made. ")
            SI = input("Participant ID: ","s");
            SI = strrep(SI, ' ', '');  % Remove unnecessary spaces from the ID
            obj.SubjectID = string(lower(SI)); % Update ID for the Participant
            
            % Ask user for their age
            SA = input("Participant's Age: ");
            obj.SubjAge = SA;     % Participant's Age
            
            % Ask User for their major
            SM = input("Participant's Major: ","s");
            obj.SubjMjr = string(lower(SM)); % Participant's Major
            
            % Ask user for their handedness
            disp("Please indicate your handedness. ");
            disp("If you are mixed handed, indicate which you hand is");
            disp("your preferred for this experiment.");
            disp("'r' for right handed, 'l' for left handed, 'a' for ambidexterous");
            % Enter into a loop until valid response
            while 1
                SH = input("Participant's Handedness:","s");
                % Check validity
                if SH == 'r' || SH == 'l' || SH == 'a'
                    break;
                else
                    disp("Invalid input. Please answer again.");
                end
            end
            obj.SubjHnd = string(lower(SH));
        end

        %% Sets the criteria for the next run of the experiment
        function obj = HRexpsettings(obj, N, H)
            % Sets option flags for the experimental settings.
            % From a functional standpoint, the experiment can be 
            % run with the participant waiting for an audio and 
            % visual notification or just a visual notification. 
            % The participant can be asked to use their dominant or
            % non-dominant hand. 
            %
            % A.HRexpsettings(N,H) will update the noise indicator(N) 
            % and participant hand (H) properties. N must be either a 
            % 0 or 1, to indicate whether that option is off or on. 
            % H must be either 'L' (left) or 'R' (right) to indicate
            % what hand the participant is using for this run
            % of the experiment. 
            %

            obj.ExpHand = string(lower(H));
            obj.NoiseInd = N;
            
        end


        %% Debugging Functions

        % Listens to the output feed
        function feed = HRlisten(obj)
            % Listens to the output feed of the 
            disp("Touch to see readouts for 10 sec. ");
            tic
            flush(obj.Device);
            feed = [];
            while toc < 10
                % Read data from module
                data = readline(obj.Device);
                disp(data)
                feed = strcat(feed,",",data);
            end
        end
        
        % Manually writes a character to the module
        function HRwrite(obj,X)
            % Send a character to Module
            % Center light currently always on, hardcoded on Arduino
            % Will be updated to MATLAB controllable in V2.
            % '1', '2', '3', or '4' for pad select
            % 'c' to turn on pad light
            % 'd' for pad light off
            writeline(obj.Device, X);
        end



        %% Initiates an experimental run
        function obj = HRrun(obj, randside)
            % Initiates a run of the experiment. 
            %
            % A.HRrun() will start a run of the experiment. It provides
            % instruction for the participant on when to begin,
            % communicating with the Arduino to initiate the experimental
            % process and listens for the reaction time data returned from
            % the Human Reaction Module. 
            % Participant performance data gets stored in the object itself, 
            % defaulting to the last run. 
            %
            % If a value of 1 to 4 is provided as an input, that overrides
            % the randomized selection process and specifies the pad that
            % will be selected based on that input. 

            flush(obj.Device);
            writeline(obj.Device, 'd');

%             
%             disp("Press any key to start...")
%             pause
            disp("trial about to begin.");
            disp("Please do not touch module until instructed");
            pause(1);
            disp("Preparing module...")
            
            flush(obj.Device); % Clear serial buffer
            
            if nargin == 1 
                % No given value for pad so
                % Randomly select target pad
                randside = randi(4);
            else 
                % Check if given value valid
                if ~ismember(randside,1:4)
                    % Randomly select target pad
                    randside = randi(4);
                end
            end


            %% Experiment State: Waiting for participant
            startButton = inf;
            % Ask the student to place finger on start
            disp('Place your finger on the Center Pad');
            % Wait until Module senses Participant
            while startButton ~= 0
                % Read data from module
                data = readline(obj.Device);
                % Split data based on the commas
                strdat = split(data,',');
                % Check to see  if it is the Start button
                startButton = str2double(strdat(1));
            end
            % Record button history starting with touching the center pad
            buttonData = data + "," ;
            disp('Ready...');

            %% Experiment State: Waiting for Cue
            flush(obj.Device);
            pause(1);
            % Tell module which light turn on
            writeline(obj.Device, string(randside));
            flush(obj.Device);

            
            % Set random time between 2 and 5 seconds before cue
            duration = round(2 + (5-2).*rand(1),2);

            % If noise prompt on
            if obj.NoiseInd == 1
                % Start noise for a certain amount of time/ wait two seconds
                amp=10;
                fs=20500;  % sampling frequency
                freq=100;
                values=0:1/fs:duration;
                s=amp*sin(2*pi* freq*values);
                sound(s,fs);
            end

            % Pause for the a random amount of time before cue
            pause(duration); 
            % This isn't perfectly timed. May be off by <15 milliseconds 
            % but that works well enough for human reaction

            % Send cue to Module, light will turn on
            writeline(obj.Device, 'c');

            %% Experiment State: Reaction Time
            % Time until the start button is released
            RstartButton = inf;
            while RstartButton ~= 0
                % Read data from arduino
                data = readline(obj.Device);
                % Split data based on the commas
                strdat = split(data,',');
                % Check to see  if it is the Start button
                if strdat(2) == " released"
                    RstartButton = str2double(strdat(1));
                end
            end
            buttonData = buttonData + data + "," ;
            % Record the time the light turns on
            lightTime = str2double(strdat(5));
            % Record the a time start button was released
            RstartTime = str2double(strdat(3));


            %% Experiment State: Movement
            % Determining time to touch another button and time to return
            % to the center pad. Correct button is not 
            buttonPressed = inf;
            correctButton = randside;
            firstButton = inf;
            firstTime = inf;
            touchTime = inf;
            returnTime = inf;

            % Movement Phase
            while buttonPressed ~= correctButton
                % Read data from arduino
                data = readline(obj.Device);
                % Store raw data
                buttonData = buttonData + data + "," ;

                % Parse the button info
                % Split data based on the commas
                strdat = split(data,',');
                % Parse button pressed
                buttonPressed = str2double(strdat(1));
                % Parse button state - released or touched
                buttonState = strdat(2);
                % Parse timestamp
                buttonTime = str2double(strdat(3));

                % Determine first button touched (Not necessarily the
                % correct one) - Should only run first time
                if firstButton == inf && strcmpi(buttonState," touched")
                    % Record first button pressed
                    firstButton = buttonPressed;
                    % Record first button touched timestamp
                    firstTime = buttonTime;
                end

                % Look for correct Button Press
                if buttonPressed == correctButton && strcmpi(buttonState," touched")
                    % Record correct button touched timestamp
                    touchTime = buttonTime;
                    % Send arduino to have light go off
                     writeline(obj.Device, 'd');
                     % Break this loop 
                     break;
                end

            end

            %% Experiment State: Return
            while returnTime == inf
                % Read data from arduino
                data = readline(obj.Device);
                % Store raw data
                buttonData = buttonData + data + "," ;

                % Parse the button info
                % Split data based on the commas
                strdat = split(data,',');
                % Parse button pressed
                buttonPressed = str2double(strdat(1));
                % Parse button state - released or touched
                buttonState = strdat(2);
                % Parse timestamp
                buttonTime = str2double(strdat(3));

                % Look for Center Button Press
                if buttonPressed == 0 && strcmpi(buttonState," touched")
                    % Record correct button touched timestamp
                    returnTime = buttonTime;
                end
            end
            disp('Trial complete. Please remove finger.');


            obj.BtnCrct = randside;  % Correct Pad
            obj.FirstBtn = firstButton; % First pad touched
            obj.ReacTime = RstartTime - lightTime;   % Reaction Time
            obj.MoveTime = touchTime - RstartTime;   % Movement Time to correct button
            obj.FMTime   = firstTime - RstartTime;   % Movement Time to any button
            obj.RetTime  = returnTime - touchTime;   % Return Time
            obj.BtnData = buttonData;   % record of button touches
            obj.timestamp = datetime;
            flush(obj.Device);
            pause(1);
            % Send arduino to have light go off
            writeline(obj.Device, 'd');
            % pause(1);

        end

        %% Check current Data Point
        function obj = HRdatapoint(obj,C)
            % Set up and review single data point to be exported to database
            %
            % A.HRdatapoint() organizes the object(A) properties into a form
            % for upload to the database. It displays it the organized
            % datapoint to the user and asks whether or not to accept that
            % datapoint. If accepted, the organized datapoint is saved in
            % preparation for uploading to the database. If not, that
            % property is cleared.
            % If given an initial input, C, then the datapoint
            % is automatically accepted or rejected. 
            % A.HRdatapoint('Y') approves the data and generates the datapoint
            % A.HRdatapoint('N') rejects the data and clears the datapoint

            if nargin == 1
                % Organize data for user display:
                % Participant data
                PD = table(obj.SubjectID, obj.SubjAge, obj.SubjMjr, obj.SubjHnd, ...
                    'VariableNames',{'ID', 'Age', 'Major','Handedness'});
                disp("Participant Information:");
                disp(PD);

                % Experiment Settings
                ES = table(obj.NoiseInd, obj.ExpHand, ...
                    'VariableNames',{'Noise On/Off','Hand Used'});
                disp("Experiment Settings:");
                disp(ES);

                % Experiment results
                ED = table(...
                    obj.ReacTime, obj.FMTime, obj.MoveTime, obj.RetTime, ...
                    obj.BtnCrct, obj.FirstBtn,...
                    'VariableNames',{...
                    'Reaction Time','Time to First Touch','Movement Time','Return Time',...
                    'Correct Pad','Pad First Touched'});
                disp("Experiment Results:");
                disp(ED);
                C = input("Accept datapoint? Y or N","s");
            end


            if strcmp(C,'Y')
                % Update the button log for transfer
                BD = string(replace(char(obj.BtnData),char(13),' '));


                obj.datapoint = table(string(obj.StudentID), ...
                string(obj.SubjectID), obj.SubjAge, string(obj.SubjMjr),...
                string(obj.SubjHnd), ...
                obj.ReacTime, obj.FMTime, obj.MoveTime, obj.RetTime, ...
                obj.FirstBtn, obj.BtnCrct, obj.NoiseInd,...
                string(obj.ExpHand), BD, ...
                'VariableNames',{'StudentID',...
                'SubjectID', 'SubjAge', 'SubjMjr','SubjHnd',...
                'ReacTime','FMTime','MoveTime','RetTime',...
                'FirstBtn','BtnCrct','NoiseInd','ExpHand','BtnData'});
            else
                obj.datapoint = [];
            end


        end



        % Upload data point
        function HRupload(obj)
            % Uploads datapoint to the course database
            %
            % A.HRupload() opens a connection to the database. If
            % successful and there is an accepted datapoint in the
            % object(A), that datapoint is uploaded to the database and
            % then cleared from the datapoint.
            %

            if isempty(obj.datapoint)
                disp("Use HRdatapoint() first to confirm the datapoint before upload.")
            else
                % Make connection to database
                conn = MLDBConn;
                % Test connection (empty brackets = successful connection)
                if isempty(conn.Message)
                    % Append to existing table (HR table created in test database)
                    sqlwrite(conn,'HR2022',obj.datapoint);
                    close(conn);
                    obj.datapoint = [];
                    disp("Upload successful. Datapoint cleared.")
                else
                    disp("Database connection error")
                end
            end
        end

    end

    methods (Static)

        % Retrieve course dataset
        function DS = HRdata()
            % Retrieves full course dataset of Human Reaction module data
            %
            % X = ReactionTime.HRdata() will download a dataset containing 
            % all of the datapoints collected using the Human Reaction modules 
            % by Northeastern University students. These are returned as in
            % the format of a 'Table' which is a matrix of mixed data
            % columns. Those columns are as follows:
            % year, month, day, hour, UVA level, UVB level, UV Index,
            % latitude, longitude, sampling frequency(Hz), # of Samples
            %

            % Establish database connection
            conn = MLDBConn;
            % Test connection (empty brackets = successful connection)
            if isempty(conn.Message)
                query = 'SELECT SubjectID, SubjAge, SubjMjr, SubjHnd, ReacTime, FMTime, MoveTime, RetTime, FirstBtn, BtnCrct, ExpHand FROM test.HR2022';
                % Execute query and fetch results
                DS = fetch(conn,query);
                close(conn);
            else
                disp("Database connection error")
            end
        end


 
         % Runs a demo the uses the Human Reaction data
         function HRDemo()
             % In development...
             rawdata = HumanReaction.HRdata;
             RecTs = table2array(rawdata(:,"ReacTime"));
             MovTs = table2array(rawdata(:,"MoveTime"));
             RetTs = table2array(rawdata(:,"RetTime"));
             plot(RecTs,MovTs,'o',RecTs,RetTs,'.');
         end
    end


end
