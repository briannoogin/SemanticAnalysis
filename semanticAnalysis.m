% This program takes string input and performs matrix operations to find
% relationships between words. 
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

% Loops through the textVector and finds unique words in the passage and
% puts it in semanticMatrix along with the number of occurences in the
% passage.
for index = 1 : size(textVector,1)
    word = textVector{index};
    % Checks if there is a blank in the matrix because some entries were
    % cleared
    if(~strcmp(word,''))
        % This for loop replaces strfind since strfind finds strings within
        % other strings. I do not want to find strings within other
        % strings, so I am comparing the whole string with another whole
        % string.
        for vectorIndex = 1:size(indexVector,1)
            if(strcmp(word,textVector{vectorIndex,1}))
                indexVector{vectorIndex,1} = 1;
            end
        end
        nonZeroIndexVector = cell2mat(indexVector);
        semanticMatrix{index,1} = word;
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
        indexVector = cell(size(textVector,1),1);
    end
end

