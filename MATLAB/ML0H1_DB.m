%% Database Support function for MATLAB Lab #0 Homework 1
% Inputs: 
%   Northeastern Email address
%   First Name
%   Last Name
%   Favorite Avenger
%   
% Outputs:
%   Table of class data with following columns:
%    | Date Registered | Favorite Avenger |
%
% Example Use: 
%   E = <Student's Northeastern Email Address>
%   F = <Student's First Name >
%   S = <Student's Last Name >
%   A = <Student's Favorite Avenger >
%   X = ML0H1_DB(E, F, S, A)
%   X =
% 
%       12×2 table
% 
%              date_registered               Avenger      
%         _________________________    ___________________
%   
%         {'2021-06-15 18:48:21.0'}    {'Hawkeye'        }
%           ...                         ...
% 
% This function connects to the course database table
% for this assignment and adds your student information
% and selected Avenger from the Marvel Cinematic Universe.
% It extracts a table where each row is the timestamp for
% the student's first successful upload to the database and
% their favorite avenger, returning it to the program as
% the function's output. 
% These will eventually be saved as pcode to limit new
% content for the students as well as help protect the
% database and the individual tables.

function data = ML0H1_DB(EMail, FName, LName, Avenger)
%% Create Connection to the database
% Uses an external function to secure database information
conn = MLDBConn;

%% Uploading Individual Datapoint
% Format the post for writing to the database
EMail = lower(EMail);
% Database information
% Table Name
T = 'students'; 
% Columns being added populated
cols1 = {'firstname' 'surname' 'email' 'Avenger'}; 
% Data for populating
data = {FName, LName, EMail, Avenger};
DP = cell2table(data, 'VariableNames', cols1);

% Write the post to the database.
try
    sqlwrite(conn,T,DP)
catch
    % In this case, the error is a possible duplicate entry. 
    % Try/catch with a Warning is used to keep that error from
    % stopping the script since we'll just update instead.
    warning('Duplicate entry '''+ EMail + ''' for key ''email''.'+...
        'The database table for this assignment has a restriction'+...
        'to only allow for unique email addresses. A new row was '+...
        'not created but rather your Previous entry updated with '+...
        'any updated data to reduce database size and simplify'+...
        'this student reference table.')
    whereclause = 'WHERE email = '''+EMail+''' ';
    update(conn,T,cols1,data,whereclause)
end

%% Check upload

% Pull the last line from the database. 
Q1 = strcat('SELECT SID, date_registered, ',...
    strjoin(""+cols1,", "),...
    ' FROM test.',T,...
    ' WHERE email = ''',EMail,''' ');
data = fetch(conn,Q1);
disp(data);

%% Download Data Set

cols2 = {'date_registered' 'Avenger'};
Q2 = strcat('SELECT ', strjoin(" "+cols2,","),...
    ' FROM test.',T);
% Pull the appropriate data for the assignment.
% These queries will end up being lab specific.
data = fetch(conn,Q2);

end
