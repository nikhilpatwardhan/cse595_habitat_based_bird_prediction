clear;
load '../matfiles/finalPyramids.mat';
load '../matfiles/classifiers.mat';
load '../matfiles/model_names_no_mountains.mat';

acc = zeros(1,11);

for i=1:11
    acc(i) = calcAccuracyPyramid(i, pyramids, classifiers, model_names, 0.5);
end

save('../matfiles/accuracies.mat', 'acc');