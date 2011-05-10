
listOfFiles = dir('../data/images');
listOfFiles = listOfFiles(3:size(listOfFiles, 1));

prevsplit = '';
display('BEGIN');

groupIndices = zeros(11, 1);

j =1;

for i=1:size(listOfFiles,1)

    split = regexp(listOfFiles(i).name, ' ', 'split');
    
    if (strcmp(prevsplit,split(1)) == 0)
        groupIndices(j) = i;
        j = j + 1;
        display(split(1));
        prevsplit = split(1);
    end
    
end

display('END');