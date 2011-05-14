function acc=calcAccForAll(features,p)

% load '../matfiles/finalPyramids.mat';
load '../matfiles/classifiers.mat';
load '../matfiles/groupIndices.mat';
% load '../matfiles/finalGists.mat';
% load '../matfiles/allColor.mat';
% load '../matfiles/colorgist.mat';

% load '../matfiles/modelNames.mat';

% len = length(finalGists);
% len = length(newHist);
len = length(features);

acc = zeros(len,1);

for i=1:len
%     acc(i) = calcAccuracyPyramid(i, pyramids, classifiers, model_names, 0.5);
%     acc(i) = calcAccuracyPyramid(i, finalGists, classifiers, model_names, 0.5);
%     acc(i) = calcAccuracyPyramid(i, newHist, classifiers, model_names,
%     0.5);
%     acc(i) = calcAccuracyPyramid(i, colorgist, classifiers, model_names, p);
    acc(i) = calcAccuracyPyramid(i, features, classifiers, model_names, p);
end

acc = acc * 100;
save(sprintf('../matfiles/accuracies.mat'), 'acc');