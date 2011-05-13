clear;
clc;
addpath('../../utils/gist/');
findGist('../../data/images/','../../matfiles/gist.mat');

load '../../matfiles/gist.mat';
load '../../matfiles/groupIndices.mat';

finalGists = cell(1,length(categorySize));
for i=1:length(categorySize)
    if (i==1)
        finalGists{i} = gist(i:categorySize{i},:);
    else
        finalGists{i} = gist(categorySize{i-1}+1:categorySize{i-1}+categorySize{i},:);
    end;
end;

save('../../matfiles/finalGists.mat','finalGists');