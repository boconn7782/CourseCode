function [ Minefield ] = MFGenerator(N,M)
% Minefield generator
% This function accepts 2 values: N, M
% N is the number of rows
% M is the number of columns
% This generates an N x M array with one listed as a bomb
   
% Create NxM array of o's
TempMF(N,M) = 'o'; % Create the last one to set the matrix size
for i = 1:N
    for j = 1:M
        TempMF(i,j) = 'o'; % Set everyone to o
    end
end

X = randi(M);       % Pick a random Column
Y = randi(N);       % Pick a random Row

TempMF(Y,X)='X';  % Set that space to be the bomb, ie = X

Minefield=TempMF;
end
