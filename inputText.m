% This function handles the input of text.
% By Brian Nguyen
function [outputMatrix] = inputText(textName,inputMatrix)
% Scans the text file
fileID = fopen(textName);
scanMatrix = textscan(fileID,'%s');
numberOfDocuments = size(inputMatrix,2);
textVector = scanMatrix{1,1};
textVector(:,2:numberOfDocuments) = cell(size(textVector,1),numberOfDocuments-1);
fclose(fileID);

% Adds the new passage to the matrix
textMatrix = cat(1,inputMatrix,textVector);
% Takes the original size of the inputMatrix and adds an extra column for
% the new dataset
outputMatrix = cell(size(textMatrix,1),size(textMatrix,2) + 1);
indexVector = cell(size(textMatrix,1),1);

% Loops through the textMatrix and finds unique words in the passage and
% puts it in the outputMatrix.
for index = 1 : size(textMatrix,1)
    textWord = textMatrix{index,1};
    % Checks if there is a blank in the matrix because some entries were
    % cleared
    if(~strcmp(textWord,''))
        % This for loop replaces strfind since strfind finds strings within
        % other strings. I do not want to find strings within other
        % strings, so I am comparing the whole string with another whole
        % string.
        for vectorIndex = 1:size(indexVector,1)
            if(strcmp(textWord,textMatrix{vectorIndex,1}))
                indexVector{vectorIndex,1} = 1;
            end
        end
        nonZeroIndexVector = cell2mat(indexVector);
        outputMatrix{index,1} = textWord;
        trueIndex = cell(size(nonZeroIndexVector,1),1);
        indexOfTrue = 1;
        % Loops through the indexVector and finds nonzeros which corresponds to
        % the index of an occurence of a word.
        for indexOfNonEmpty = 1:size(indexVector)
            if(~isempty(indexVector{indexOfNonEmpty}))
                trueIndex{indexOfTrue} = indexOfNonEmpty;
                indexOfTrue = indexOfTrue + 1;
            end  
        end
        % Loops through text vector and clears all the next entries that
        % have the same word.
        for deleteIndex = 1: size(trueIndex)
            textMatrix{trueIndex{deleteIndex,1},1} = '';
        end
        % Clears indexVector
        indexVector = cell(size(textMatrix,1),1);
    end
end
% Clears all blank entries
outputMatrix(all(cellfun(@isempty,outputMatrix),2),:) = [];



    