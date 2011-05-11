model_names = {'beach','forests'};
nCategories = length(model_names);

listOfFiles = dir('../data/images/');
listOfFiles = listOfFiles(3:size(listOfFiles, 1));

prevsplit = '';
display('BEGIN');

groupIndices = zeros(nCategories, 1);
categorySize = cell(1,nCategories);

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

for k=1:nCategories
    if (k ~= 1)
        categorySize{k-1} = groupIndices(k) - 1;
    end;
end;
categorySize{k} = i - groupIndices(k) + 1;

display('END');
save('../matfiles/groupIndices.mat','groupIndices','model_names','categorySize');