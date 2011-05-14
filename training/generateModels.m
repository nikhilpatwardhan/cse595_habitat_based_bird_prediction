function generateModels(features,log2c,log2g,p)

% load '../matfiles/finalPyramids.mat';
% load '../matfiles/finalPyramidLengths.mat';
% load '../matfiles/modelNames.mat';
load '../matfiles/groupIndices.mat';
% load '../matfiles/finalGists.mat';
% load '../matfiles/allColor.mat';
% load '../matfiles/colorgist.mat';

addpath('../utils/libsvm-mat-3.0-1');

numOfModels = size(model_names, 2);
labels = cell(1, numOfModels);

for i=1:numOfModels
    labels{i} = zeros(categorySize{i},1);
end

classifiers = cell(1, numOfModels);

cmd = ['-c ', num2str(2^log2c), ' -g ', num2str(2^log2g), ' -b 1'];
for i=1:numOfModels
%     disp(i);
    testLabels = labels;
    testLabels{i}(:) = 1;
%     [ts, tl] = createTrainingSets(p, i, pyramids, pyramidLengths,
%     testLabels);
%     [ts, tl] = createTrainingSets(p, i, finalGists, categorySize, testLabels);
%     [ts, tl] = createTrainingSets(p, i, newHist, categorySize, testLabels);
%     [ts, tl] = createTrainingSets(p, i, colorgist, categorySize, testLabels);
    [ts, tl] = createTrainingSets(p, i, features, categorySize, testLabels);
    classifiers{i} = svmtrain(tl', ts', cmd);
end

save('../matfiles/classifiers.mat', 'classifiers');