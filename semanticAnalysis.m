% This program takes string input and performs matrix operations to find
% relationships between words in a passage. 
% The goal of this program is to find relationships in the app description
% and possiblity in the additional information box.
% This program will be ported to python when used in App4Tht.
% Written by Brian Nguyen

% Makes an empty cell array based on text input
fileID = fopen('instagramDescription.txt');
textMatrix = textscan(fileID,'%s');
textVector = textMatrix{1,1};
fclose(fileID);
semanticMatrix = cell(size(textVector,1),2);
indexVector = cell(size(textVector,1),1);
indexOfTrue = 1;

% Instagram Update Description
noteID = fopen('instagramUpdateNote.txt');
noteMatrix = textscan(noteID,'%s');
noteVector = noteMatrix{1,1};
noteIndexVector = cell(size(noteVector,1),1);
fclose(noteID);

% Loops through the textVector and finds unique words in the passage and
% puts it in semanticMatrix along with the number of occurences in the
% passage.
for index = 1 : size(textVector,1)
    textWord = textVector{index};
    % Checks if there is a blank in the matrix because some entries were
    % cleared
    if(~strcmp(textWord,''))
        % This for loop replaces strfind since strfind finds strings within
        % other strings. I do not want to find strings within other
        % strings, so I am comparing the whole string with another whole
        % string.
        for vectorIndex = 1:size(indexVector,1)
            if(strcmp(textWord,textVector{vectorIndex,1}))
                indexVector{vectorIndex,1} = 1;
            end
        end
        nonZeroIndexVector = cell2mat(indexVector);
        semanticMatrix{index,1} = textWord;
        semanticMatrix{index,2} = size(nonZeroIndexVector,1);
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
            textVector{trueIndex{deleteIndex,1},1} = '';
        end
        % Clears indexVector
        indexVector = cell(size(textVector,1),1);
    end
end
noteWordIndex =  size(indexVector,1) + 1;
for noteIndex = 1 : size(noteVector,1)
    noteWord = noteVector{noteIndex,1};
     if(~strcmp(noteWord,''))
        for noteVectorIndex = 1:size(noteIndexVector,1) 
            if(strcmp(noteWord,noteVector{noteVectorIndex,1}))
                noteIndexVector{noteVectorIndex,1} = 1;
            end
        end
     nonZeroIndexVector = cell2mat(noteIndexVector);
     semanticMatrix{noteWordIndex,3} = size(nonZeroIndexVector,1);
     semanticMatrix{noteWordIndex,1} = noteWord;
     noteWordIndex = noteWordIndex + 1;
     end
     % Clears noteVector
     noteIndexVector = cell(size(noteVector,1),1);
end
% Removes entries with blanks
semanticMatrix(all(cellfun(@isempty,semanticMatrix),2),:) = [];

%{
% Data Transformation through logs
numericSemantic = cell2mat(semanticMatrix(:,2));
semanticMatrix(:,2) = num2cell(log2(numericSemantic));
entropy = -1 .* numericSemantic .* log2(numericSemantic);
%semanticMatrix(:,2) = num2cell(cell2mat(semanticMatrix(:,2)) ./ entropy);
[i,j,k] = svd(cell2mat(semanticMatrix(:,2)));

%}
