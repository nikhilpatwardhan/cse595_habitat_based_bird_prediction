%% Combines the GIST and Color Histograms to give a single concatenated
%% histogram per image
load '../../matfiles/groupIndices.mat';

% Load the color histograms
load '../../matfiles/allColor.mat';

% Load the GIST histograms
load '../../matfiles/finalGists.mat'

colorgist = cell(1,length(categorySize));
for i=1:length(categorySize)
    h = newHist{i};
    g = finalGists{i};
    h = h';
    g = g';
    f = [h;g];
    colorgist{i} = f';
end;

save('../../matfiles/colorgist.mat','colorgist');