% This program takes string input and performs matrix operations to find
% relationships between words in a passage. 
% The goal of this program is to find relationships in the app description
% and possiblity in the additional information box.
% This program will be ported to python when used in App4Tht.
% Written by Brian Nguyen
%function semanticAnalysis
semanticMatrix = cell(0,0);
documentStruct = struct('Name','','File',0);
documentStruct(1).Name = 'instagramUpdateNote.txt';
documentStruct(2).Name = 'instagramDescription.txt';
% First Document
[text1,semanticMatrix] = inputText(documentStruct(1).Name,semanticMatrix);
% Second Document
[text2,semanticMatrix] = inputText(documentStruct(2).Name,semanticMatrix);
documentStruct(1).File = text1;
documentStruct(2).File = text2;
[semanticMatrix] = countOccurences(semanticMatrix,documentStruct);
%{
% Find occurences for both passages
occurenceVector = zeros(size(semanticMatrix,1),2);
for textIndex = 1: size(semanticMatrix,1);
    desiredWord = semanticMatrix{textIndex,1};
    % Find occurences for the first passage
    for occurenceIndex = 1:size(textVector,1)
     if(strcmp(desiredWord,textVector{occurenceIndex,1}))
        occurenceVector(textIndex,1) = occurenceVector(textIndex,1) + 1;
     end
    end
    % Find occurences for the second passage
    for secondOccurenceIndex = 1: size(noteVector,1)
     if(strcmp(desiredWord,noteVector{secondOccurenceIndex,1}))
       occurenceVector(textIndex,2) = occurenceVector(textIndex,2) + 1;  
     end
    end
end
semanticMatrix(:,2:3) = num2cell(occurenceVector);

% Data Transformation
numericSemantic = cell2mat(semanticMatrix(:,2:3));
%semanticMatrix(:,2:3) = num2cell(log2(numericSemantic));
%entropy = -1 .* numericSemantic .* log2(numericSemantic);
%semanticMatrix(:,2) = num2cell(cell2mat(semanticMatrix(:,2)) ./ entropy)
[u,s,v] = svd(cell2mat(semanticMatrix(:,2:3)));
vs =  v*s.';
%}