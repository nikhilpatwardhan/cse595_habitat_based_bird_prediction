%% This is the primary preprocessing step. All the input images are assumed
%% to have prefixes which are listed out in the model_names variable. This
%% script computes how many of each category images exist and what their
%% starting indexes are when the directory contents are listed out.
model_names = {'coasts','deserts','forests','gardens','lakes','mangrove','marshes','mountains','mudflats','oceans','open','urban'};
nCategories = length(model_names);

listOfFiles = dir('../../data/images/');
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

for k=2:nCategories
    categorySize{k-1} = groupIndices(k) - groupIndices(k-1);
end;
categorySize{k} = i - groupIndices(k) + 1;

display('END');
save('../../matfiles/groupIndices.mat','groupIndices','model_names','categorySize');