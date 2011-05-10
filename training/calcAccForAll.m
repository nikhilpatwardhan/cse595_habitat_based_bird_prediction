function acc=calcAccForAll

load '../matfiles/finalPyramids.mat';
load '../matfiles/classifiers.mat';
load '../matfiles/modelNames.mat';

acc = zeros(12,1);

for i=1:12
    acc(i) = calcAccuracyPyramid(i, pyramids, classifiers, model_names, 0.5);
end

save(sprintf('../matfiles/accuracies.mat'), 'acc');