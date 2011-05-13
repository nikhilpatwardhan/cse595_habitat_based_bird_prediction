function acc=calcAccForAll

% load '../matfiles/finalPyramids.mat';
load '../matfiles/classifiers.mat';
load '../matfiles/groupIndices.mat';
load '../matfiles/finalGists.mat';
% load '../matfiles/allColor.mat';

% load '../matfiles/modelNames.mat';

acc = zeros(length(finalGists),1);

for i=1:length(finalGists)
%     acc(i) = calcAccuracyPyramid(i, pyramids, classifiers, model_names, 0.5);
    acc(i) = calcAccuracyPyramid(i, finalGists, classifiers, model_names, 0.5);

end

save(sprintf('../matfiles/accuracies.mat'), 'acc');