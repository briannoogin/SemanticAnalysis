% This function find the frequency of words in the documents and puts it in
% the input matrix.
% By Brian Nguyen
function [outputMatrix] = countOccurences(inputMatrix,documentStruct)
occurenceVector = zeros(size(inputMatrix,1),size(inputMatrix,2)-1);
% Loops through all words in the inputMatrix
for matrixIndex = 1:size(inputMatrix,1)
desiredWord = inputMatrix{matrixIndex,1};
    % Loops through all documents in the structure
    for structureIndex = 1 : size(documentStruct,2)
       % Loops through all rows in the document matrix
        for documentIndex = 1 : size(documentStruct(structureIndex).File,1);
            if(strcmp(desiredWord, documentStruct(structureIndex).File{documentIndex,1}))
             % Adds one to the cell in the occurence vector if word is found
             occurenceVector(matrixIndex,structureIndex) = occurenceVector(matrixIndex,structureIndex) + 1;
            end
       end
    end
end
inputMatrix(:,2:structureIndex+1) = num2cell(occurenceVector);
outputMatrix = inputMatrix;