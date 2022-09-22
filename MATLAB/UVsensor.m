classdef UVsensor < handle
    %% Custom class for use with the UV sensor experiment in
    % Prof. O'Connell's Cornerstone of Engineering course.
    % This is part of a suite of technologies and associated
    % curriculum developed as part of a Northeastern University
    % 2021 MATLAB Curriculum Grant. The sensor is a SparkFun XXXXXX
    % and returns the level of UVA and UVB radiation and
    % a calculated UV index.
    %
    % A = UVsensor(P,E) creates an object A that reads the sensor data
    % from the UV sensor module.
    % P is the port, best identified and set using:
    %    X = serialportlist; % Lists the available ports
    %    P = X(end); % Takes the last value on list, the sensor
    % E is a string of the student email address, used to record contributions
    % to the course database. The resulting object communicates with the Arduino
    % and UV sensor using the serial connection over the USB. It requests and
    % listens to a data feed based on the provided sample rate and number
    % of samples. The recorded datapoint for the UVA, UVB, and UV index are
    % based on the means of those values.
    % 
    % Last updated: 2022-09-22
    %%

    % Assign properties that will be used to connect to Arduino
    properties
        PortName    % Serial Port connected to UV Sensor
        StudentID   % Unique student ID for data upload tracking
        UVA         % UVA level as determined by SparkFun sensor
        UVB         % UVB level as determined by SparkFun sensor
        UVindex     % UV index as determined by SparkFun sensor
        Latitude    % Latitude - From MATLAB mobile or manual entry, default: 42.3398
        Longitude   % Longitude - From MATLAB mobile or manual entry, default: -71.0892
        SampleRate  % Sample rate in hertz - default: 1
        SampleQty   % Number of Samples to Record - default: 5
        timestamp   % Time of data collection
        datapoint   % Datapoint for upload to Course Database
    end

    properties (Access = private)
        Device      % Serial Connection to UV sensor
    end

    % Create methods that allows for functions/operations in class
    methods
        function obj = UVsensor(port,NUEmail)
            % Creates a UV sensor object to handle reading UV data from a connected UV Sensor Module. 
            %
            % See class level comments for details on creating the object.
            %

            if nargin == 2
                % Record the Student ID information
                obj.StudentID = NUEmail;
                % Recieve the port information and establish connection
                obj.PortName = port;
                % Set default NU Location
                obj.Latitude = 42.3398;
                obj.Longitude = -71.0892;
                % Set initial experiment settings
                obj.SampleRate = 1;
                obj.SampleQty = 5;
                % Connect to serial port at baud rate 9600
                obj.Device = serialport(obj.PortName,9600);
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

        % Establish experiment settings
        function obj = UVexpsettings(obj, SR, NS)
            % Define the experiment settings of Sample Rate and Number of Samples
            %
            % A.UVexpsettings(SR,NS) will update the experimental
            % settings of the object (A) by redefining the values of the Sample Rate (SR) and
            % the Number of Samples (NS) collected during testing. The
            % default sample rate is 1 Hertz and the default number of
            % samples is 5. This will effect the time period over which the
            % UV levels will be collected and averaged.
            %

            obj.SampleRate = SR;
            obj.SampleQty = NS;
        end

        % Establish experiment location
        function obj = UVlocation(obj,m,n)
            % Establishes the sensor location via MATLAB mobile or manual entry
            %
            % UVLocation will record the latitude and longitude associated
            % with the object based on either using the sensor in your
            % cellphone when MATLAB mobile position data is enabled or
            % through manual entry.
            %
            % m = mobiledev will connect to your mobile device if connected
            % to your MATLAB account and position data is turned on in the
            % settings of your MATLAB mobile app.
            % A.UVLocation(m) will then automatically connect to your
            % MATLAB mobile object (m) and record the latitude and
            % longitude values, assigning them to the associated
            % properties in the UV sensor object (A)
            %
            % A.UVlocation(Lat,Lon) will manually enter the latitude (Lat)
            % and longitude (Lon) values into the UV sensor object (A)
            % properties. Only to be used if their are issues connecting to
            % the MATLAB mobile app and your exact GPS location is known via
            % other means.
            %

            if nargin == 3
                % if 3 are given, then it's manual entry of the location
                display("Manual location input");
                obj.Latitude=m;
                obj.Longitude=n;
            else
                % if given just the MATLAB object
                % Create MATLAB Mobile object connection
                % (use mobiledevlist in command window to
                % find your phone if there are multiple connected on your account)
                % Make sure that the MATLAB Mobile app is open on your phone
                % m = mobiledev;
                % Enable position sensor
                m.PositionSensorEnabled = 1;
                % Make sure that the position sensor on you phone is enabled, begin logging
                m.Logging = 1;
                % Counter
                i=0;
                pause(1);
                % While loop to gather a certain amount of data points (2 points)
                while i < 5
                    % Store logged position data [latitude, longitude, speed, course, altitude, horizontal accuracy]
                    [lat, lon] = poslog(m);
                    % Check number of values in one of the arrays
                    i = numel(lat);
                end
                % Stop logging
                m.Logging = 0;
                % Disable position sensor
                m.PositionSensorEnabled = 0;
                obj.Latitude=mean(lat);
                obj.Longitude=mean(lon);
            end
        end

        % Collect UV sample
        function obj = UVsample(obj)
            % Collects and records data from the UV sensor module
            %
            % A.UVsample() opens a serial connection along the object port
            % to communicate with the sensor module. It sends a request for
            % a specified number of samples taken at the specified sample
            % rate. The sensor module returns a stream of the requested 
            % samples for the UVA level, UVB level, and UV index. The
            % averages of those values are recorded in the object
            % properties as the latest UV data. 
            % 
       
            samplerate = obj.SampleRate;
            numSamples = obj.SampleQty;

            % function to be passed to callback that will save the data
            function readData(src, ~)
                % Read the ASCII data from the serialport object.
                data = readline(src);

                % Convert the string data to numeric type and save it in 
                % the UserData property of the serialport object.
                strdat = split(data,',');
                src.UserData.Data.UVA(end+1) = str2double(strdat(1));
                src.UserData.Data.UVB(end+1) = str2double(strdat(2));
                src.UserData.Data.UVIndex(end+1) = str2double(strdat(3));

                % If numSamples data points have been collected from the 
                % UV sensor module, switch off the callbacks and save the data.
                if src.UserData.Count >= numSamples
                    writeline(src,"end sampling");
                    pause(1);
                    configureCallback(src, "off");
                    disp("Logging complete!");
                    flush(src);
                    uiresume;
                    close(1);
                else
                    % Update the Count value of the serialport object
                    src.UserData.Count = src.UserData.Count + 1;
                end
            end

            obj.Device.UserData = [];

            % Establish Data structures for the raw Arduino feed
            uvstruct = struct("UVA",[],"UVB",[],"UVIndex",[]);
            obj.Device.UserData = struct("Data",uvstruct,"Count",1);

            flush(obj.Device);
            pause(1);

            % Tell arduino the sampling rate
            writeline(obj.Device, "sample rate");
            pause(2);
            writeline(obj.Device, string(samplerate));
            pause(1);

            % Start sampling
            writeline(obj.Device, "begin sampling");
            configureCallback(obj.Device,"terminator",@readData);

            % UI stuff
            % Set figure position
            f = figure('Position',[500 500 400 100]);
            % Set figure dimensions
            dim = [.25 .25 .5 .5];
            % Put wait phrase in figure
            str = 'Please wait, collecting data...';
            % Create figure with specified settings
            annotation('textbox',dim,'String',str,'FitBoxToText','on');
            % Get rid of menu and toolbar
            set(f, 'MenuBar', 'none');
            set(f, 'ToolBar', 'none');
            % Wait until resume
            uiwait(f);

            % Convert Data cells to averages
            % Separate data points
            datastruct=struct2cell(obj.Device.UserData);
            uvadata=cellstr(erase(erase(mat2str(datastruct{1,1}.UVA),"]"),"["));
            uvbdata=cellstr(erase(erase(mat2str(datastruct{1,1}.UVB),"]"),"["));
            uvidata=cellstr(erase(erase(mat2str(datastruct{1,1}.UVIndex),"]"),"["));
            % samplenum=datastruct(2,1);
            obj.timestamp = datetime;
            obj.UVA = mean(str2num(cell2mat(uvadata)));
            obj.UVB = mean(str2num(cell2mat(uvbdata)));
            obj.UVindex = mean(str2num(cell2mat(uvidata)));
        end

        % Check current data point
        function obj = UVdatapoint(obj)
            % Set up and review single data point to be exported to database
            % 
            % A.UVdatapoint() organizes the object(A) properties into a form
            % for upload to the database. It displays it the organized
            % datapoint to the user and asks whether or not to accept that
            % datapoint. If accepted, the organized datapoint is saved in
            % preparation for uploading to the database. If not, that
            % property is cleared. 
            %

            DP = table(obj.timestamp,obj.UVA,obj.UVB,obj.UVindex, ...
                obj.SampleRate,obj.SampleQty,obj.Latitude,obj.Longitude,...
                'VariableNames',{'Timestamp', 'uva', 'uvb', 'uvindex',...
                'frequency', 'samplenum', 'latitude', 'longitude'});

            % Show datapoint that is going to be collected
            disp(DP);
            C = input("Accept datapoint? Y or N");
            if C == 'Y'
                obj.datapoint = DP;
            else
                obj.datapoint = [];
            end
        end

        % Upload data point
        function UVupload(obj)
            % Uploads datapoint to the course database
            %
            % A.UVupload() opens a connection to the database. If
            % successful and there is an accepted datapoint in the
            % object(A), that datapoint is uploaded to the database and
            % then cleared from the datapoint.
            %

            if isempty(obj.datapoint)
                disp("Use UVdatapoint() first to confirm the datapoint before upload.")
            else
                % Make connection to database
                conn = MLDBConn;
                % Test connection (empty brackets = successful connection)
                if isempty(conn.Message)
                    % Append to existing table (uv table created in test database)
                    % sqlwrite(conn,'uv3',obj.datapoint)
                    [y,m,d]=ymd(obj.timestamp);
                    X2 = obj.datapoint(:,2:end);
                    X1 = table(obj.StudentID,y,m,d,hour(obj.timestamp), ...
                        'VariableNames',{'StudentID','year','month','day','hour'});
                    X = [X1,X2];
                    sqlwrite(conn,'UV2022',X);
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
        function DS = UVdata()
            % Retrieves full course dataset of UV sensor module data
            %
            % X = UVsensor.UVData() will download a dataset containing all of the
            % datapoints collected using the UV sensor modules around the 
            % Northeastern University campus, loading them into X as a
            % matrix of doubles. The columns are in the following order:
            % year, month, day, hour, UVA level, UVB level, UV Index,
            % latitude, longitude, sampling frequency(Hz), # of Samples
            %

            % Establish database connection
            conn = MLDBConn;
            % Test connection (empty brackets = successful connection)
            if isempty(conn.Message)
                query = 'SELECT year,month,day,hour,uva,uvb,uvindex,latitude,longitude,frequency,samplenum FROM test.UV2022';
                % Execute query and fetch results
                DS = fetch(conn,query);
                close(conn);
            else
                disp("Database connection error")
            end

        end

        % Runs a demo of geobubble plotting the data
        function GeoDemo(X)
            % Creates a geographic bubble chart of the course data. 
            %
            % UVsensor.GeoDemo() will download the latest course dataset
            % and generate the bubble chart using the UV index values. The
            % circle size is based on relative magnitude of the values. Each 
            % is color coded based on the time of day it was collected.  
            % UVsensor.GeoDemo('uva') uses the UVA level values.
            % UVsensor.GeoDemo('uvb') uses the UVB level values. 
            %


            % Handle the default case
            if nargin == 0
                X = 'uvi';
            end

            % Retrieve Raw Data from Database
            rawdata = UVsensor.UVdata;

            % Extract necessary Table Columns
            Lat = table2array(rawdata(:,'latitude'));
            Lon = table2array(rawdata(:,'longitude'));
            UVA = table2array(rawdata(:,'uva'));
            UVB = table2array(rawdata(:,'uvb'));
            UVI = table2array(rawdata(:,'uvindex'));
            H   = table2array(rawdata(:,'hour'));

            % Bin hours into categories
            for i = 1:length(H)
                if H(i,1) < 9
                    HC(i,1) = 1;
                elseif H(i,1) < 11
                    HC(i,1) = 2;
                elseif H(i,1) < 13
                    HC(i,1) = 3;
                elseif H(i,1) < 15
                    HC(i,1) = 4;
                elseif H(i,1) < 17
                    HC(i,1) = 5;
                elseif H(i,1) < 19
                    HC(i,1) = 6;
                else
                    HC(i,1) = 7;
                end
            end

            % Create categorical array and assign labels
            HC = categorical(HC,[1 2 3 4 5 6 7],...
                {'Before 9AM','9AM-11AM','11AM-1PM',...
                '1PM-3PM', '3PM-5PM', '5PM-7PM', 'After 7PM'});

            % Rebuild into datatable as required by geoplot
            Data = table(Lat,Lon,UVA,UVB,UVI,HC);

            % Define what data will be displayed
            if strcmp(X,'uva')
                gb = geobubble(Data.Lat,Data.Lon,Data.UVA,Data.HC);
                LT = 'UVA Level';
            elseif strcmp(X,'uvb')
                gb = geobubble(Data.Lat,Data.Lon,Data.UVB,Data.HC);
                LT = 'UVB Level';
            else
                gb = geobubble(Data.Lat,Data.Lon,Data.UVI,Data.HC);
                LT = 'UV Index';
            end

            geolimits(gb,[42.334 42.342],[-71.091 -71.085]);
            gb.SizeLegendTitle = LT;
            gb.ColorLegendTitle = 'Time of Day';
            gb.Title = 'UV data collected on NU Campus';
        end
    end


end
