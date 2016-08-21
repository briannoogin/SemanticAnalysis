% This program takes string input and performs matrix operations to find
% relationships between words in a passage. 
% The goal of this program is to find relationships in the app description
% and possiblity in the additional information box.
% This program will be ported to python when used in App4Tht.
% Written by Brian Nguyen

% Pre-allocates memory to semanticMatrix
semanticMatrix = cell(0,0);

% Holds all the document names and the text files
documentStruct = struct('Name','','File',0);

% Documents
documentStruct(1).Name = 'facebook.txt';
documentStruct(2).Name = 'instagram.txt';
documentStruct(3).Name = 'googleplus.txt';
documentStruct(4).Name = 'chrome.txt';
documentStruct(5).Name = 'snapchat.txt';
documentStruct(6).Name = 'fbmessenger.txt';
documentStruct(7).Name = 'viber.txt';
documentStruct(8).Name = 'skype.txt';
documentStruct(9).Name = 'pinterest.txt';
documentStruct(10).Name = 'tumblr.txt';
documentStruct(11).Name = 'tinder.txt';
documentStruct(12).Name = 'twitter.txt';
documentStruct(13).Name = 'periscope.txt';
documentStruct(14).Name = 'vine.txt';
documentStruct(15).Name = 'reddit.txt';
documentStruct(16).Name = 'wordswithfriends.txt';
documentStruct(17).Name = 'dubsmash.txt';
documentStruct(18).Name = 'youtube.txt';
documentStruct(19).Name = 'askfm.txt';
documentStruct(20).Name = 'pokemongo.txt';
documentStruct(21).Name = 'quora.txt';

% Loops thorugh all the documents and add them to the matrix
for documentIndex = 1 : size(documentStruct,2)
[text,semanticMatrix] = inputText(documentStruct(documentIndex).Name,semanticMatrix);
documentStruct(documentIndex).File = text;
end

% Counts frequency of words
[semanticMatrix] = countOccurences(semanticMatrix,documentStruct);

% Data Transformation
numericSemantic = cell2mat(semanticMatrix(:,2:size(semanticMatrix,2)));
numericSemantic = numericSemantic + ones(size(numericSemantic,1),size(numericSemantic,2));
numericSemantic = log2(numericSemantic);

%entropy = -1 .* numericSemantic .* log2(numericSemantic);
%semanticMatrix(:,2) = num2cell(cell2mat(semanticMatrix(:,2)) ./ entropy)

% Singular Value Decomposition and Matrix Manipulation 
[u,s,v] = svd(numericSemantic);
vs =  v*s.';
% Keeps only the first 5 singular values and calculates the reconstructed
% matrix
reducedS = s;
reducedS(:,6:size(s,2)) = zeros(size(s,1),size(s,2)-5);
changedX = u * reducedS * v';
wordLabels = semanticMatrix(:,1);
changedSemantic = [wordLabels,num2cell(changedX)];
correlationMatrix = changedX.'*changedX;