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
Character = a_sorting;
ASCII = double_a;
Occurance = occurrence;
Probablity = character_p';
Entropy = reshape(character_e,j,1);

%%%%%%%Make a table and show total values

T = table(Character, ASCII, Occurance, Probablity, Entropy)
Total_Occurance = sum(occurrence)
Total_Probability = sum(character_p)
Total_Entropy = sum(character_e)
