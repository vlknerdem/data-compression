clear;clc;
fopened = fopen('Chapter22.txt', 'rt'); % Read text from file as characters
[a] = fread(fopened,'*char');
% [a] = textread('book.txt','%c');
% Write a matrix each character, disable because of new line and space character
a_sorting = sort(a); % Sorting the all characters due to ASCII
double_a = double(a_sorting); % Convert symbolic numbers to double precision
 
 
[occurrence,k] = histc(a_sorting,unique(a_sorting)); % Find the occurrence of each character
b = occurrence(k);
% All characters write in order to ASCII one time, to reconstruct with the occurance
c = length(a_sorting);
for i = c:-1:2
    if a_sorting(i) == a_sorting(i-1);
        a_sorting(i) = [];
    end
    if double_a(i) == double_a(i-1);
        double_a(i) = [];
    end
end; 
for j = 1:length(occurrence)
    character_p(j) = occurrence(j)/length(b); % Find probability of each character
    character_e(j) = character_p(j)*log2(1/character_p(j)); % Find Entropy of each character
end

for j = 1:length(occurrence)
    character_p(j) = occurrence(j)/length(b); % Find probability of each character
end
for index = 1:length(character_p)
    codeword{index} = []; % creating an empty codeword for each probablities
    setofcodeword{index} = index; % Create a set containing only this codeword
    setofprobability(index) = character_p(index); % Store the probability associated with this set
end

while length(setofcodeword) > 3
       
    [temp, sort_p] = sort(setofprobability); % Determine which sets have the lowest total probabilities
    if length(sort_p) == 2
    
        first_set = setofcodeword{sort_p(1)}; % Get the set having the lowest probability
        first_p = setofprobability(sort_p(1)); % Get that probability
        for indexofcodeword = 1:length(first_set) % For each codeword in the set...
            codeword{first_set(indexofcodeword)} = [codeword{first_set(indexofcodeword)}, 0]; % ...append a zero      
        end
        second_set = setofcodeword{sort_p(2)}; % Get the set having the second lowest probability
        second_p = setofprobability(sort_p(2)); % Get that probability
        for indexofcodeword = 1:length(second_set) % For each codeword in the set...
            codeword{second_set(indexofcodeword)} = [codeword{second_set(indexofcodeword)}, 1]; % ...append a one       
        end
          
        setofcodeword(sort_p(1:2)) = [];% Remove the two sets having the lowest probabilities...
        setofcodeword{length(setofcodeword)+1} = [first_set, second_set]; % ...and merge them into a new set
    
        setofprobability(sort_p(1:2)) = []; % Remove the two lowest probabilities...
        setprobability(length(setofprobability)+1) = first_p + second_p; % ...and give their sum to the new set
        
    end 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%IMPORTANT EXPLAIN%%%%%%%%%%%%%%%%5
    %This is Huffman ternary coding. Text file has 68 different characters 
    %so we need a null probablity to ternary coding. 
    %At the last turn of loop, array has 2 element so I used if else. 
    %When the array has 2 elements, it gets in if block. 
    %In if block, we can calculate as a binary huffman coding 
    %because probablity of null is 0 . 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    
    first_set = setofcodeword{sort_p(1)}; % Get the set having the lowest probability
    first_p = setofprobability(sort_p(1)); % Get that probability
    for indexofcodeword = 1:length(first_set) % For each codeword in the set...
        codeword{first_set(indexofcodeword)} = [codeword{first_set(indexofcodeword)}, 0]; % ...append a zero      
    end
    second_set = setofcodeword{sort_p(2)}; % Get the set having the second lowest probability
    second_p = setofprobability(sort_p(2)); % Get that probability
    for indexofcodeword = 1:length(second_set) % For each codeword in the set...
        codeword{second_set(indexofcodeword)} = [codeword{second_set(indexofcodeword)}, 1]; % ...append a one       
    end
    third_set = setofcodeword{sort_p(3)}; % Get the set having the second lowest probability
    third_p = setofprobability(sort_p(3)); % Get that probability
    for indexofcodeword = 1:length(third_set) % For each codeword in the set...
        codeword{third_set(indexofcodeword)} = [codeword{third_set(indexofcodeword)}, 2]; % ...append a one       
    end 
    
    setofcodeword(sort_p(1:3)) = [];% Remove the two sets having the lowest probabilities...
    setofcodeword{length(setofcodeword)+1} = [first_set, second_set,third_set]; % ...and merge them into a new set
    
    setofprobability(sort_p(1:3)) = []; % Remove the two lowest probabilities...
    setofprobability(length(setofprobability)+1) = first_p + second_p + third_p; % ...and give their sum to the new set
end
   
disp('Probabilities and the allocated Huffman codewords of symbols are:');
for index = 1:length(codeword) % For each codeword...
    disp([a_sorting(index), '    ',num2str(index), '    ', num2str(character_p(index)),'    ',num2str(codeword{index}(length(codeword{index}):-1:1))]); % ...display its bits in reverse order
end

% Calculate the average Huffman codeword length
average_H_length = 0;
for index = 1:length(codeword)
    average_H_length = average_H_length + character_p(index)*length(codeword{index});
end

disp(['The average Huffman codeword length is:',num2str(average_H_length)]);

average_H_length = 0;
for index = 1:length(codeword)
    average_H_length = average_H_length + character_p(index)*length(codeword{index});
end
 
disp(['The average Huffman codeword length is:',num2str(average_H_length)]);

asc=str2double(codeword);
num_of_dist_chars=length(a_sorting);
C{1, num_of_dist_chars} = [];
for i = 1:num_of_dist_chars
   C{1, i} = a_sorting(i);
end 
text_length = length(a);
C_text{1, text_length} = [];
for i = 1:text_length
    C_text{1, i} = a(i);
end

%%%TERNARY HUFFMANN

[dict, avglen] = huffmandict(C, character_p, 3); % find huffman dictionary

comp = huffmanenco(C_text, dict); % encode with binary huffman

input = dec2bin(a);
size_before_comp = numel(input);

decoded = dec2bin(comp);
size_after_comp = numel(decoded);

rate_ternary = size_after_comp / size_before_comp;

fprintf('\nSize before compresion of Ternary Huffman = %f\n',size_before_comp);
fprintf('\nSize after compresion of Ternary Huffman = %f\n',size_after_comp);
fprintf('\nCompress Rate of Ternary Huffman = %f\n',rate_ternary);
