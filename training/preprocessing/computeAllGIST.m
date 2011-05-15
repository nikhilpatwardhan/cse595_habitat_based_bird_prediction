%% Computes normalized GIST histograms for all images in a directory
addpath('../../utils/gist/');

imageDirectory = '../../data/images/';
matDirectory = '../../matfiles/';
findGist(imageDirectory,strcat(matDirectory,'gist.mat'));

load (strcat(matDirectory,'gist.mat'));

% Normalize gist vectors
for i=1:length(gist)
    v = gist(:,i);
    v = v/norm(v,1);
    gist(:,i) = v;
end;

gist = gist';

load (strcat(matDirectory,'groupIndices.mat'));

finalGists = cell(1,length(categorySize));
startRow = 0;
for i=1:length(categorySize)-1
    startRow = groupIndices(i);
    endRow = groupIndices(i+1)-1;
    finalGists{i} = gist(startRow:endRow,:);
end;
finalGists{i+1} = gist(endRow+1:length(gist),:);

save(strcat(matDirectory,'finalGists.mat'),'finalGists');