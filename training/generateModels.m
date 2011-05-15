function generateModels(features,log2c,log2g,p)
%% This function takes as input features (like gist) for images and builds
%% an SVM based on the C and g values whose logarithms are passed as arguments.
%% p is the ratio of training to testing images. Usually it is 0.7
load '../matfiles/groupIndices.mat';
% load '../matfiles/kernel.mat';
% load '../matfiles/pyramid_all.mat';

% addpath('../utils/libsvm-mat-3.0-1/');
addpath('../utils/spatial_pyramid/');

numOfModels = size(model_names, 2);
labels = cell(1, numOfModels);

for i=1:numOfModels
    labels{i} = zeros(categorySize{i},1);
end

classifiers = cell(1, numOfModels);

% cmd = ['-c ', num2str(2^log2c), ' -g ', num2str(2^log2g), ' -b 1'];
for i=1:numOfModels
    testLabels = labels;
    testLabels{i}(:) = 1;
    [ts, tl] = createTrainingSets(p, i, features, categorySize, testLabels);
%     classifiers{i} = svmtrain(tl', ts', cmd);         % For using c/g
    classifiers{i} = svmtrain(tl', ts', '-t 4 -b 1'); % Intersection Kernel
%     classifiers{i} = svmtrain(tl', ts', hist_isect(pyramid_all, pyramid_all));
end

save('../matfiles/classifiers.mat', 'classifiers');